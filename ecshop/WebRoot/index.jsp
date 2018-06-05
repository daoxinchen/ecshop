<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ECShop商城主页</title>
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link id="themeLink" rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<style type="text/css">
	ul{
		line-height: 30px;
	}
</style>
</head>
<body class="easyui-layout">   
	<!-- 顶部 -->
    <div data-options="region:'north',split:true" style="height:90px;">
    	<!-- logo -->
    	<div id="logo">
    		<img alt="logo" src="images/logo.png">
    	</div>
    	<!-- 登录用户信息 -->
    	<div id="loginDiv" style="position: absolute;right:10px;top:20px">
    		欢迎你,[超级管理员],你使用[12.156.21.22]IP登录!
    	</div>
    	<div id="themesDiv" style="position: absolute;right: 20px;top: 40px">
    		<a href="javascript:void(0)" id="mb" class="easyui-menubutton"     
			        data-options="menu:'#Themesmenus',iconCls:'icon-edit'">Edit</a>   
			<div id="Themesmenus" style="width:150px;">   
			    <div>default</div>   
			    <div>gray</div>   
			    <div>black</div>   
			    <div>bootstrap</div>   
			    <div>material</div>   
			    <div>metro</div>   
			</div> 
    	</div> 
    </div>   
    <!-- 底部 -->
    <div data-options="region:'south',split:true" style="height:100px;">
    	<div id="copyrightDiv" style="text-align: center">
    		神马学院&copy;2017版权所有
    	</div>
    </div>   
    <!-- 左边系统菜单 -->
    <div data-options="region:'west',title:'系统菜单',split:true" style="width:200px;">
    	<div id="aa" class="easyui-accordion" style="width:193px;" data-options="border:0,multiple:true">   
		    <div title="类别管理" data-options="iconCls:'icon-save'" style="overflow:auto;padding:10px;">   
		        <ul>
		        	<li><a href="javascript:void(0)" pageUrl="categroy.jsp">类别管理</a></li>
		        </ul> 
		    </div>   
		    <div title="商品管理" data-options="iconCls:'icon-reload',selected:true" style="padding:10px;">   
		        <ul>
		        	<li><a href="javascript:void(0)" pageUrl="product_manage.jsp">商品信息管理</a></li>
		        	<li><a href="javascript:void(0)" pageUrl="product_down.jsp">商品上下架管理</a></li>
		        </ul>
		    </div>   
		</div> 
    </div>
    
    <!-- 中间编辑区域 -->
    <div data-options="region:'center'" style="padding:5px;background:#eee;">
    	 <div id="tt" class="easyui-tabs" data-options="fit:true,border:0">   
		    <div title="起始页" style="padding:20px;display:none;">   
		        tab1    
		    </div>   
		</div>  
    </div>
    <script type="text/javascript">
    	$(function(){
    		//给a标签绑定事件
    		$('a[pageUrl]').click(function(){
    			//1.获取pageUrl属性值（需要跳转的页面地址）
    			var pageUrl = $(this).attr("pageUrl");
    			//获取a标签的内容，标题
    			var title = $(this).text();
    			
    			//2.判断是否存在指定标题的选项卡
    			if($("#tt").tabs("exists",title)){
    				$("#tt").tabs("select",title)
    			} else {
    				$("#tt").tabs('add',{
    					title:title,
    					content:"<iframe src='"+pageUrl+"' width='100%' height='100%' frameborder='0'><iframe>",
    					closable:true
    				});
    			}
    		});
    		//点击切换模块菜单的时候，进行切换模板
    		$("#Themesmenus").menu({
    			onClick:function(item){
    				//1.获取需要改变的模块名称
    				var themeName = item.text;
    				//2.获取link标签的href属性
    				var href = $("#themeLink").attr("href");
    				
    				//3.更改href的属性值
    				//easyui/themes/default/easyui.css
    				href = href.substring(0,href.indexOf("themes"))+"themes/"+themeName+"/easyui.css";
    				//4.更新link属性
    				$("#themeLink").attr("href",href);
    			}
    		});
    		
    		
    	});
    </script>
</body>  
</html>