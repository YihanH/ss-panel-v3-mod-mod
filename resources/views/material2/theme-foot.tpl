
<div class="layui-footer">
	{$smarty.now|date_format:"%Y"} &copy; <a href="//github.com/Anankke/SSPanel-Uim" target="_blank">Github</a> - Powered by {$config["appName"]}
</div>
{if $config["enable_crisp"] == 'true'}{include file='crisp.tpl'}{/if}
<script>
window.sp={
    js:  "{$config['baseUrl']}/theme/sp/assets/",
    ver: '1.0',
    jump_delay :'{$config['jump_delay']}',
    timestamp : '{time()}'
};
</script>
<script src="/theme/sp/assets/seed.js"></script>

</body>
</html>