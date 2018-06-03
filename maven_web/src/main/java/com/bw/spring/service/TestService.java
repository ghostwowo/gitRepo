package com.bw.spring.service;

import java.util.List;
import java.util.Map;

import com.bw.spring.entity.Menu;
import com.bw.spring.entity.Permission;
import com.bw.spring.entity.RMPRelation;
import com.bw.spring.entity.RealUser;
import com.bw.spring.entity.Role;
import com.bw.spring.entity.User;

public interface TestService {

	String selectNameById();

	List<User> selectUsers(String name,int start,int end);

	int selectCountByName(String name);

	int delUser(Integer id);

	int insertUser(User user);

	User selectUserById(Integer id);

	int updateUser(User user);

	String makeMenus(String name);

	int login(String name, String password);

	String getMenu(String name, String password);

	List<RMPRelation> getAuthList(String name, String password);

	String getMenuKeyWordsById(Integer mid);

	String selectPMValueById(String pid);

	List<Menu> selectMenus();

	List<Map<String, Object>> selectAllRoles();

	List<Map<String, Object>> selectAllPers();

	List<RealUser> selectRealUser();

	List<Role> selectAllRoless();

	void changeRoleSubimt(Integer userId, Integer roleId);

	Integer selectOwnRoleId(Integer userId);

	List<Permission> selectAllPermissions();

	List<RMPRelation> selectRMPByRoleId(Integer roleId);

	String selectMenuNameById(Integer getmId);

	String selectPerNamesByIds(String pids);

	void deleteRMPByRoleId(Integer roleId);

	void insertRMP(Integer roleId, String[] mp);

}
