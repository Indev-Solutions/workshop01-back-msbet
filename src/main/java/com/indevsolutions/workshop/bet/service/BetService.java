package com.indevsolutions.workshop.bet.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.apache.commons.lang3.ObjectUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.indevsolutions.workshop.bet.domain.Bet;
import com.indevsolutions.workshop.bet.dto.BetDTO;
import com.indevsolutions.workshop.bet.repository.BetRepository;

@Service
public class BetService {

	@Autowired
	private BetRepository betRepository;

	@Autowired
	private ModelMapper modelMapper;

	/**
	 * Find bets by ids
	 * 
	 * @param ids
	 * @return
	 */
	public List<BetDTO> findBetsByIds(Set<Long> ids) {
		return mapBets(betRepository.findAllById(ids));
	}

	/**
	 * Find bets by league id and status
	 * 
	 * @param leagueId
	 * @param status
	 * @return
	 */
	public List<BetDTO> findBetsByLeagueIdAndStatus(Long leagueId, Integer status) {
		var bets = mapBets(betRepository.findByLeagueId(leagueId));
		return filterByStatus(bets, status);
	}

	/**
	 * Find bets by status
	 * 
	 * @param status
	 * @return
	 */
	public List<BetDTO> findBetsByStatus(Integer status) {
		var bets = mapBets(betRepository.findAll());
		return filterByStatus(bets, status);
	}

	/**
	 * Return the bets filtered by status
	 * 
	 * @param bets
	 * @param status
	 * @return
	 */
	private List<BetDTO> filterByStatus(List<BetDTO> bets, Integer status) {
		if (status == null) {
			return bets;
		}

		return bets.stream().filter(b -> ObjectUtils.compare(b.getStatus(), status) == 0).toList();
	}

	/**
	 * Convert the list of bet entities to a list of dto
	 * 
	 * @param bets
	 * @return
	 */
	private List<BetDTO> mapBets(List<Bet> bets) {
		var now = LocalDateTime.now();
		return bets.stream().map(mapBet(now)).collect(Collectors.toList());
	}

	/**
	 * Convert a bet entity to a dto
	 * 
	 * @param now
	 * @return
	 */
	private Function<? super Bet, ? extends BetDTO> mapBet(LocalDateTime now) {
		return b -> {
			var betDto = modelMapper.map(b, BetDTO.class);
			if (now.isBefore(b.getMatchDate())) {
				betDto.setStatus(1);

			} else {
				betDto.setStatus(2);
			}

			return betDto;
		};
	}

	/**
	 * Find a bet by id
	 * 
	 * @param id
	 * @return
	 */
	public Bet findBetById(Long id) {
		return betRepository.getReferenceById(id);
	}
}
