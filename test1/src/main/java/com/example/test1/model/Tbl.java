package com.example.test1.model;

import lombok.Data;

@Data
public class Tbl {
	private String boardNo;
	private String title;
	private String contents;
	private String userId;
	private String cnt;
	private String favorite;
	private String kind;
	private String cdate;
	private String commentCount;
	
	// board file
	private String fileNo;
	private String fileName;
	private String filePath;

}
