package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.PointService;
import com.example.test1.dao.UserService;
import com.google.gson.Gson;

@Controller
public class PointController {

	@Autowired
	PointService pointService;
	
	@RequestMapping("/point/chart.do") 
    public String login(Model model) throws Exception{

        return "/Point/chart";
    }
	
	@RequestMapping(value = "/point/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
		resultMap = pointService.getPointList(map);
		
		return new Gson().toJson(resultMap);
	}
	
}
