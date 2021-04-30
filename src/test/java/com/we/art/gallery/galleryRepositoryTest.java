package com.we.art.gallery;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.we.art.gallery.model.repository.GalleryRepository;
import com.we.art.gallery.model.vo.Gallery;

@WebAppConfiguration 
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*-context.xml"})
public class galleryRepositoryTest {
	
	private String userId = "test01";
	
	@Autowired
	private GalleryRepository galleryRepository;
	
	@Test
	public void insertAllGalleryInfoTest() {
		List<Gallery> galleryList = new ArrayList<Gallery>();
		
		for(int i=0; i<5; i++) {
			Gallery test = new Gallery();
			test.setBdNo("b"+i);
			test.setfIdx("f"+i);
			test.setImgOrder("i"+i);
			test.setPath("p"+i);
			test.setUserId(userId);
			galleryList.add(test);
		}
		
		galleryRepository.insertAllGalleryInfo(galleryList);
	}
	
}
