package com.example.test1.dao;

import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MainService {
	
	@Autowired
	MemberMapper memberMapper;
	
	
	public HashMap<String, Object> idCheck(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String id = (String) map.get("id");
			
		Member idcheck = memberMapper.idCheck(map);
		String result = idcheck != null ? "false" : "true";
		
		
		resultMap.put("result", result);

		
		return resultMap;
	}
}
