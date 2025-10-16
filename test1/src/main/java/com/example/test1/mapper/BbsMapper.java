package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;
import com.example.test1.model.Tbl;

@Mapper
public interface BbsMapper {
	
	// 게시글 리스트
	List<Bbs> getBbsList(HashMap<String, Object> map);
	// 게시글 전체 개수
	int bbsListCnt(HashMap<String, Object> map);
	// 게시글 추가
	int bbsAdd(HashMap<String, Object> map);
	// 게시글 이미지 추가
	int insertBbsImg(HashMap<String, Object> map);
	// 게시글 선택 삭제
	int bbsDelete(HashMap<String, Object> map);
	// 게시글 상세보기
	Bbs bbsInfo(HashMap<String, Object> map);
	// 첨부파일 보기
	List<Bbs> bbsImgInfo(HashMap<String, Object> map);
	// 게시글 수정
	void bbsUpdate(HashMap<String, Object> map);
}
