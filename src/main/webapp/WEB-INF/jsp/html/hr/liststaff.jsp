<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp"></jsp:include>
<div>
	<label>员工姓名</label>
	<input id="qstaffname" type="text">
	<input type="button" id="queryStaff" value="查询">
</div>
<table id="dg"></table>
<div id="addstaff">
	<label>姓名</label>
	<input id="istaffname" ><br>
	<label>性别</label>
		<select id="istaffsex">
			<option value='1'>男</option>
			<option value='0'>女</option>
		</select><br>
	<label>生日</label>
	<input id="istaffbirthday" type="text" class="easyui-datebox" ></input>  <br>
	<label>入职时间</label>
	<input id="istaffentry" type="text" class="easyui-datebox" required="required"></input> <br>
	<label>部门</label>
		<select id="idept">
			
		</select><br>
	<label>职位</label>
		<select id="iposition">
			<option >--请选择--</option>
		</select><br>
	<input type="button" id= 'isave' value="保存">
</div>
<html>
<script type="text/javascript">
$(function(){
	$("#queryStaff").click(function(){
		var staffname = $("#qstaffname").val();
		$("#dg").datagrid({
			queryParams: {
				staffname:staffname
			}
		})
	})
	$.ajax({
		url:'dept/list.do',
		data:{rows:100},
		success:function(data){
			if(data.rows){
				$("#idept").empty();
				$(data.rows).each(function(){
					$("#idept").append('<option value='+this.id+'>'+this.deptName+'</option>')
				})
				$.ajax({
					url:'position/getPositionByDept.do',
					data:{deptId:data.rows[0].id},
					success:function(data){
						$("#iposition").empty();
						$(data.rows).each(function(){
							$("#iposition").append('<option value='+this.id+'>'+this.positionName+'</option>')
						})
					}
				})
			}
			
		}
	})
	$("#idept").change(function(){
		var deptid = $("#idept").val();
		$.ajax({
			url:'position/getPositionByDept.do',
			data:{deptId:deptid},
			success:function(data){
				$("#iposition").empty();
				$(data.rows).each(function(){
					$("#iposition").append('<option value='+this.id+'>'+this.positionName+'</option>')
				})
			}
		})
	})
			$("#dg").datagrid({
				url:'staff/list.do',
				columns:[[
				          {field:'id',title:'编号',width:100},
				          {field:'staffname',title:'员工姓名',width:100},
				          {field:'sex',title:'性别',width:100,formatter:function(value){
				        	  										if(value==1){
				        	  											return '男';
				        	  										}else if (value==0){
				        	  											return '女';				        	  											
				        	  										}
				        	  										
				          										}},
				          {field:'birthday',title:'出生日期',width:100},
				          {field:'entry',title:'入职时间',width:100},
				          {field:'deptName',title:'部门',width:100},
				          {field:'positionName',title:'职位',width:100}
				          ]],
				fit:true,
				fitColumns:true,
				singleSelect:true,
				pagination:true,
				toolbar:[{
					text:'增加',
		        	iconCls:'icon-add',
		        	handler:function(){
		        		$("#addstaff").dialog("open");
						$("#isave").unbind();
						$("#addstaff").dialog("setTitle","增加员工");
						$("#isave").click(function(){
							var istaffname = $("#istaffname").val();
							var istaffsex = $("#istaffsex").val();
							var istaffbirthday = $("#istaffbirthday").datebox('getValue');
							var istaffentry = $("#istaffentry").datebox('getValue');
							var ipositionid = $("#iposition").val();
							$.ajax({
								url:'staff/add.do',
								data:{name:istaffname,sex:istaffsex,birthday:istaffbirthday,entry:istaffentry,positionId:ipositionid},
								success:function(data){
									if(data.flag){
										$("#dg").datagrid("reload");
										$("#addstaff").dialog("close");
									}
								}
							})
							
						});
		        	}
				},{
					text:'删除',
		        	iconCls:'icon-remove',
		        	handler:function(){
		        		var row = $("#dg").datagrid("getSelected");
		        		if(row){
		        			$.ajax({
		        				url:'staff/del.do',
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
		        	handler:function(){
						$("#addstaff").dialog("open");
						$("#isave").unbind();
						$("#addstaff").dialog("setTitle","修改员工");
						var row = $("#dg").datagrid("getSelected");
						if(row){
							var istaffname = $("#istaffname").val(row.staffname);
							var istaffsex = $("#istaffsex").val(row.sex);
							var istaffbirthday = $("#istaffbirthday").datebox('setValue',row.birthday);
							var istaffentry = $("#istaffentry").datebox('setValue',row.entry);
							var idept = $("#idept").val(row.deptId);
							$.ajax({
								url:'position/getPositionByDept.do',
								data:{deptId:row.deptId},
								success:function(data){
									$("#iposition").empty();							
									$(data.rows).each(function(){							
										$("#iposition").append('<option value='+this.id+'>'+this.positionName+'</option>')
									})
									var ipositionid = $("#iposition").val(row.positionId);
								}
							})
							
							$("#isave").click(function(){								
								var istaffname = $("#istaffname").val();
								var istaffsex = $("#istaffsex").val();
								var istaffbirthday = $("#istaffbirthday").datebox('getValue');
								var istaffentry = $("#istaffentry").datebox('getValue');
								var ipositionid = $("#iposition").val();								
								$.ajax({
									url:'staff/update.do',
									data:{id:row.id,name:istaffname,sex:istaffsex,birthday:istaffbirthday,entry:istaffentry,positionId:ipositionid},
									success:function(data){
										if(data.flag){
											$("#dg").datagrid("reload");
											$("#addstaff").dialog("close");
										}
									}
								})
							});
						}}
				},]
			});   
			$("#addstaff").dialog({
			    title: '增加员工',    
			    closed: true,    
			    cache: false,    
			    modal: true   
			})
		})
</script>
</html>