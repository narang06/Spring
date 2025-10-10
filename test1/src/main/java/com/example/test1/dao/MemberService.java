package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

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
		String message = "";
		String result ="";	
//		String message = member != null ? "로그인 성공" : "로그인 실패";
//		String result = member != null ? "success" : "fail";
		
		if(member != null) {
			if(member.getCnt() >= 5){
				message = "로그인 시도 횟수 초과로 계정이 잠겼습니다. 관리자에게 문의하세요.";
				result = "fail";
			} else {
				memberMapper.resetLoginCnt(map);
				message = "로그인 성공";
				session.setAttribute("sessionId",member.getUserId());
				session.setAttribute("sessionName",member.getName());
				session.setAttribute("sessionStatus",member.getStatus());
				if(member.getStatus().equals("A")) {
					result = "admin";	
				} else {
					result = "success";
				}
			}		
		} else {
			Member idCheck = memberMapper.idCheck(map);
			if(idCheck != null){
				memberMapper.updateLoginCnt(map);
				message = "패스워드를 확인해주세요";
			} else {
				message = "아이디가 존재하지 않습니다";
			}
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

	public void addMemberImg(HashMap<String, Object> map) {
		int cnt = memberMapper.insertMemberimg(map);
		
	}

	public HashMap<String, Object> adminLogin(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Member> list = memberMapper.adminLogin(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}		
		return resultMap;	
	}

	public HashMap<String, Object> memberCntReset(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			memberMapper.resetLoginCnt(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}		
			
		return resultMap;
	}
	
}
