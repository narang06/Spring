package com.example.test1.model;

import lombok.Data;

@Data
public class paymentHistory {
	private String orderId;
	private String userId;
	private int amount;
	private String productNo;
	private String paymentDate;
}
