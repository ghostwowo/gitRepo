<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="path" value="<%=request.getContextPath() %>" ></c:set>

<link type="text/css" href="css/bootstrap.min.css" rel="stylesheet" >
<link type="text/css" href="css/zTreeStyle.css" rel="stylesheet" >
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-2.1.0.js" ></script>
<script type="text/javascript" src="js/jquery.ztree.core.js" ></script>
<script type="text/javascript" src="js/jquery.ztree.excheck.js" ></script>
<script type="text/javascript" src="js/bootstrap.min.js" ></script>
<script type="text/javascript">

	var ztreeObj;
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
					$("ul>li:(0)").click();
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
					if(data=='noauth'){
						$("#content").html("不好意思，你没权限！！！！")
					}
					parseData(data)
				}
			})
		}
		if(type==2){
			$.ajax({
				url:"${path}/orgSelect",
				success:function(data){
					$("#content").html(data)
				}
			})
		}
		if(type==5){
			$.ajax({
				url:"<%=request.getContextPath()%>/realUserSelect",
				success:function(dat){
					parseData1(dat)
				}
			})
		}
		
		if(type==6){
			$.ajax({
				url:"<%=request.getContextPath()%>/roleSelect",
				success:function(dat){
					parseData2(dat)
				}
			})
		}
	}
	
	
	function parseData1(data){
		var tables = 
			"<label>名称</label><input name='name' />"+
			"<button onclick='search();'  class='btn btn-primary' ><span class='glyphicon glyphicon-search' ></span></button>"+
			"<button onclick='add();'  class='btn btn-success' ><span class='glyphicon glyphicon-plus' ></span></button>"+
			"<table class='table table-bordered table-hover' ><tr>"+
			"<td>姓名</td>"+
			"<td>用户名</td>"+
			"<td>密码</td>"+
			"<td>操作</td>"+
			"</tr>";
		for(var i=0;i<data.length;i++){
			tables+="<tr>"+
			"<td>"+data[i].name+"</td>"+
			"<td>"+data[i].username+"</td>"+
			"<td>"+data[i].password+"</td>"+
			"<td>"+
			"<button title='角色管理' onclick='changeRole("+data[i].id+")' class='btn btn-success' ><span class='glyphicon glyphicon-edit' ></span></button>"+
			"</td>"+
			"</tr>"
		}
		tables+="</table>"+
		"<button onclick='pages(1)' class='btn btn-warning' ><span class='glyphicon  glyphicon-arrow-left'></span></button>"+
		"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
		"<button onclick='pages(0)' class='btn btn-warning' ><span class='glyphicon glyphicon-arrow-right'></span></button>";
		$("#content").html(tables)
	}
	
	/* function roleManege(roleId){ */
		/* 1.修改页面 */
		/* var contentStr = 
		"<div class='col-md-6' ><div>"+
		"<div class='col-md-6' ><div>"+
		"<div><button></button><button></button><div>"+
		"<div style='height:500px;overflow:auto' ><div>"; */
		/* 2.将节点放入到右侧content中 */
		/* $("#content").html(contentStr); */
		/* 3.加载数据 */
		/* 
		(1)ajax查询所有的菜单数据
		(2)ajax查询所有的权限数据
		(3)查询当前roleId所拥有的所有的菜单和权限
		ajax返回一个map集合
		*/
		 /*  后台查询数据为
		id name p_id List<Menu>
		var mList = data.mList;
		var setting={
				data:{
					simpleData:{
						enable:true,
						idKey:'id',
						pId:'p_id',
						rootPId:0
					}
				}
		} 
		 */
		
		
		
	/* 	$.fn.zTree.init($("左侧div"),settings,mList);  */
		
		/* 加载权限 */
		/*  var pList = data.pList;
		var ckbxStr = "";
		for(var i=0;i<pList.length;i++){
			ckbxStr+=
				'<input type="checkbox" name="permission" value="'+pList[i].id+'"/>'+pList[i].name
		}
		
		$("右侧div").html(ckbxStr) */
		 
		 /* 下面的数据回显 */
		 /* 
		 1.查询出来所有的已经拥有的数据
		 2.将拥有的数据放入表单中进行展示
		 3.将表单中的数据进行修改
		 4.提交表单中的数据
		 5.删除和当前role有关的所有的权限数据
		 6.重新添加当前剩余的数据
		 */
		/*  var rmpList = data.rmpList; */
		/*  菜单名称    权限   操作 
		 菜单一   增加，删除，修改    删除  <input hidden name='mp' value=1:1,2,3,4 /> */
		/* var rmpStr = "";
		 '<form>'+
		 '<input hidden name='roleId' value='+roleId+'>'
		 '<table>'+
		 '<tr>'+
		 '<td>菜单名称</td>'+
		 '<td> 权限</td>'+
		 '<td>操作</td>'+
		 '</tr>';
		 for(var i=0;i<rmpList.length;i++){
			 '<tr>'+
			 '<td>'+rmpList[i].mname+'</td>'+
			 '<td>'+rmpList[i].pNames+'<input name="mp" hidden value='+rmpList[i].mid+":"+rmpList[i].pids+'  /></td>'+
			 '<td><button onclick="rmTR(this);" >删除</button></td>'+
			 '</tr>' 
		 }
		
		 rmpStr+=
		 '</table>'+
		 '</form>';
		 
		 $("下面div").html(rmpStr)
		 
		 function rmTR(node){
			 $(node).parent().parent().remove();
		 } */
		 
		 /* 提交按钮的点击事件 */
		/*  function submitRMP(){
			 $.ajax({
				 url:"sasdsad",
				 data:$("form").serialize(),
				 
			 })
			 
		 }
		
		 public sasdsad(String[]mp,Integer roleId){
			 mid pids
		 } 
		
		 
	}*/
	
	
	
	function parseData2(data){
		var tables = 
			"<label>名称</label><input name='name' />"+
			"<button onclick='search();'  class='btn btn-primary' ><span class='glyphicon glyphicon-search' ></span></button>"+
			"<button onclick='add();'  class='btn btn-success' ><span class='glyphicon glyphicon-plus' ></span></button>"+
			"<table class='table table-bordered table-hover' ><tr>"+
			"<td>角色名称</td>"+
			"<td>操作</td>"+
			"</tr>";
		for(var i=0;i<data.length;i++){
			tables+="<tr>"+
			"<td>"+data[i].name+"</td>"+
			"<td>"+
			"<button title='权限分配' onclick='changeRMP("+data[i].id+")' class='btn btn-success' ><span class='glyphicon glyphicon-edit' ></span></button>"+
			"</td>"+
			"</tr>"
		}
		tables+="</table>"+
		"<button onclick='pages(1)' class='btn btn-warning' ><span class='glyphicon  glyphicon-arrow-left'></span></button>"+
		"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
		"<button onclick='pages(0)' class='btn btn-warning' ><span class='glyphicon glyphicon-arrow-right'></span></button>";
		$("#content").html(tables)
	}
	
	
	
	
	function changeRole(userId){
		$.ajax({
			url:"${path}/selectAllRoles",
			data:{'userId':userId},
			success:function(data){
				var radios = "";
				var roleList = data.list;
				var roleId = data.roleId;
				var index = 0;
				for(var i=0;i<roleList.length;i++){
					if(roleId == roleList[i].id){
						index =i;
					}
						radios+='<div class="btn-group" data-toggle="buttons">'+
						'<label class="btn btn-primary">'+
							'<input name="role" type="radio" value='+roleList[i].id+' > '+roleList[i].name+
						'</label>'+
						'</div>'
				}
				radios+="<input id='userId' hidden value="+userId+" />";
				radios+="<div style='height:100px' ></div><div><button class='btn btn-success' onclick='changeRoless();' >修改角色</button></div>"
				
				$("#content").html(radios);
				
				$("input[type='radio']:eq("+index+")").click();
				
				
			}
		})
	}
	
	
	function changeRoless(){
		$.ajax({
			url:"${path}/changeRoleSubmit",
			data:{'userId':$("#userId").val(),'roleId':$("input[type='radio']:checked").val()},
			success:function(data){
				if(data=='success'){
					$("ul>li:eq(2)").click();
				}
			}
		})
	}
	
	function changeRMP(roleId){
		$.ajax({
			url:"${path}/selectAllMenusAndAllPermissions",
			data:{'roleId':roleId},
			success:function(data){
				$("#content").html(data);
			}
		})
	}
	
	
	
	
	
	function addMP(){
		/* 获取树上面选中的节点 */
		var nodes = ztreeObj.getCheckedNodes(true);
		var checkNodes = $("#div2 input[type=checkbox]:checked");
		if(nodes.length==0){
			alert("请选择菜单！")
			return;
		}
		if(checkNodes.length==0){
			alert("请选择权限！")
			return;
		}
		/* 
		1.首先获取下面表单中的所有的菜单名称
		2.获取树节点上面的所有的名称
		3.将两个菜单名称的集合进行比对，一旦重复则return结束 
		*/
		
		var trs = $("table tr:gt(0)");
		/* 将所有的表单中的菜单名称拼接成:“基础信息管理，组织架构管理，用户管理，” */
		var mNames = "";
		for(var i=0;i<trs.length;i++){
			mNames +=$(trs[i]).find("td:eq(0)").html()+",";
		}
		/* nodes是树节点，是通过ztree获取到的，不需要用jquery进行操作 */
		for(var i=0;i<nodes.length;i++){
			/* 选中的菜单名称 */
			var mName = nodes[i].name;
			if(mNames.indexOf(mName)>-1){
				alert(mName+"菜单重复！")
				return;
			}
		}
		
		
		
		/* checkNodes他们应该是jquery节点
		如果便利jquery节点，用checkNodes[i]来便利
		那么checkNodes[i]不在是jquery节点，变成了js节点 */
		
		/* 1.获取所有的权限节点，找出每个节点的名称进行拼接
		2.获取每一个树节点的名字
		3.获取树节点的id
		4.获取权限多选框的id
		5.将两个id拼接成隐藏于 */
		var pNames = "";
		var pids="";
		for(var i=0;i<checkNodes.length;i++){
			pNames+=
				$(checkNodes[i]).parent().text()+",";
			/* 为了将ids去除最后的逗号 */
			if(i<checkNodes.length-1){
				pids+=$(checkNodes[i]).val()+",";
			}else{
				pids+=$(checkNodes[i]).val();
			}
		}
		/* 获取树节点上面的属性 */
		var rmStr = "";
		for(var i=0;i<nodes.length;i++){
			var treeNodeName = nodes[i].name;
			var treeNodeId = nodes[i].id;
			rmStr+=
			"<tr>"+
			"<td>"+treeNodeName+"</td>"+
			"<td>"+pNames+"<input name='mp' hidden value="+treeNodeId+":"+pids+"  /></td>"+
			"<td><button class='btn btn-danger' onclick='rm(this);' >删除</button></td>"+
			"</tr>"
		}
		$("#div4 table").append(rmStr);
		
	}
	
	
	function rm(node){
		$(node).parent().parent().remove();
	}
	
	
	function subRmp(){
		$.ajax({
			url:"${path}/subRmp",
			data:$("#div4 form").serialize(),
			success:function(data){
				alert("修改成功！")
			}
		})
	}
	
	
	
	
	
	
	
	
</script>
</head>
<body>
<div style="background-image: url('pic/300.jpg');" >
<div class="container">
	<div class="jumbotron">
	  <h1>1709A1实训项目</h1>
	  <p>...</p>
	  <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
	</div>
	<div class="row">
		<div class="col-md-3" style="padding-right:0" >
			<div class="col-md-11 jumbotron " style="height: 600px;padding-left:0" >
					${menus }
			</div>
			<div class="col-md-1"></div>
		</div>
		<div class="col-md-9 jumbotron" style="height: 600px" id="content" >
				
		</div>
	</div>
	
	
</div>
</div>
</body>
</html>