{include file='admin-head.tpl'}

<div class="layui-body admin-invite">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

    <!--title-->
    <h1 class="site-h1">yft交易记录</h1>

    <!--content-->
    <div class="layui-row layui-col-space20">

        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">系统中充值记录。</div>
                <div class="layui-card-body">

                    <div class="table-over">
                    {$orderList->render()}
                    <table class="layui-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>订单号</th>
                            <th>金额</th>
                            <th>充值时间</th>
                            <th>状态</th>
                        </tr>
                        </thead>
                        <tbody>
                        {if sizeof($orderList) > 0}
                            {foreach $orderList as $order}
                                <tr>
                                    <td>#{$order->id}</td>
                                    <td>{$order->yft_order}</td>
                                    <td>{$order->price} 元</td>
                                    <td>{$order->create_time}</td>
                                    {if ($order->state == 1)}<td>已支付</td>{else}<td>未支付</td>{/if}
                                </tr>
                            {/foreach}
                        {else}
                            <tr>
                                <td colspan="5">暂无充值记录！</td>
                            </tr>
                        {/if}
                        </tbody>
                    </table>
                    </div>

                    <span>总共{$countPage}页</span>
                    <input type="hidden" id="countPage" value="{$countPage}">
                    <span>当前第{$currentPage}页</span>
                    <input type="hidden" id="currentPage" value="{$currentPage}">
                    <a class="btn btn-brand" href="/admin/yftOrder">首页</a>
                    <a class="btn btn-brand" href="javascript:void(0)" id="pre" onclick="goto('pre')">上一页</a>
                    <a class="btn btn-brand" href="javascript:void(0)" id="nxt" onclick="goto('next')">下一页</a>
                    <a class="btn btn-brand" href="javascript:void(0)" id="end" onclick="goto('end')">尾页</a>

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
require(['jquery'],function($){
    goto=function(type) {
        var countPage = $("#countPage").val();
        var currentPage = $("#currentPage").val();
        if ("pre" == type){
            if (currentPage == 1 || currentPage == ""){
            }else {
                window.location.href = "/admin/yftOrder?page=" + {$currentPage -1};
            }
        }else if ("next" == type){
            if (currentPage == countPage){
            }else {
                window.location.href = "/admin/yftOrder?page=" + {$currentPage +1};
            }
        }else if ("end" == type){
            if (countPage == currentPage){
            }else {
                window.location.href = "/admin/yftOrder?page=" + countPage;
            }
        }
    }
})
</script>