<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="../js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.btn1{
display: block;
width: 150px
}
</style>
</head>
<body>
<div class="panel-group" id="accordion">
		<div class="panel-heading ">
			<h4 class="panel-title">
				<a class="btn btn-warning" data-toggle="collapse" data-parent="#accordion" 
				   href="#collapseOne">
					菜单一的父菜单
				</a>
			</h4>
		</div>
		<div id="collapseOne" class="panel-collapse collapse ">
			<ul>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			</ul>
		</div>
	
	
	
	<div class="panel-heading ">
			<h4 class="panel-title">
				<a class="btn btn-warning" data-toggle="collapse" data-parent="#accordion" 
				   href="#collapseOne1">
					菜单一的父菜单
				</a>
			</h4>
		</div>
		<div id="collapseOne1" class="panel-collapse collapse ">
			<ul>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			</ul>
		</div>
		
		
		
		<div class="panel-heading ">
			<h4 class="panel-title">
				<a class="btn btn-warning" data-toggle="collapse" data-parent="#accordion" 
				   href="#collapseOne2">
					菜单一的父菜单
				</a>
			</h4>
		</div>
		<div id="collapseOne2" class="panel-collapse collapse ">
			<ul>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			<li class="btn btn1 btn-primary">菜单1</li>
			</ul>
		</div>
</div>
</body>
</html>