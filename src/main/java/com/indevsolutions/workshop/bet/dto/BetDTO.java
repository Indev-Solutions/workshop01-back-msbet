package com.indevsolutions.workshop.bet.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;

public class BetDTO {

	private Long id;

	private Long leagueId;
	private String match;	
	private LocalDateTime matchDate;
	private Integer status;
	private BigDecimal minAmount;
	private BigDecimal maxAmount;
	private Long resultId;
	private Set<BetOptionDTO> options;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getLeagueId() {
		return leagueId;
	}
	public void setLeagueId(Long leagueId) {
		this.leagueId = leagueId;
	}
	public String getMatch() {
		return match;
	}
	public void setMatch(String match) {
		this.match = match;
	}
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Set<BetOptionDTO> getOptions() {
		return options;
	}
	public void setOptions(Set<BetOptionDTO> options) {
		this.options = options;
	}
	public LocalDateTime getMatchDate() {
		return matchDate;
	}
	public void setMatchDate(LocalDateTime matchDate) {
		this.matchDate = matchDate;
	}
	public Long getResultId() {
		return resultId;	
	}
	public void setResultId(Long resultId) {
		this.resultId = resultId;
	}
	public BigDecimal getMinAmount() {
		return minAmount;
	}
	public void setMinAmount(BigDecimal minAmount) {
		this.minAmount = minAmount;
	}
	public BigDecimal getMaxAmount() {
		return maxAmount;
	}
	public void setMaxAmount(BigDecimal maxAmount) {
		this.maxAmount = maxAmount;
	}
	
	
}
