<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp"></jsp:include>
<div>
	<label>部门名称</label>
	<input id="deptName">
	<input id="queryDept" type="button" value="查询">
</div>
<table id= "dg"></table>
<div id="dlg">
	<form id="form1" action="#">
		<label>部门名称</label>
		<input id="ideptName" name="deptName">
		<input id="insertDept" type="button" value="保存">
	</form>
</div>
<script type="text/javascript">
$(function(){
	$("#queryDept").click(function(){
		var deptName= $("#deptName").val();
		if(deptName){
			$("#dg").datagrid({
				queryParams:{deptname:deptName} 
			})	
		}
	})
	$("#dg").datagrid({
				url:'dept/list.do',    
	   			columns:[[    
	       			{field:'id',title:'ID',width:100},    
	        		{field:'deptName',title:'部门名称',width:100}   
	    			]],
		        fit:true,
		        fitColumns:true,
		        singleSelect:true,
		        pagination:true,
		        toolbar:[{
		        	text:'增加',
		        	iconCls:'icon-add',
		        	handler:function(){
		        		$("#ideptName").val('');
		        		$("#dlg").dialog("open");
		        		$("#insertDept").unbind();
		        		$("#insertDept").click(function(){
		        			var ideptName = $("#ideptName").val();
		        			if(ideptName){
				        		$.ajax({
				        			url:'dept/add.do',
				        			data:{deptName:ideptName},
				        			success:function(data){
				        				if(data.flag){
				        					$("#dg").datagrid("reload");
				        					$("#dlg").dialog("close");
				        				}
				        			}
				        		})
		        			}
		        		});
		        	}
		        },{
		        	text:'修改',
		        	iconCls:'icon-edit',
		        	handler:function(){
		        		$("#dlg").dialog("setTitle","修改部门");
		        		$("#dlg").dialog("open");
		        		$("#insertDept").unbind();
		        		var row = $("#dg").datagrid("getSelected");
		        		if(row){
		        			$("#ideptName").val(row.deptName);
			        		$("#insertDept").click(function(){
			        			var ideptName = $("#ideptName").val();
			        			if(ideptName){
					        		$.ajax({
					        			url:'dept/update.do',
					        			data:{id:row.id,deptName:ideptName},
					        			success:function(data){
					        				if(data.flag){
					        					$("#dg").datagrid("reload");
					        					$("#dlg").dialog("close");
					        				}
					        			}
					        		})
			        			}
			        		});
		        		}
		        	}
		        },{
		        	text:'删除',
		        	iconCls:'icon-remove',
		        	handler:function(){
		        		var row = $("#dg").datagrid("getSelected");
		        		$.ajax({
		        			url:'dept/del.do',
		        			data:{id:row.id},
		        			success:function(data){
		        				if(data.flag){
		        					$("#dg").datagrid("reload");
		        				}
		        			}
		        		})
		        	}
		        }]		        
	});
	$('#dlg').dialog({    
	    title: '增加部门',       
	    closed: true,    
	    cache: false,    
	    modal: true   
	});    

})
</script>
	