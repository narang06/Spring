package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Area;

@Mapper
public interface AreaMapper {
	
	// area 리스트 출력
	List<Area> areaList(HashMap<String, Object> map);
	
	// area 리스트 개수
	int areaListCnt(HashMap<String, Object> map);
	
	// area 내 si/do 리스트
	List<Area> selectSiList(HashMap<String, Object> map);
	
	// area 내 gu 리스트
	List<Area> selectGuList(HashMap<String, Object> map);
	
	// area 내 dong 리스트
	List<Area> selectDongList(HashMap<String, Object> map);
	
}
