package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.example.test1.controller.PointController;
import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {

    private final PointController pointController;
	
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	PasswordEncoder passwordEncoder;


    MemberService(PointController pointController) {
        this.pointController = pointController;
    }
	
	
	public HashMap<String, Object> memberLogin(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		Member member = memberMapper.memberLogin(map);
		
		String message = "";
		String result ="";	
//		String message = member != null ? "로그인 성공" : "로그인 실패";
//		String result = member != null ? "success" : "fail";
		
		
		/* 해시 적용후 버전 */
		if(member != null) {
			// 아이디가 존재, 비밀번호 비교전
			// 사용자가 보낸 비밀번호 map에서 꺼낸 후 해시화한 값과
			// member 객체 안에 있는 password와 비교
			boolean loginFlg = passwordEncoder.matches((String) map.get("pwd"), member.getPassword());
			if(loginFlg) {
				// 비밀번호 정상 입력
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
				// 아이디 존재 , 비밀번호 틀림
				memberMapper.updateLoginCnt(map);
				message = "패스워드를 확인해주세요";
				result = "fail";
			}
		} else {
			// 아이디가 없음	
			message = "아이디가 존재하지 않습니다";
			result = "fail";
		}
		
		
		
		
		/*-------------------- 해시 적용후 버전 ----------------------*/
		
		/* 해시 적용전 버전 */
		
//		if(member != null) {
//			if(member.getCnt() >= 5){
//				message = "로그인 시도 횟수 초과로 계정이 잠겼습니다. 관리자에게 문의하세요.";
//				result = "fail";
//			} else {
//				memberMapper.resetLoginCnt(map);
//				message = "로그인 성공";
//				session.setAttribute("sessionId",member.getUserId());
//				session.setAttribute("sessionName",member.getName());
//				session.setAttribute("sessionStatus",member.getStatus());
//				if(member.getStatus().equals("A")) {
//					result = "admin";	
//				} else {
//					result = "success";
//				}
//			}		
//		} else {
//			Member idCheck = memberMapper.idCheck(map);
//			if(idCheck != null){
//				memberMapper.updateLoginCnt(map);
//				message = "패스워드를 확인해주세요";
//			} else {
//				message = "아이디가 존재하지 않습니다";
//			}
//		}	
		
		/*-------------------- 해시 적용전 버전 ----------------------*/
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
		
		String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
		map.put("hashPwd", hashPwd);
		
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
			int cnt = memberMapper.memberListCnt(map);
			
			resultMap.put("cnt", cnt);
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
	
	public HashMap<String, Object> authUser(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Member memberAuth = memberMapper.authUser(map);
			if(memberAuth != null) {	
				resultMap.put("auth", "success");
			} else {
				resultMap.put("auth", "fail");
			}	
		} catch (Exception e) {
			resultMap.put("auth", "error");
			System.out.println(e.getMessage());
		}
		
			
			
		return resultMap;
	}
	
	public HashMap<String, Object> changePwd(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Member member = memberMapper.memberLogin(map);
			boolean pwdFlg = passwordEncoder.matches((String) map.get("pwd"),member.getPassword());
			if(pwdFlg) {
				resultMap.put("result", "fail");
				resultMap.put("msg", "비밀번호가 이전과 동일합니다.");
			} else {
				String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
				map.put("hashPwd", hashPwd);
				memberMapper.changePwd(map);
				resultMap.put("result", "success");
				resultMap.put("msg", "수정되었습니다.");
			}
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("msg", "오류가 발생했습니다..");
			System.out.println(e.toString()); // 에러 로그 출력
		}
		return resultMap;
	}
	
}
