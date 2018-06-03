package com.bw.spring.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.bw.spring.annotation.AuthMark;
import com.bw.spring.entity.Menu;
import com.bw.spring.entity.Permission;
import com.bw.spring.entity.RMPForShow;
import com.bw.spring.entity.RMPRelation;
import com.bw.spring.entity.RealUser;
import com.bw.spring.entity.Role;
import com.bw.spring.entity.User;
import com.bw.spring.service.TestService;

import oracle.jrockit.jfr.settings.JSONElement;

@Controller
public class TestController {
	@Autowired
	private TestService service;
	
	
	@RequestMapping("/loginjsp")
	public String loginjsp(){
		return "login";
	}
	
	@RequestMapping("/login")
	public ModelAndView login(String name,String password,HttpSession session){
		
		
		/*用户请求不收控制---》黑名单设置----》合法（true）
							false*/
		
		/*用户请求-->interceptor(验证用户合法性)---->controller进行处理
							  返回false，直接结束请求
		用户登录-->user user_role role_menu_permission_relation		
				用户菜单  权限（1,2,3,4）
		controller需要的权限进行对比，若果有这个权限则是合法用户
		
		*用户管理  1
		*user:select
		*用户管理  2
		*/
		
/*userManage:select
	userManage:update
		userManage:delete
			userManage:insert*/
		int count = service.login(name,password);
		if(count>0){
			/*读取用户所拥有的菜单信息和权限信息*/
			List<RMPRelation> authList = service.getAuthList(name,password);
		    /*userManager-select ....*/
			List<String> ownAuth = new ArrayList<String>();
			for(RMPRelation rmp:authList){
				/*拥有的菜单id*/
				Integer mid = rmp.getmId();
				/*当前菜单拥有的权限*/
				String pids = rmp.getPids();
				String menuKeyWords = service.getMenuKeyWordsById(mid);
				for(String pid:pids.split(",")){
					String permissionValue = service.selectPMValueById(pid);
					/*将拼接好的权限字符串加入到集合中*/
					ownAuth.add(menuKeyWords+":"+permissionValue);
				}
			}
			/*将所有的权限集合放入到session中进行保存*/
			session.setAttribute("authList", ownAuth);
			String menus = service.getMenu(name,password);
			ModelAndView mav = new ModelAndView("bs2");
			mav.addObject("menus", menus);
			return mav;
		}else{
			ModelAndView mav = new ModelAndView("login");
			mav.addObject("message", "用户名或密码错误！");
			return mav;
		}
	}
	
	
	@RequestMapping("/test")
	public ModelAndView test(){
		String name = service.selectNameById();
		ModelAndView mav = new ModelAndView("test");
		mav.addObject("name", name);
		int i=1/0;
		return mav;
	}
	
	@AuthMark("userManage:select")
	@RequestMapping("/userselect")
	@ResponseBody
	public Map<String,Object> userselect(String name,@RequestParam(value="pageNum",defaultValue="1")
		Integer pageNum){
		int pageSize = 3;
		int start = (pageNum-1)*pageSize;
		List<User> list =  service.selectUsers(name,start,pageSize);
		Map<String,Object> map = new HashMap<String,Object>();
		//总共的页数
		int count = service.selectCountByName(name);
		int totalPage = count%pageSize==0?count/pageSize:(count/pageSize+1);
		map.put("totalPage", totalPage);
		map.put("list", list);
		map.put("name", name);
		map.put("pageNum", pageNum);
		return map;
	}
	
	
	@RequestMapping("/delUser")
	@ResponseBody
	public String delUser(Integer id){
		int result = service.delUser(id);
		if(result>0)
			return "success";
		else
			return "fail";
	}
	
	@RequestMapping("/addUser")
	@ResponseBody
	public String addUser(User user){
		int result=0;
		if(user.getId()!=null){
			 result=service.updateUser(user);
		}else{
			 result = service.insertUser(user);
		}
		
		if(result>0)
			return "success";
		else
			return "fail";
	}
	
	@RequestMapping("/updateUser")
	@ResponseBody
	public User updateUser(Integer id){
		User user = service.selectUserById(id);
		return user;
	}
	@RequestMapping("/orgShow")
	public String orgShow(){
		return "org";
	}
	
	@RequestMapping("/bs")
	public ModelAndView bs(){
		String name = "ghostwowo";
		ModelAndView mav = new ModelAndView("bs1");
		String menus = service.makeMenus(name);
		mav.addObject("menus", menus);
		return mav;
	}
	
	
	@RequestMapping("/roleList")
	@ResponseBody
	public Map<String,Object> roleList(){
		List<Menu> list = service.selectMenus();
		List<Map<String,Object>> listRole = service.selectAllRoles();
		List<Map<String,Object>> perList = service.selectAllPers();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mList", list);
		map.put("rList", listRole);
		map.put("pList", perList);
		return map;
	}
	
	
	@RequestMapping("/realUserSelect")
	@ResponseBody
	public List<RealUser> realUserSelect(){
		return service.selectRealUser();
	}
	
	
	@RequestMapping("/selectAllRoles")
	@ResponseBody
	public Map<String,Object> selectAllRoles(Integer userId){
		List<Role> list =  service.selectAllRoless();
		Integer roleId = service.selectOwnRoleId(userId);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("roleId", roleId);
		return map;
	}
	
	@RequestMapping("/changeRoleSubmit")
	@ResponseBody
	public String changeRoleSubmit(Integer userId,Integer roleId){
		service.changeRoleSubimt(userId,roleId);
		return "success";
	}
	
	@AuthMark("roleManage:select")
	@RequestMapping("/roleSelect")
	@ResponseBody
	public List<Role> roleSelect(){
		return service.selectAllRoless();
	}
	@AuthMark("roleManage:update")
	@RequestMapping("/selectAllMenusAndAllPermissions")
	public ModelAndView selectAllMenusAndAllPermissions(Integer roleId){
		 ModelAndView mav = new ModelAndView("rmp");
		 List<Permission> pList= service.selectAllPermissions();
		 //查询当前的角色对应的菜单和权限
		 List<RMPRelation> rmpList = service.selectRMPByRoleId(roleId);
		 List<RMPForShow> rmpfsList = new ArrayList<RMPForShow>();
		 for(RMPRelation rmp:rmpList){
			 RMPForShow rpfs = new RMPForShow();
			 rpfs.setmId(rmp.getmId());
			 rpfs.setPids(rmp.getPids());
			 //通过mid查询出来菜单名称
			 //通过pids查询出来所有的权限信息
			 String name = service.selectMenuNameById(rmp.getmId());
			 String perNames = service.selectPerNamesByIds(rmp.getPids());
			 rpfs.setmName(name);
			 rpfs.setpNames(perNames);
			 rmpfsList.add(rpfs);
		 }
		 mav.addObject("pList", pList);
		 mav.addObject("rmpList",rmpfsList );
		 return mav;
	}
	
	
	@RequestMapping("/subRmp")
	@ResponseBody
	public String subRmp(Integer roleId,String[]mp){
//		1.删除所有和这个roleId有关的权限信息
//		2.添加role和mp集合中的权限
		
		service.deleteRMPByRoleId(roleId);
		service.insertRMP(roleId,mp);
		return "success";
		
		
	}
	
	@RequestMapping("/selectAllMenus")
	@ResponseBody
	public List<Menu> selectAllMenus(){
		return service.selectMenus();
	}
	
	
}
