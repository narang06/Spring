package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.TblMapper;
import com.example.test1.model.Tbl;

@Service
public class TblService {
	
	@Autowired
	TblMapper tblMapper;
		
	public HashMap<String, Object> tblList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Tbl> list = tblMapper.tblList(map);
		
		resultMap.put("list", list);
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> tblDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = tblMapper.tblDelete(map);
		
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> tblAdd(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = tblMapper.tblAdd(map);
		
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> tblInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Tbl info = tblMapper.tblInfo(map);
		
		resultMap.put("info", info);
		resultMap.put("result","success");
		return resultMap;
	}
}
