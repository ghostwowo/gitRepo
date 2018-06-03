<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" > 
<script type="text/javascript" src="../js/jquery-2.2.3.min.js" ></script>
<script type="text/javascript" src="../js/jquery.ztree.core.min.js" ></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var setting = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid",
				rootPId: 0
			}
		}
	};
var zNodes =[{name:"基础信息管理",id:1,pid:0},
             {name:"基础设施管理",id:2,pid:0},
             {name:"用户管理",pid:1,id:3},
             {name:"组织架构管理",pid:1,id:4}]

$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
});

</script>
</head>
<body>
	
	<div id="treeDemo" class="ztree" ></div>
	
</body>
</html>