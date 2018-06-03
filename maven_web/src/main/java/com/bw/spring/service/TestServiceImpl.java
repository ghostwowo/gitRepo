package com.bw.spring.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bw.spring.entity.Menu;
import com.bw.spring.entity.Permission;
import com.bw.spring.entity.RMPRelation;
import com.bw.spring.entity.RealUser;
import com.bw.spring.entity.Role;
import com.bw.spring.entity.User;
import com.bw.spring.mapper.Mapper;

@Service
@Transactional
public class TestServiceImpl implements TestService {
	@Autowired
	private Mapper mapper;
	public String selectNameById() {
		return mapper.selectNameById();
	}
	public List<User> selectUsers(String name,int start,int end) {
		return mapper.selectUsers(name,start,end);
	}
	public int selectCountByName(String name) {
		return mapper.selectCount(name);
	}
	public int delUser(Integer id) {
		return mapper.delUser(id);
	}
	public int insertUser(User user) {
		return mapper.insert(user);
	}
	public User selectUserById(Integer id) {
		return mapper.selectUserById(id);
	}
	public int updateUser(User user) {
		return mapper.updateUser(user);
	}
	public String makeMenus(String name) {
		List<Map<String,Object>> list = mapper.selectMenus(name);
		List<Map<String,Object>> listLevel1 = new ArrayList<Map<String,Object>>();
		for(Map<String,Object> map :list){
			if((map.get("level")+"").equals("1")){
				listLevel1.add(map);
			}
		}
		
		list.removeAll(listLevel1);
		
		String menus = "";
		int index =0;
		for(Map<String,Object> map :listLevel1){
			
			menus+="<div class='panel-heading'>"+
			"<h4 class='panel-title'>"+
				"<a class='btn ' data-toggle='collapse' data-parent='#accordion' href='#collapseOne"+index+"'>"+
				map.get("name")+
				"</a>"+
			"</h4>"+
		"</div>"+
		"<div id='collapseOne"+index+"' class='panel-collapse collapse '>"+
			"<ul>";
			
			List<Map<String,Object>> listLevel2 = new ArrayList<Map<String,Object>>();
			for(Map<String,Object> mp :list){
				if(mp.get("p_id").equals(map.get("id"))){
					menus+="<li class='btn btn1 btn-primary'>"+mp.get("name")+"</li>";
				}
			}
			menus+=
					"</ul>"+
					"</div>";
			
			index++;
		}
		
		return menus;
		
	}
	public int login(String name, String password) {
		return mapper.login(name,password);
	}
	public String getMenu(String name, String password) {
		
		/*
		1.按照用户名和密码查询出当前用户
		2.根据用户查询出角色id
		3.根据角色id查询三张关系表
		4.查询出所有的菜单id
		5.根据id查询出所有的菜单信息
		6.根据菜单的等级关系进行分类
		7.根据分类出来的信息进行拼接menus字符串
		8.返回
		*/
		
		List<Menu> list = mapper.selectMenusByNameAndPassword(name,password);
		List<Menu> level1List = new ArrayList<Menu>();
		//将一级菜单放入到level1List
		for(Menu m:list){
			if(m.getLevel()==1)
				level1List.add(m);
		}
		//在所有的list集合中去除掉一级菜单
		list.removeAll(level1List);
		//遍历一级菜单
		String menus = "";
		int index = 0;
		for(Menu m:level1List){
			menus+=
			"<h4 class='panel-heading' style='width:150px '>"+
					"<a class='btn btn-success' data-toggle='collapse' data-parent='#accordion' href='#collapseTwo"+index+"'>"+
						m.getName()+
					"</a>"+
			"</h4>"+
			"<div id='collapseTwo"+index+"' class='panel-collapse collapse'>"+
			"<div class='panel-body' style='padding:0'>"+
				"<ul>";		
			for(Menu m1:list){
				if(m.getId()==m1.getP_id()){
					menus+="<li class='btn btn-info' onclick="+m1.getUrlPath()+"  style='display: block;width:150px ' >"+m1.getName()+"</li>";
				}
			}
			menus+=
			"</ul>"+
			"</div>"+
		"</div>";
			
			index++;
		}
		
		return menus;
		
	}
	public List<RMPRelation> getAuthList(String name, String password) {
		return mapper.selectRMPByNameAndPwd(name,password);
	}
	public String getMenuKeyWordsById(Integer mid) {
		return mapper.getMenuKeyWordsById(mid);
	}
	public String selectPMValueById(String pid) {
		// TODO Auto-generated method stub
		return mapper.selectPMValueById(Integer.parseInt(pid));
	}
	public List<Menu> selectMenus() {
		return mapper.selectAllMenu();
	}
	public List<Map<String, Object>> selectAllRoles() {
		// TODO Auto-generated method stub
		return mapper.selectAllRoles();
	}
	public List<Map<String, Object>> selectAllPers() {
		// TODO Auto-generated method stub
		return mapper.selectAllPers();
	}
	public List<RealUser> selectRealUser() {
		return mapper.selectRealUser();
	}
	public List<Role> selectAllRoless() {
		return mapper.selectAllRoless();
	}
	public void changeRoleSubimt(Integer userId, Integer roleId) {
		mapper.updateRole(userId,roleId);
		
	}
	public Integer selectOwnRoleId(Integer userId) {
		return mapper.selectOwnRoleId(userId);
	}
	public List<Permission> selectAllPermissions() {
		return mapper.selectAllPermissions();
	}
	public List<RMPRelation> selectRMPByRoleId(Integer roleId) {
		return mapper.selectRMPByRoleId(roleId);
	}
	public String selectMenuNameById(Integer mid) {
		return mapper.selectMenuNameById(mid);
	}
	public String selectPerNamesByIds(String pids) {
		String allName = "";
		for(String id:pids.split(",")){
			String pname = mapper.selectPNameById(Integer.parseInt(id));
			allName+=pname+",";
		}
		return allName;
	}
	public void deleteRMPByRoleId(Integer roleId) {
		// TODO Auto-generated method stub
		mapper.deleteRMPByRoleId(roleId);
	}
	public void insertRMP(Integer roleId, String[] mp) {
		for(String mpp:mp){
			String ids[] = mpp.split(":");
			mapper.insertRMP(roleId,Integer.parseInt(ids[0]),ids[1]);
		}
	}
	
	
	

}
