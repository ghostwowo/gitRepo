<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" href="css/bootstrap.min.css" rel="stylesheet" >
<link type="text/css" href="css/zTreeStyle.css" rel="stylesheet" >
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-2.1.0.js" ></script>
<script type="text/javascript" src="js/jquery.ztree.core.js" ></script>
<script type="text/javascript" src="js/jquery.ztree.excheck.js" ></script>
<script type="text/javascript" src="js/bootstrap.min.js" ></script>
<style type="text/css">
.height{
	height: 200px
}
</style>

<script type="text/javascript">
var setting={
		data:{
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "p_id",
				rootPId: 0
			}
		},
		check: {
			enable: true,
			chkStyle:'checkbox'
		}
}
$(function(){
	$.ajax({
		url:"<%=request.getContextPath()%>/selectAllMenus",
		success:function(data){
			$.fn.zTree.init($("#div1"),setting,data);
		}
	})
})
</script>

</head>
<body>

	<div id="div1" class="col-md-6 height ztree " ></div>
	<div id="div2" class="col-md-6 height"  >
		<c:forEach items="${ pList}" var='p' >
			<div>
			<input type='checkbox' name="permission" value="${p.id }" />${p.name }
			</div>
		</c:forEach>
	</div>
	<div id="div3" >
	<button>添加</button>
	<button>提交</button>
	</div>
	<div id="div4"  style="height: 300px;overflow: auto"  >
	<form>
		<table class="table table-bordered">
		<tr>
		<th>菜单名称</th>
		<th>权限</th>
		<th>操作</th>
		</tr>
		
		<c:forEach items="${rmpList }" var='rmp' >
		<tr>
		<th>${rmp.mName }</th>
		<th>${rmp.pNames }<input hidden name="mp" value='${rmp.mId }+":"+${rmp.pids }' /></th>
		<th><button>删除</button></th>
		</tr>
		</c:forEach>
		
		</table>
	</form>
	</div>

</body>
</html>