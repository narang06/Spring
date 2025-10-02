package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.StudentMapper;
import com.example.test1.model.Student;

@Service
public class StudentService {
	
	@Autowired
	StudentMapper studentMapper;
	
	
	public HashMap<String, Object> studentInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service => " + map);
		Student student = studentMapper.studentInfo(map);
		if(student != null) {
			System.out.println(student.getStuNo());
			System.out.println(student.getStuName());
			System.out.println(student.getStuDept());
		}
		
		resultMap.put("info",student);
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> studentList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Student> list = studentMapper.studentList(map);
		
		resultMap.put("list", list);
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> removeStudentList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = studentMapper.removeStudentList(map);
		
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> getStudentInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Student info = studentMapper.getStudentInfo(map);
		
		resultMap.put("info", info);
		resultMap.put("result","success");
		return resultMap;
	}
	
	public HashMap<String, Object> getdeleteList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = studentMapper.deleteList(map);
		
		resultMap.put("result","success");
		return resultMap;
	}
}
