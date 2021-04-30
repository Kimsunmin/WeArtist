package com.we.art.board.model.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.we.art.board.model.vo.Board;
import com.we.art.common.util.file.FileVo;
import com.we.art.communication.model.vo.LikeHistory;

@Mapper
public interface BoardRepository {
	
	@Insert("insert into tb_board(bd_no, user_id, bd_title, bd_content, tag)"
			+ " values('b'||sc_bd_idx.nextval, #{userId}, #{bdTitle}, #{bdContent}, #{tag})")
	int insertBoard(Board board);
	
	@Insert("insert into tb_file(f_idx, f_origin, f_rename, user_id, f_save_path)"
			+ " values('f'||sc_file_idx.nextval, #{fOrigin}, #{fRename}, #{userId}, #{fSavePath})")
	int insertFile(FileVo file);
	
	@Insert("insert into tb_board_master(bd_no, f_idx)"
			+ " values('b'||sc_bd_idx.currval, 'f'||sc_file_idx.currval)")
	int insertBoardMaster();
	
	List<Board> selectBoardByUserId(String userId);
	
	List<FileVo> selectFileByBdNo(String bdNo);

	Map<String,Object> selectBoardByBdNo(String bdNo); //장영우 추가
	
	List<Map<String,String>> selectLikeListByBdNo(String bdNo);
	
	int insertLike(@Param("bdNo")String bdNo, @Param("lkId")String lkId);
	
	int deleteLike(@Param("bdNo")String bdNo, @Param("lkId")String lkId);
	
	Map<String,String> certificateLike(@Param("bdNo")String bdNo, @Param("lkId")String lkId);
	
	int selectLikeCount(@Param("bdNo")String bdNo);
	
	int insertLikeHistory(LikeHistory likeHistory);
	
	int deleteBoardById(@Param("bdNo") String bdNo);
}
