package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Tbl;

@Mapper
public interface TblMapper {
	
	List<Tbl> tblList(HashMap<String, Object> map);
	Tbl tblDelete(HashMap<String, Object> map);
	
}
