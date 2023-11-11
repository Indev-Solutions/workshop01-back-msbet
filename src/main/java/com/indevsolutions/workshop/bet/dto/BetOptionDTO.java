package com.indevsolutions.workshop.bet.dto;

import java.math.BigDecimal;

public class BetOptionDTO {

	private Long id;
	private String description;	
	private BigDecimal rate;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public BigDecimal getRate() {
		return rate;
	}
	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}
}
