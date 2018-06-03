<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" href="../css/bootstrap.min.css" rel="stylesheet" >
<link type="text/css" href="../css/zTreeStyle.css" rel="stylesheet" >
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery-2.2.3.min.js" ></script>
<script type="text/javascript" src="../js/jquery.ztree.core.js" ></script>
<script type="text/javascript" src="../js/jquery.ztree.excheck.js" ></script>
<script type="text/javascript" src="../js/bootstrap.min.js" ></script>
<script type="text/javascript">
	var pageNum = 0;
	var totalPage = 0;
	var realName = "";
	/* 分页操作 */
	function pages(type){
		var currentPageNum=0;
		if(type==1){
			/* 上一页 */
			currentPageNum=pageNum-1;
			if(pageNum==1){
				alert("已经是第一页了。。。")
				return;
			}
		}
		else{
			/* 下一页 */
			currentPageNum=pageNum+1;
			if(pageNum==totalPage){
				alert("后面没有数据啦。。。")
				return;
			}
		}
		
		$.ajax({
			url:"<%=request.getContextPath()%>/userselect",
			data:{'pageNum':currentPageNum,"name":realName},
			success:function(data){
				parseData(data)
			}
		})
		
		
	}
/* 点击搜索时候 */
	function search(){
		var name = $("input[name='name']").val();
		$.ajax({
			url:"<%=request.getContextPath()%>/userselect",
			data:{'name':name},
			success:function(data){
				parseData(data)
			}
		})
	}
	/* 删除用户 */
	function delUser(id){
		$.ajax({
			url:"<%=request.getContextPath()%>/delUser",
			data:{'id':id},
			success:function(data){
				if(data=='success'){
					$("ul>li:eq(0)").click();
				}
			}
		})
	}
	/* 提交表单，增加用户 */
	function sub(){
		$.ajax({
			url:"<%=request.getContextPath()%>/addUser",
			data:$("#userform").serialize(),
			success:function(data){
				if(data=='success'){
					$("ul>li:eq(0)").click();
				}
			}
		})
	}
	
	
	function add(){
		var forms=
		'<form id="userform" class="form-horizontal">'+
		
		 ' <div class="form-group">'+
		   ' <label for="inputEmail3" class="col-sm-2 control-label">name</label>'+
		   ' <div class="col-sm-5">'+
		     ' <input name="name" type="text" class="form-control" id="username" placeholder="名称">'+
		    '</div>'+
		    '<div class="col-sm-5" ></div>'+
		'  </div>'+
		
		' <div class="form-group">'+
		   ' <label for="inputEmail3" class="col-sm-2 control-label">age</label>'+
		   ' <div class="col-sm-5">'+
		     ' <input name="age" type="text" class="form-control" id="age" placeholder="年龄">'+
		    '</div>'+
		    '<div class="col-sm-5" ></div>'+
		'  </div>'+
		
		 ' <div class="form-group">'+
		  '  <label for="inputPassword3" class="col-sm-2 control-label">address</label>'+
		   ' <div class="col-sm-5">'+
		    '  <input name="address" type="text" class="form-control" id="address" placeholder="地址">'+
		   ' </div>'+
		   '<div class="col-sm-5" ></div>'+
		 ' </div>'+
		 
		 
		  '<div class="form-group">'+
		   ' <div class="col-sm-offset-2 col-sm-10">'+
		    '  <div class="btn btn-default" onclick="sub();" >submit</div>'+
		   ' </div>'+
		 ' </div>'+
		 
		 
		'</form>'
		
		$("#content").html(forms);
	}
	/* 修改用户回显数据 */
	function updateUser(id){
		$.ajax({
			url:"<%=request.getContextPath()%>/updateUser?id="+id,
			success:function(data){
				/* 右侧动态添加表单 */
				add();
				$("#username").val(data.name)
				$("#age").val(data.age)
				$("#address").val(data.address)
				var idinput = "<input hidden name='id' id='userId' value="+data.id+" />";
				$("#userform").append(idinput)
			}		
		})
	}
	
	/* 解析返回的数据 */
	function parseData(data){
		realName = data.name;
		pageNum = data.pageNum;
		totalPage = data.totalPage;
		var lst = data.list;
		var tables = 
			"<label>名称</label><input name='name' />"+
			"<button onclick='search();'  class='btn btn-primary' ><span class='glyphicon glyphicon-search' ></span></button>"+
			"<button onclick='add();'  class='btn btn-success' ><span class='glyphicon glyphicon-plus' ></span></button>"+
			"<table class='table table-bordered table-hover' ><tr>"+
			"<td>姓名</td>"+
			"<td>年龄</td>"+
			"<td>地址</td>"+
			"<td>操作</td>"+
			"</tr>";
		for(var i=0;i<lst.length;i++){
			tables+="<tr>"+
			"<td>"+lst[i].name+"</td>"+
			"<td>"+lst[i].age+"</td>"+
			"<td>"+lst[i].address+"</td>"+
			"<td>"+
			"<button onclick='delUser("+lst[i].id+");' class='btn btn-danger' ><span class='glyphicon glyphicon-trash'></span></button>"+
			"<button onclick='updateUser("+lst[i].id+")' class='btn btn-success' ><span class='glyphicon glyphicon-edit' ></span></button>"+
			"</td>"+
			"</tr>"
		}
		tables+="</table>"+
		"<button onclick='pages(1)' class='btn btn-warning' ><span class='glyphicon  glyphicon-arrow-left'></span></button>"+
		"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
		"<button onclick='pages(0)' class='btn btn-warning' ><span class='glyphicon glyphicon-arrow-right'></span></button>";
		$("#content").html(tables)
		$("input[name='name']").val(realName);
	}
