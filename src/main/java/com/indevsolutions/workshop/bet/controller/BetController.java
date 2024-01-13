package com.indevsolutions.workshop.bet.controller;

import java.util.List;
import java.util.Set;

import org.apache.commons.collections4.CollectionUtils;
import org.modelmapper.ModelMapper;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.indevsolutions.workshop.bet.dto.BetDTO;
import com.indevsolutions.workshop.bet.service.BetService;

@RestController
@RequestMapping("/bets")
public class BetController {

	private final BetService betService;
	private final ModelMapper modelMapper;

	public BetController(BetService betService, ModelMapper modelMapper) {
		super();
		this.betService = betService;
		this.modelMapper = modelMapper;
	}

	@GetMapping
	public List<BetDTO> findBets(@RequestParam(required = false) Set<Long> id,
			@RequestParam(required = false) Long leagueId, @RequestParam(required = false) Integer status) {

		if (CollectionUtils.isNotEmpty(id)) {
			return betService.findBetsByIds(id);
		}

		if (leagueId != null) {
			return betService.findBetsByLeagueIdAndStatus(leagueId, status);
		}

		return betService.findBetsByStatus(status);
	}

	@GetMapping("/{id}")
	public BetDTO findBetsById(@PathVariable Long id) {
		var bet = betService.findBetById(id);
		return modelMapper.map(bet, BetDTO.class);
	}
}
