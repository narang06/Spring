package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;


@Service
public class ProductService {
	
	@Autowired
	ProductMapper productMapper;

	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Product> list = productMapper.productList(map);
			List<Menu> menuList = productMapper.selectMenuList(map);
			resultMap.put("list", list);
			resultMap.put("menuList", menuList);
			resultMap.put("result","success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result","fail");
			System.out.println();
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> getProductListSearch(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Product> search = productMapper.productListSearch(map);
		
		resultMap.put("search", search);
		resultMap.put("result","success");
		return resultMap;
	}

	public HashMap<String, Object> addProductList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = productMapper.productAdd(map);
			resultMap.put("",cnt);
			resultMap.put("result","success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result","fail");
		}
		
		return resultMap;
	}


	
}
