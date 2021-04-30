package com.we.art.communication.model.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.we.art.communication.model.vo.Following;
import com.we.art.communication.model.vo.History;
import com.we.art.user.model.vo.User;
@Mapper
public interface CommunicationRepository {

	@Select("SELECT * FROM TB_USER")
	public List<User> selectAllUser();
	
	public int insertHistory(History history);
	
	@Insert("INSERT INTO TB_FOLLOWING(FROM_ID,TO_ID) VALUES(#{fromId},#{toId})")
	public int insertFollowing(Following following);
	
	@Delete("DELETE FROM TB_FOLLOWING WHERE FROM_ID =#{fromId} AND TO_ID=#{toId}")
	public int deleteFollowing(Following following);
	
	public List<Map<String, Object>> selectHistoryById(@Param("userId") String userId);
	
	public int updateHistory(History history);
	
	public List<Map<String,String>> certificateHistory(History history);
	
	@Insert("INSERT INTO TB_MESSAGE_HISTORY(USER_ID,IS_CHECK) VALUES(#{userId},0)")
	public int insertMessageHistory(String userId);
	
	@Select("SELECT *FROM TB_MESSAGE_HISTORY WHERE USER_ID = #{userId}")
	public Map<String,String> selectMessageHistory(String userId);
}
