{include file='user/main.tpl'}
	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">資源包購買</h1>
			</div>
		</div>
		<div class="container">
			<div class="col-lg-12 col-sm-12">
				<section class="content-inner margin-top-no">					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>請先選購資源包后再購買增量包，否則將無法使用節點服務</p>
								<p>選購升級包會覆蓋現有賬戶中的套餐，請結合現有套餐情況謹慎購買！</p>
								<p>如賬戶中已存在啓用自動續費的套餐包則直接為賬戶餘額進行充值即可，系統會自動嘗試續費，如額外購買則會覆蓋現有賬戶中的套餐的流量與時長。</p>
								<p>購買新套餐包時，如未關閉舊有套餐自動續費，則舊有套餐的自動續費仍然生效。</p>
								<p>當前賬戶餘額：<code>{$user->money}</code> 元</p>
							</div>
						</div>
					</div>                                    					
					<div class="table-responsive">
						{$shops->render()}
						<table class="table ">
								<tr>
									<th>名稱</th>
									<th>价格</th>
									<th>内容</th>
									<th></th>                
                            </tr>
                            {foreach $shops as $shop}
                            <tr>
										<td>{$shop->name}</td>
										<td>{$shop->price} 元</td>
										<td>{$shop->content()}</td>
										<td>
											<a class="btn btn-brand-accent" href="javascript:void(0);" onClick="buy('{$shop->id}',{$shop->auto_renew})">訂購</a>
										</td>
									</tr>
									{/foreach}
								</table>
						{$shops->render()}
					</div>
					<div aria-hidden="true" class="modal modal-va-middle fade" id="coupon_modal" role="dialog" tabindex="-1">
						<div class="modal-dialog modal-xs">
							<div class="modal-content">
								<div class="modal-heading">
									<a class="modal-close" data-dismiss="modal">×</a>
									<h2 class="modal-title">輸入優惠碼</h2>
								</div>
								<div class="modal-inner">
									<div class="form-group form-group-label">
										<label class="floating-label" for="coupon">如無則直接點擊確認即可</label>
										<input class="form-control" id="coupon" type="text">
									</div>
								</div>
								<div class="modal-footer">
									<p class="text-right"><button class="btn btn-flat btn-brand waves-attach" data-dismiss="modal" id="coupon_input" type="button">確認</button></p>
								</div>
							</div>
						</div>
					</div>										
					<div aria-hidden="true" class="modal modal-va-middle fade" id="order_modal" role="dialog" tabindex="-1">
						<div class="modal-dialog modal-xs">
							<div class="modal-content">
								<div class="modal-heading">
									<a class="modal-close" data-dismiss="modal">×</a>
									<h2 class="modal-title">訂購確認</h2>
								</div>
								<div class="modal-inner">
									<p id="name">資源包名稱：</p>
									<p id="credit">優惠幅度：</p>
									<p id="total">總金額：</p>
									<div class="checkbox switch">
										<label for="disableothers">
											<input checked class="access-hide" id="disableothers" type="checkbox">
											<span class="switch-toggle"></span>关闭旧套餐自动续费
										</label>
									</div>
									<br/>
									<div class="checkbox switch" id="autor">
										<label for="autorenew">
											<input checked class="access-hide" id="autorenew" type="checkbox">
											<span class="switch-toggle"></span>到期时自动续费
										</label>
									</div>									
								</div>								
								<div class="modal-footer">
									<p class="text-right"><button class="btn btn-flat btn-brand waves-attach" data-dismiss="modal" id="order_input" type="button">確認</button></p>
								</div>
							</div>
						</div>
					</div>					
					{include file='dialog.tpl'}	
			</div>
		</div>
	</main>
{include file='user/footer.tpl'}
<script>
function buy(id,auto) {
	if(auto==0)
	{
		document.getElementById('autor').style.display="none";
	}
	else
	{
		document.getElementById('autor').style.display="";
	}
	shop=id;
	$("#coupon_modal").modal();
}


$("#coupon_input").click(function () {
		$.ajax({
			type: "POST",
			url: "coupon_check",
			dataType: "json",
			data: {
				coupon: $("#coupon").val(),
				shop: shop
			},
			success: function (data) {
				if (data.ret) {
					$("#name").html("產品名稱："+data.name);
					$("#credit").html("優惠幅度："+data.credit);
					$("#total").html("總計金額："+data.total);
					$("#order_modal").modal();
				} else {
					$("#result").modal();
					$("#msg").html(data.msg);
				}
			},
			error: function (jqXHR) {
				$("#result").modal();
                $("#msg").html(data.msg+"  发生了错误。");
			}
		})
	});
	
$("#order_input").click(function () {

		if(document.getElementById('autorenew').checked)
		{
			var autorenew=1;
		}
		else
		{
			var autorenew=0;
		}
		if(document.getElementById('disableothers').checked){
			var disableothers=1;
		}
		else{
			var disableothers=0;
		}
			
		$.ajax({
			type: "POST",
			url: "buy",
			dataType: "json",
			data: {
				coupon: $("#coupon").val(),
				shop: shop,
				autorenew: autorenew,
				disableothers:disableothers
			},
			success: function (data) {
				if (data.ret) {
					$("#result").modal();
					$("#msg").html(data.msg);
					window.setTimeout("location.href='/user/shop'", {$config['jump_delay']});
				} else {
					$("#result").modal();
					$("#msg").html(data.msg);
				}
			},
			error: function (jqXHR) {
				$("#result").modal();
                $("#msg").html(data.msg+"  发生了错误。");
			}
		})
	});

</script>