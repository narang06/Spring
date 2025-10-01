package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.AreaMapper;
import com.example.test1.model.Area;

@Service
public class AreaService {
	
	@Autowired
	AreaMapper areaMapper;
	
	
	public HashMap<String, Object> areaList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = areaMapper.areaListCnt(map);
		List<Area> list = areaMapper.areaList(map);
		
		resultMap.put("cnt",cnt);
		resultMap.put("list", list);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	
	public HashMap<String, Object> getSiList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Area> list = areaMapper.selectSiList(map);
		
		resultMap.put("list", list);
		resultMap.put("result", "success");
		
		return resultMap;
	}
}
