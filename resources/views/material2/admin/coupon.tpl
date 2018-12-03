{include file='admin-head.tpl'}

<div class="layui-body admin-coupon">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">优惠码</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">优惠码</div>
				<div class="layui-card-body">
					
					<div class="layui-form layui-form-pane">
					  <div class="layui-form-item">
					    <label class="layui-form-label">优惠码前缀</label>
					    <div class="layui-input-inline">
					      <input type="text" id="prefix" class="layui-input" required>
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	只支持英文
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">优惠码额度%</label>
					    <div class="layui-input-inline">
					      <input type="text" id="credit" class="layui-input" required>
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	九折就填10 八折就填20
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">优惠码有效期(h)</label>
					    <div class="layui-input-inline">
					      <input type="number" id="expire" class="layui-input" value="1" required>
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	单位(小时)
					    </div>
					  </div>
					<div class="layui-form-item">
					    <label class="layui-form-label">优惠码可用商品ID</label>
					    <div class="layui-input-inline">
					      <input type="text" id="shop" class="layui-input">
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	不填即为所有商品可用，多个的话用英文半角逗号分割
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">每个用户可用次数</label>
					    <div class="layui-input-inline">
					      <input type="number" id="count" class="layui-input" value="1">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">是否一次性</label>
					    <div class="layui-input-inline">
					      <input type="checkbox" name="onetime" id="onetime" lay-skin="switch" lay-text="是|否">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <div class="layui-input-block">
					      <button id="coupon" type="submit" class="layui-btn"><i class="icon ptfont pticon-tickcheckmarkac"></i> 立即生成</button>
					    </div>
					  </div>
					</div>

				</div>
			</div>
		</div>

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">优惠码列表</div>
				<div class="layui-card-body">

				显示表项:
				{include file='table/checkbox.tpl'}

				{include file='table/table.tpl'}

				</div>
			</div>
		</div>

    </div>
	<!--content:end-->

</div>
</div>
</div>

{include file='admin-foot.tpl'}

<script>
require(['jquery','datatables.net'],function($,datatables){

		{include file='table/js_2.tpl'}

		$("#coupon").click(function(){

			if(document.getElementById('onetime').checked)
			{
					var onetime=1;
			}
			else
			{
					var onetime=0;
			}

	      $.ajax({
		          type: "POST",
		          url: "/admin/coupon",
		          dataType: "json",
		          data: {
			          prefix: $("#prefix").val(),
			          credit: $("#credit").val(),
					  shop: $("#shop").val(),
					  onetime: $("#count").val(),
			          expire: $("#expire").val()
		          },
		          success: function (data) {
		              if (data.ret) {
		                  layer.msg(data.msg);
		                  window.setTimeout("location.href='/admin/coupon'", {$config['jump_delay']});
		              }
		              // window.location.reload();
		          },
		          error: function (jqXHR) {
		              layer.msg("内容错误："+jqXHR.status);
		          }
	      })
		})

})
</script>