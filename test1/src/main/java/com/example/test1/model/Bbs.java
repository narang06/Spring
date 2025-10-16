package com.example.test1.model;

import lombok.Data;

@Data
public class Bbs {
	private String bbsNum;
	private String title;
	private String contents;
	private int hit;
	private String userId;
	private String cdatetime;
	private String udatetime;
	// board file
	private String fileNo;
	private String fileName;
	private String filePath;
	
}
