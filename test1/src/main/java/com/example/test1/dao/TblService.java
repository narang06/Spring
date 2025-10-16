package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.TblMapper;
import com.example.test1.model.Comment;
import com.example.test1.model.Tbl;

@Service
public class TblService {
	
	@Autowired
	TblMapper tblMapper;
		
	public HashMap<String, Object> tblList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = tblMapper.tblListCnt(map);
		List<Tbl> list = tblMapper.tblList(map);
		
		resultMap.put("cnt",cnt);
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
	
	public HashMap<String, Object> getdeleteList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = tblMapper.deleteList(map);
		
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> tblAdd(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = tblMapper.tblAdd(map);
		
		resultMap.put("boardNo",map.get("boardNo"));
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> tblInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		tblMapper.tblCnt(map);
		Tbl info = tblMapper.tblInfo(map);
		List<Comment> commentList = tblMapper.tblCommentInfo(map);		
		List<Tbl> fileList = tblMapper.TblimgInfo(map);
		
		
		resultMap.put("fileList", fileList);
		resultMap.put("commentList", commentList);
		resultMap.put("info", info);
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> commentAdd(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = tblMapper.commentAdd(map);
			resultMap.put("result","success");
			resultMap.put("msg","댓글이 등록되었습니다.");
		} catch (Exception e) {
			resultMap.put("result","fail");
			resultMap.put("msg","서버오류가 발생했습니다. 다시 시도해주세요.");
		}
			
		
		return resultMap;
	}
	
	public HashMap<String, Object> commentDelete(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = tblMapper.commentDelete(map);
			resultMap.put("result","success");
			resultMap.put("msg","댓글이 삭제되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("result","fail");
			resultMap.put("msg","서버오류가 발생했습니다. 다시 시도해주세요.");
		}
						
		return resultMap;
	}

	public void addBoardImg(HashMap<String, Object> map) {
		int cnt = tblMapper.insertTblimg(map);
		
	}
	
}
