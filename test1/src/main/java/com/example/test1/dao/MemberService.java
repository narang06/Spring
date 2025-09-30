package com.example.test1.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {
	
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;
	
	
	public HashMap<String, Object> memberLogin(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		Member member = memberMapper.memberLogin(map);
		String message = member != null ? "로그인 성공" : "로그인 실패";
		String result = member != null ? "success" : "fail";
	
		if(member != null) {
			session.setAttribute("sessionId",member.getUserId());
			session.setAttribute("sessionName",member.getName());
			session.setAttribute("sessionStatus",member.getStatus());
		}
		
		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
	}

	public HashMap<String, Object> memberLogout(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// 세션정보 삭제
		// 1개씩 키값을 지우거나, 전채를 삭제
		
		String message = session.getAttribute("sessionName") + "님 로그아웃 되었습니다.";
		resultMap.put("msg", message);
		
//		session.removeAttribute("sessionId"); // 1개씩 삭제
		session.invalidate(); // 세션정보 전체 삭제
		return resultMap;
	}
	
	public HashMap<String, Object> memberInsert(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = memberMapper.memberAdd(map);
		if(cnt < 1) {
			resultMap.put("result", "fail");
		} else {
			resultMap.put("result", "success");
		}
		
		return resultMap;
	}
	
}
