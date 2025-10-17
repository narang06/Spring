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
	
	// 게시글 리스트
	public HashMap<String, Object> bbsList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Bbs> list = bbsMapper.getBbsList(map);
		int cnt = bbsMapper.bbsListCnt(map);
	
		resultMap.put("cnt",cnt);
		resultMap.put("list", list);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	// 게시글 추가
	public HashMap<String, Object> bbsAdd(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int bbs = bbsMapper.bbsAdd(map);
		
		resultMap.put("bbsNum",map.get("bbsNum"));
		resultMap.put("result","success");
		return resultMap;
	}
	// 이미지 추가
	public void addBbsImg(HashMap<String, Object> map) {
		int cnt = bbsMapper.insertBbsImg(map);
		
	}
	// 게시글 삭제
	public HashMap<String, Object> bbsDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		bbsMapper.bbsDelete(map);
		
		resultMap.put("result","success");
		return resultMap;
	}
	// 게시글 상세보기
	public HashMap<String, Object> bbsInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
	
		Bbs info = bbsMapper.bbsInfo(map);
		List<Bbs> fileList = bbsMapper.bbsImgInfo(map);
		
		resultMap.put("fileList", fileList);
		resultMap.put("info", info);
		resultMap.put("result","success");
		return resultMap;
	}
	// 게시글 수정
	public HashMap<String, Object> bbsUpdate(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		bbsMapper.bbsUpdate(map);
		return resultMap;
	}
}
