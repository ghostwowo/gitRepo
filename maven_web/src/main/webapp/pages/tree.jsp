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
		$.fn.zTree.init($("#ztree"), setting, zNodes);
	});

</script>
</head>
<body>
<div class="ztree" id='ztree' ></div>
</body>
</html>