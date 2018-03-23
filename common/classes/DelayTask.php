<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/18
 * Time: 11:18
 */

namespace common\classes;

include_once dirname(dirname(__FILE__ )) . "/vendor/autoload.php";
class DelayTask
{
    private static $_instance = null;
    private $_queue = null;
    private $isAlive = false;
    private $beanstalkdConfig = [
        'host' => 'queue-beanstalkd.yunlianmeigou.com',
        'port' => 11300
    ];
    private $taskMap = [];
    private function __construct() {

        $beanstalkdConfig = $this->beanstalkdConfig;
        $this->_queue = new \Pheanstalk\Pheanstalk( $beanstalkdConfig['host'], $beanstalkdConfig['port'] );
        $this->taskMap = DelayTaskProcess::TASK_MAP;
        try{
            $isAlive = $this->_queue->getConnection()->isServiceListening();
            $this->isAlive = $isAlive;
        }catch( \Exception $e){
            exit($e->getMessage());
        }
    }
    private function __clone() {}

    public static function instance() {
        if (is_null ( self::$_instance ) ) {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    public function putToQueue( $taskName, $taskData , $delayTime = 0){
        if(!$this->isAlive) return false;

        if( is_array($taskData) ) $taskData = json_encode($taskData);
        if( !is_string($taskData)) exit( "taskData type error!" );
        if( $delayTime < 0 ) $delayTime = 0;

        return $this->_queue ->useTube( $taskName ) ->put( $taskData, 0,  $delayTime);
    }

    public function getQueue(){
        return $this->_queue;
    }
    public function getIsAlive(){
        return $this->isAlive;
    }
    public function getTaskMap(){
        return $this->taskMap;
    }

    public function put( $taskName, $taskData ){
        if( !key_exists( $taskName, $this->taskMap ) ) exit( "taskName is not allowed!" );
        if( !is_array($taskData) ) exit( "taskData is not correct!" );
        $task = $this->taskMap[$taskName];
        $delayTime = $task['delayTime'];

        $jobId = 0;
        $time = time();
        $data = [
            'taskName'  => $taskName,
            'taskData'  => json_encode($taskData),
            'status'    => 0,
            'delayTime' => $delayTime,
            'runTime'   => $time + $delayTime,
            'addTime'   => $time
        ];
        $model = new \common\models\DelayTask();
        $model->setAttributes($data);
        $rtn = $model->insert();

        if( $rtn ){
            $taskId = $model->id;
            $taskData['__id'] = $taskId;
            $jobId = $this->putToQueue($taskName, $taskData, $delayTime);

            if($jobId){
                $model->taskId = $jobId;
                $model->bid = $this->_queue->stats()->id;
                $model->update();
            }
        }

        return $jobId;
    }
    public function delete($job){
        if(!$this->isAlive) return false;
        try{
            if(is_int($job)){
                $job = $this->_queue->peek($job);
            }
            if(!empty($job)) $this->_queue->delete($job);
            return true;
        }catch( \Exception $e){
            echo $e->getMessage();
        }

        return false;
    }
    public function bury($job){
        if(!$this->isAlive) return false;
        try{
            if(is_int($job)){
                $job = $this->_queue->peek($job);
            }
            if(!empty($job)) $this->_queue->bury($job);
            return true;
        }catch( \Exception $e){
            echo $e->getMessage();
        }

        return false;
    }
}