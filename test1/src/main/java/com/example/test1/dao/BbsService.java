package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;
import com.example.test1.model.Comment;
import com.example.test1.model.Tbl;

@Service
public class BbsService {
	
	@Autowired
	BbsMapper bbsMapper;
	
	
	public HashMap<String, Object> bbsList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Bbs> list = bbsMapper.getBbsList(map);
		int cnt = bbsMapper.bbsListCnt(map);
	
		resultMap.put("cnt",cnt);
		resultMap.put("list", list);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	
	public HashMap<String, Object> bbsAdd(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int bbs = bbsMapper.bbsAdd(map);
		
		resultMap.put("bbsNum",map.get("bbsNum"));
		resultMap.put("result","success");
		return resultMap;
	}
	
	public void addBbsImg(HashMap<String, Object> map) {
		int cnt = bbsMapper.insertBbsImg(map);
		
	}
	
	public HashMap<String, Object> bbsDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = bbsMapper.bbsDelete(map);
		
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> bbsInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
	
		Bbs info = bbsMapper.bbsInfo(map);
		List<Bbs> fileList = bbsMapper.bbsImgInfo(map);
		
		resultMap.put("fileList", fileList);
		resultMap.put("info", info);
		resultMap.put("result","success");
		return resultMap;
	}

	public void bbsUpdate(HashMap<String, Object> map) {
	    bbsMapper.bbsUpdate(map);
	}
}
