package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.PointMapper;
import com.example.test1.model.Point;


@Service
public class PointService {
	
	@Autowired
	PointMapper pointMapper;
	
	
	public HashMap<String, Object> getPointList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Point> customer = pointMapper.selectPointList(map);
		
		resultMap.put("list", customer);
		resultMap.put("result", "success");
		
		return resultMap;
	}
}
