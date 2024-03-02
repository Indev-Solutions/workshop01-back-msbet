package com.indevsolutions.workshop.bet.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.indevsolutions.workshop.bet.domain.Bet;

public interface BetRepository extends JpaRepository<Bet, Long> {

	List<Bet> findByLeagueId(Long leagueId);	
}
