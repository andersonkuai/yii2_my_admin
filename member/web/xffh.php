<?php

/**
 * @author blog.anchen8.net
 * @copyright 2017
 */


$b = 10000;
$a = array(

    1,  //消费者
    0.16,//商家
    0.05,//一级
    0.05 * 0.05,//二级
    0.05 * 0.05 * 0.05,//三级
    0.005 //代理
    
);

$c = $b * 0.16 * 0.6;
//echo log( 1 - $c / (1 - 0.13) / ($b * array_sum($a)), (1 - 5/10000) );
//echo "<br/>";

$yfh = 0;
$fhl = 5/10000;

$map = array( '消费者', '商家', '一级','二级','三级', '代理' );

echo '<table>
<caption>消费返还</caption>
<tr><th>天数</th><th>返还率</th><th>返还(元)</th><th>详细(元)</th><th>可返天数</th><tr>';
for( $n=1;$n<=200;$n++ ){
    echo "<tr>";
    //$c = $c - $yfh;
    $l = $c - $yfh;
	
	$nnn = $l ."_". (1 - 0.13) ."_". ($b * array_sum($a));
    $day = log( 1 - $l / (1 - 0.13) / ($b * array_sum($a)), (1 - $fhl) );
    
    if( $day >= 180 ){
        
        
    }else{
        
        $fhl = 1 -   pow(1 - $l / (1 - 0.13) / ($b * array_sum($a)), 1/180);
        $day = log( 1 - $l / (1 - 0.13) / ($b * array_sum($a)), (1 - $fhl) );
        
    }
    $cfh = ($b * array_sum($a) - $yfh) * $fhl * 0.87;
        
    $yfh += $cfh;
    
    echo "<td>{$n}</td><td>{$fhl}<br/>{$nnn}</td><td>{$cfh}</td><td>";
    $nn=0;
    foreach($a as $ii){
        echo $nn == 0 ? "<font color=red>":"";
        echo $map[$nn++] . " " . $cfh * $ii/array_sum($a). ($nn == 1 ? "</font>":""). "<br/>";
    }
    echo "</td><td>{$day}</td></tr>".PHP_EOL;
}
echo "</table>";
?>
<style type="text/css">
thead tr {background-color: ActiveCaption; color: CaptionText;}
th, td {vertical-align: top; font-family: "Tahoma", Arial, Helvetica, sans-serif; font-size: 10pt; padding: 3px; }
table, td {border: 1px solid silver;}
table {border-collapse: collapse;width:80%;}
</style>