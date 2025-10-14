package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Menu;
import com.example.test1.model.Product;



@Mapper
public interface ProductMapper {
	
	// 상품 리스트 불러오기
	List<Product> productList(HashMap<String, Object> map);
	// 상품 검색
	List<Product> productListSearch(HashMap<String, Object> map);
	// 메뉴 목록
	List<Menu> selectMenuList(HashMap<String, Object> map);
	// 메뉴 추가
	int productAdd(HashMap<String, Object> map);
	// 음식 이미지 추가
	int insertFoodimg(HashMap<String, Object> map);
	// 음식 상세보기
	Product getProductInfo(HashMap<String, Object> map);
	
	
}
