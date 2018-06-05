<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商品信息管理</title>
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link id="themeLink" rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
</head>
<body>
	<table id="list"></table>
	
	<!-- 工具条 -->
	<div id="toolbar">
		<a id="saveBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">添加</a>
		<a id="editBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
		<a id="deleteBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
	</div>
	
	<!-- 编辑窗口 -->
	<div id="editWin" class="easyui-window" data-options="title:'商品编辑窗口',width:400,height:300,closed:true">
		<form id="editForm" method="post">
			<!-- 提供一个隐藏域 -->
			<input type="hidden" name="id"/>
			<table>
				<tr>
					<td>商品名称</td>
					<td><input type="text" name="name" class="easyui-validatebox" data-options="required:true"></td>
				</tr>
				<tr>
					<td>商品原价</td>
					<td><input type="text" name="price" class="easyui-numberbox" data-options="required:true"></td>
				</tr>
				<tr>
					<td>商品优惠价</td>
					<td><input type="text" name="currentPrice" class="easyui-numberbox" data-options="required:true"></td>
				</tr>
				<tr>
					<td>商品描述</td>
					<td><input type="text" name="descrption"></td>
				</tr>
				<tr>
					<td>
						<a id="save" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
						<a id="reset" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">重置</a>
					</td>
				</tr>
				
			</table>
		</form>
	</div>
	<script type="text/javascript">
		$(function(){
			$("#list").datagrid({
				url:"product_listByPage.action",
				columns:[[
					{field:'id',title:"商品编号",width:100},
					{field:"name",title:"商品名称",width:200},
					{field:"price",title:"商品原价",width:100},
					{field:"currentPrice",title:"商品优惠价",width:100},
					{field:"descrption",title:"商品描述",width:200}
				]],
				pagination:true,
				singleSelect:false,
				//工具条
				toolbar:"#toolbar"
			});
			//点击添加按钮，弹出编辑窗口
			$("#saveBtn").click(function(){
				$("#editWin").window("open");
			});
			//保存商品
			$("#save").click(function(){
				$("#editForm").form("submit",{
					url:"product_save.action",
					onSubmit:function(){
						//表单验证
						return $("#editForm").form("validate");
					},
					success:function(data){
						data=eval("("+data+")");
						if(data.success){
							//1.表单情况清空
							$("#editForm").form("clear");
							//2.关闭窗口
							$("#editWin").window("close");
							//3.刷新datagrid数据
							$("#list").datagrid("reload");
							$.messager.show({
								title:"提示",
								msg:"保存成功"
							});
						}else {
							$.messager.alert("提示","保存失败"+data.msg,"error");
						}
					}
				});
				
			});
			//修改商品 -- 回显商品信息
			$("#editBtn").click(function(){
				
				//1.获取选择的商品
				var rows = $("#list").datagrid("getSelections");
				//判断一次只能选择一个
				if(rows.length!=1){
					$.messager.alert("提示","一次只能选择一行","warning");
					return;
					
				}
				//2.获取一行
				var row = rows[0];
				
				//3.到后台商品数据，填充到表单
				$("#editForm").form("load","product_get.action?id="+row.id);
				//4.弹出编辑窗口
				$("#editWin").window("open");
				
			});
			
			//删除商品
			$("#deleteBtn").click(function(){
				//1.获取选择的商品
				var rows = $("#list").datagrid("getSelections");
				if(rows.length==0){
					$.messager.alert("提示","至少选择一个商品","warning");
					return;
					
				}
				//2.获取商品的Id 格式：字符串1，2，3
				var ids = new Array();
				$(rows).each(function(i){
					ids.push(rows[i].id);
				});
				
				ids = ids.join(",");
				//3.发送商品id到后台进行删除
				$.post("product_delete.action",{"ids":ids},function(data){
					if(data.success){
						//刷新datagrid
						$("#list").datagrid("reload");
						//提示
						$.messager.show({
							title:"提示",
							msg:"删除成功"
						});
					} else {
						$.messager.alert("提示","删除失败："+data.msg,"error");
					}
				},"json");
			});
		});
	</script>
</body>
</html>