package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	
	// 로그인
	Member memberLogin(HashMap<String, Object> map);
	
	// 중복체크
	Member idCheck(HashMap<String, Object> map);
	
	// 가입
	int memberAdd(HashMap<String, Object> map);

	// 로그인 이미지 업로드
	int insertMemberimg(HashMap<String, Object> map);
	
	
}
