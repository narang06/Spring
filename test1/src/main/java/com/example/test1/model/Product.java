package com.example.test1.model;

import lombok.Data;

@Data
public class Product {
	private String foodNo;
	private String foodName;
	private int price;
	private String foodKind;
	private String foodInfo;
	private String sellYn;
	
	
// food Img
	private String foodFileNo;
	private String filePath;
	private String fileName;
	private String thumbnailYn;
		
}
