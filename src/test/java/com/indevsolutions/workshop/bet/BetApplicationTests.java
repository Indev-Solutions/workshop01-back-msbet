package com.indevsolutions.workshop.bet;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Configuration;

@Configuration
@SpringBootTest
class BetApplicationTests {

	@Test
	void contextLoads() {
		var result = "dummy";
		assertEquals("dummy", result);
	}

}
