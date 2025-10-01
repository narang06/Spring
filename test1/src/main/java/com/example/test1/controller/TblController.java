package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.TblService;
import com.google.gson.Gson;

@Controller
public class TblController {

	@Autowired
	TblService tblService;
	
	
	@RequestMapping("/board-list.do") 
    public String login(Model model) throws Exception{

        return "tbl";
        
    }
	
	@RequestMapping("/board-add.do") 
    public String insert(Model model) throws Exception{

        return "tbl-add";
        
    }
	
	@RequestMapping("/board-view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map);
		request.setAttribute("boardNo",map.get("boardNo"));
        return "tbl-view";
        
    }
	
	
	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String tblList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = tblService.tblList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board-list-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String tblListDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = tblService.tblDelete(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String tblAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = tblService.tblAdd(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String tblInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = tblService.tblInfo(map);
		
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/comment/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commentAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = tblService.commentAdd(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/comment/delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commentDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = tblService.commentDelete(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
}
