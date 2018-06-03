<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" >
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="height: 200px" ></div>
<form class="form-horizontal" action="<%=request.getContextPath() %>/login" >
  
  <div class="form-group text-center " style="color:red" >
   			 ${message }
  </div>
  
  
  
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
    <div class="col-sm-4">
      <input type="text" class="form-control" name="name" id="inputEmail3" placeholder="name">
    </div>
    <div class="col-sm-6" ></div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
    <div class="col-sm-4">
      <input type="password" name="password" class="form-control" id="inputPassword3" placeholder="Password">
    </div>
    <div class="col-sm-6" ></div>
  </div>
  
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-default">submit</button>
    </div>
  </div>
</form>
</body>
</html>