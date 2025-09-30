package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Comment;
import com.example.test1.model.Tbl;

@Mapper
public interface TblMapper {
	
	// 게시글 목록
	List<Tbl> tblList(HashMap<String, Object> map);
	
	// 게시글 삭제
	int tblDelete(HashMap<String, Object> map);
	
	// 게시글 추가
	int tblAdd(HashMap<String, Object> map);
	
	// 게시글 상세정보
	Tbl tblInfo(HashMap<String, Object> map);
	
	// 댓글 목록
	List<Comment> tblCommentInfo(HashMap<String, Object> map);
	
	
}
