package com.bw.spring.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bw.spring.annotation.AuthMark;

public class AuthInterceptor implements HandlerInterceptor{
	/*预处理：在handler执行之前进行执行 prefix/suffix 
	 * 
	 * prehandler返回值是一个boolean类型 true：controller就可以被调用
	 *      false:请求到此为止
	 * */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//看门人，对比用户的权限和方法上面标签中的权限，是否匹配
		/*
		1.获取session中的权限信息
		2.获取请求的方法上面的那个标签权限信息
		3.将自己拥有的权限和方法上面的权限进行比对
		4.放行or not
		*/
		HttpSession session = request.getSession();
		List<String> authList = (List<String>)session.getAttribute("authList");
		
		//通过反射机制
		/*handler对象就是将要执行的那个方法的对象*/
		if(handler instanceof HandlerMethod ){
			//判断将要执行的方法是不是controller中的方法
			HandlerMethod method = (HandlerMethod) handler;
			//获取将要执行的那个方法上面的注解
			AuthMark authMark = method.getMethodAnnotation(AuthMark.class);
			//通过注解获取注解中的值
			String auth = authMark.value();
			if(authList.contains(auth)){
				return true;
			}else{
				/*request:转发  重定向*/
				response.getOutputStream().write("noauth".getBytes());
				return false;
			}
		}
		
		return false;
	}
	
	/*执行完handler后执行*/
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}
    /*afterCompletion: aop:after*/
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
