<?php foreach($withdrawList as $row){?>
    <li>
        <span><?=date("Y-m-d", $row->created)?></span>
        <i><?=\common\helpers\Func::param('user_withdraw.status', $row->status);?></i>
        <em class="increase"><?=sprintf('%.2f', $row->txamount)?></em>
    </li>
<?php }?>