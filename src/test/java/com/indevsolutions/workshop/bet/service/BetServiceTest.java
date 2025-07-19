package com.indevsolutions.workshop.bet.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.when;

import java.time.LocalDateTime;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.modelmapper.ModelMapper;
import org.springframework.test.util.ReflectionTestUtils;

import com.indevsolutions.workshop.bet.domain.Bet;
import com.indevsolutions.workshop.bet.repository.BetRepository;

@ExtendWith(MockitoExtension.class)
class BetServiceTest {

	@Mock
	public BetRepository betRepository;

	@InjectMocks
	public BetService betService;

	@BeforeEach
	void setUp() {
		when(betRepository.findByLeagueId(anyLong())).thenReturn(bets());
		ReflectionTestUtils.setField(betService, "modelMapper", new ModelMapper());
	}

	private List<Bet> bets() {
		var newBet = new Bet();

		var tomorrow = LocalDateTime.now().plusDays(1);
		newBet.setMatchDate(tomorrow);
		newBet.setLeagueId(1l);

		var oldBet = new Bet();
		var yesterday = LocalDateTime.now().minusDays(1);
		oldBet.setMatchDate(yesterday);
		oldBet.setLeagueId(1l);

		return List.of(oldBet, newBet);
	}

	@Test
	void testFindBetsByLeagueId() {

		var bets = betService.findBetsByLeagueIdAndStatus(1l, null);

		assertNotNull(bets);
		assertEquals(2, bets.size());
	}

	@Test
	void testFindBetsByLeagueIdAndStatus() {

		var bets = betService.findBetsByLeagueIdAndStatus(1l, 1);

		assertNotNull(bets);
		assertEquals(1, bets.size());
	}

	@Test
	void testFindBetsByLeagueIdAndStatusWithoutResult() {

		var bets = betService.findBetsByLeagueIdAndStatus(1l, 3);

		assertNotNull(bets);
		assertEquals(0, bets.size());
	}
}