/*点击左侧菜单时候 */
	function clic(type){
		if(type==1){
			$.ajax({
				url:"<%=request.getContextPath()%>/userselect",
				success:function(data){
					parseData(data)
				}
			})
		}
		if(type==2){
			$.ajax({
				url:"<%=request.getContextPath()%>/orgShow",
				success:function(data){
					$("#content").html(data)
				}
			})
		}
	}
	
	
	
	var setting = {
		check: {
			enable: true
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};

	var zNodes =[
		{ id:1, pId:0, name:"随意勾选 1", open:true},
		{ id:11, pId:1, name:"随意勾选 1-1", open:true},
		{ id:111, pId:11, name:"随意勾选 1-1-1"},
		{ id:112, pId:11, name:"随意勾选 1-1-2"},
		{ id:12, pId:1, name:"随意勾选 1-2", open:true},
		{ id:121, pId:12, name:"随意勾选 1-2-1"},
		{ id:122, pId:12, name:"随意勾选 1-2-2"},
		{ id:2, pId:0, name:"随意勾选 2", checked:true, open:true},
		{ id:21, pId:2, name:"随意勾选 2-1"},
		{ id:22, pId:2, name:"随意勾选 2-2", open:true},
		{ id:221, pId:22, name:"随意勾选 2-2-1", checked:true},
		{ id:222, pId:22, name:"随意勾选 2-2-2"},
		{ id:23, pId:2, name:"随意勾选 2-3"}
	];
	
	
	
	$(document).ready(function(){
		$.fn.zTree.init($("#tree"), setting, zNodes);
	});

	
	
	
</script>
</head>
<body>
<div style="background-image: url('../pic/300.jpg');" >
<div class="container">
	<div class="jumbotron">
	  <h1>1709A1实训项目</h1>
	  <p>...</p>
	  <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
	</div>
	<div class="row">
		<div class="col-md-3"  >
			<div class="col-md-11 jumbotron " style="height: 400px;padding-left:0" >
			<ul>
			<li class="btn btn-primary btn-md" style="width:150px" onclick="clic(1)" >用户管理</li>
			<li class="btn btn-success btn-md" style="width:150px" onclick="clic(2)">组织管理</li>
			<li class="btn btn-info btn-md" style="width:150px" onclick="clic(3)">人员管理</li>
			<li class="btn btn-warning btn-md" style="width:150px" onclick="clic(4)">资金管理</li>
			<li class="btn btn-danger btn-md" style="width:150px" onclick="clic(5)">仓库管理</li>
			</ul>
			</div>
			<div class="col-md-1"></div>
		</div>
		<div class="col-md-9 jumbotron" style="height: 400px" id="content" >
		<h1 class="ztree" id="tree">请点击管理菜单</h1>
		</div>
	</div>
	
	
</div>
</div>
</body>
</html>