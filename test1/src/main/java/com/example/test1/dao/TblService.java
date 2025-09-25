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
	
	public HashMap<String, Object> tblDelete(Tbl boardNo) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> param = new HashMap<>();
		param.put("boardNo", boardNo);
		
		return resultMap;
	}
}
