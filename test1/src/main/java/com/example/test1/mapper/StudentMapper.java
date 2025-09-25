package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;

@Mapper
public interface StudentMapper {
	
	Student StudentInfo(HashMap<String, Object> map);
	
	
}
