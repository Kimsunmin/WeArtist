package com.we.art.gallery.model.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.we.art.gallery.model.vo.Gallery;

@Mapper
public interface GalleryRepository {
	
	int insertAllGalleryInfo(List<Gallery> galleryList);
	
	int updateAllGalleryInfo(List<Gallery> galleryList);
	
	int deleteAllGalleryInfo(List<Gallery> galleryList);
	
	@Select("select * from tb_gallery where user_id = #{userId}")
	List<Gallery> selectGalleryInfoByUserId(String userId);
	
	@Select("select bd_title from tb_board where bd_no = #{bdNo}")
	String selectTitleByBdNO(String bdNo);
	
	@Select("select bd_content from tb_board where bd_no = #{bdNo}")
	String selectContentByBdNO(String bdNo);
	
	@Select("select path from tb_gallery where img_order = #{imgOrder} and user_id = #{userId}")
	String selectGalleryInforByImgOrder(String imgOrder,String userId);
	
	@Select("select count(*) from tb_board_master")
	int selectGalleryAllCount();
	
	List<Map<String, Object>> selectGalleryByRandom(List<Integer> randomList);
}
