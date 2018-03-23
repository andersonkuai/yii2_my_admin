<?php foreach($pointList as $row){?>
<li class="info_item">
    <span class="date"><?php echo date("Y-m-d", $row->trade_time)?></span>
    <i class="status_icon"></i>
    <div class="det">
        <p class="<?php echo $row->trade_num > 0 ? 'gain' : 'pain' ?>"><?php echo $row->trade_num > 0 ? "+" . $row->trade_num : $row->trade_num;?></p>
        <p>
            <?php if($pointType == 'white'){
                echo \common\enums\WhitePoint::label($row->trade_type);
            }elseif($pointType == 'red'){
                echo \common\enums\RedPoint::label($row->trade_type);
            }elseif($pointType == 'stock'){
                echo \common\enums\StockPoint::label($row->trade_type);
            }?>
        </p>
    </div>
    <span class="balance"><?php echo $row->trade_afternum?></span>
</li>
<?php }?>