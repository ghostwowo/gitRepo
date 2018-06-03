package com.bw.spring.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bw.spring.entity.Menu;
import com.bw.spring.entity.Permission;
import com.bw.spring.entity.RMPRelation;
import com.bw.spring.entity.RealUser;
import com.bw.spring.entity.Role;
import com.bw.spring.entity.User;

public interface Mapper {
	
	@Select("select name from user where id = 1")
	String selectNameById();
	
	List<User> selectUsers(@Param("name")String name,@Param("start")Integer start,@Param("end")Integer end);

	int selectCount(@Param("name")String name);
	@Delete("delete from user where id = #{id}")
	int delUser(Integer id);
	@Delete("insert into user (name,age,address) values(#{name},#{age},#{address})")
	int insert(User user);

	User selectUserById(Integer id);
	@Update("update user set name=#{name},age=#{age},address=#{address} where id = #{id}")
	int updateUser(User user);

	List<Map<String, Object>> selectMenus(String name);
	
	int login(@Param("name")String name, @Param("password")String password);

	List<Menu> selectMenusByNameAndPassword(@Param("name")String name, @Param("password")String password);

	
	
	List<RMPRelation> selectRMPByNameAndPwd(@Param("name")String name,@Param("pwd") String password);

	String getMenuKeyWordsById(Integer mid);

	String selectPMValueById(int id);

	List<Menu> selectAllMenu();

	List<Map<String, Object>> selectAllRoles();

	List<Map<String, Object>> selectAllPers();

	List<RealUser> selectRealUser();

	List<Role> selectAllRoless();
    @Update("update user_role_relation set r_id = #{roleId} where u_id = #{userId}") 
	void updateRole(@Param("userId")Integer userId, @Param("roleId")Integer roleId);

	Integer selectOwnRoleId(Integer userId);

	List<Permission> selectAllPermissions();

	List<RMPRelation> selectRMPByRoleId(Integer roleId);

	String selectMenuNameById(Integer mid);

	String selectPNameById(int pid);
	@Delete("delete from role_menu_permission_relation where r_id = #{roleId}")
	void deleteRMPByRoleId(Integer roleId);
	@Insert("insert into role_menu_permission_relation(r_id,m_id,pids) values(#{roleId},#{mid},#{pids})")
	void insertRMP(@Param("roleId")Integer roleId, @Param("mid")int mid, @Param("pids")String pids);

}
