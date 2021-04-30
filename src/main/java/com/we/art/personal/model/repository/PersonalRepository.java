package com.we.art.personal.model.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.we.art.communication.model.vo.Following;
import com.we.art.user.model.vo.User;

@Mapper
public interface PersonalRepository {
	
	public Map<String,String> selectUserByNickName(User user);
	
	@Select("SELECT *FROM TB_FOLLOWING WHERE FROM_ID = #{fromId} AND TO_ID = #{toId}") //만약 팔로잉 한 사람이라면
	public Following selectUserIsFollowing(Following following);
	
	@Select("SELECT * "
			+ "FROM TB_USER"
			+ " WHERE USER_ID IN "
			+ "(SELECT FROM_ID FROM TB_FOLLOWING WHERE TO_ID = #{userId})")
	public List<User> selectFollowerList(String userId);
	
	@Select("SELECT * "
			+ "FROM TB_USER"
			+ " WHERE USER_ID IN "
			+ "(SELECT TO_ID FROM TB_FOLLOWING WHERE FROM_ID = #{userId})")
	public List<User> selectFollowingList(String userId);
	
	@Select("SELECT COUNT(*) FROM TB_FOLLOWING WHERE TO_ID = #{userId}")
	public int selectFollowerCount(String userId);
	
	@Select("SELECT COUNT(*) FROM TB_FOLLOWING WHERE FROM_ID=#{userId}")
	public int selectFollowingCount(String userId);
}
