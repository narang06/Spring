package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Student;

@Mapper
public interface StudentMapper {
	
	
	Student studentInfo(HashMap<String, Object> map);
	// 학생 목록
	List<Student> studentList(HashMap<String, Object> map);
	// 학생 삭제
	int removeStudentList(HashMap<String, Object> map);
	// 학생 상세 정보
	Student getStudentInfo(HashMap<String, Object> map);
}
