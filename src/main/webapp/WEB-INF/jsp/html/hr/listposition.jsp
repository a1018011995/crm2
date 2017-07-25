<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp"></jsp:include>
<table id="dg"></table>
<div id="dlg">
	<form id="form1" action="#">
		<label>部门名称</label>
		<input id="ideptName" name="deptName">
		<input id="insertDept" type="button" value="保存">
	</form>
</div>
<html>
	<script type="text/javascript">
		$(function(){
			$("#dg").datagrid({
				url:'position/list.do',
				columns:[[
				          {field:'deptName',title:'部门名称',width:100},
				          {field:'positionName',title:'职位',width:100},
				          ]],
				fit:true,
				fitColumns:true,
				singleSelect:true,
				pagination:true,
				toolbar:[{
					text:'增加',
		        	iconCls:'icon-add',
		        	handler:function(){
		        		
		        	}
				},{
					text:'删除',
		        	iconCls:'icon-remove',
		        	handler:function(){
		        		var row = $("#dg").datagrid("getSelected");
		        		if(row){
		        			$.ajax({
		        				url:'position/del.do',
		        				data:{id:row.id},
		        				success:function(data){
		        					if(data.flag){
		        						$("#dg").datagrid("reload");
		        					}
		        				}
		        			})
		        		}
		        	}
				},{
					text:'修改',
		        	iconCls:'icon-edit',
		        	handler:function(){alert("edit")}
				},]
			});
			$('#dlg').dialog({    
			    title: '增加部门',       
			    closed: true,    
			    cache: false,    
			    modal: true   
			});    

		})
	
	
	</script>
</html>