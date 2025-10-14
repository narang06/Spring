package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.google.gson.Gson;

@Controller
public class MapController {


	
	@RequestMapping("/map1.do") 
    public String map1(Model model) throws Exception{

        return "/Map/map1";
    }
	
	@RequestMapping("/map2.do") 
    public String map2(Model model) throws Exception{

        return "/Map/map2";
    }

	
}
