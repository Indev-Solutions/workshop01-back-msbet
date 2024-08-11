INSERT INTO bet_schema.bet (id, league_id, "match", match_date) VALUES(1, 1, 'Universitario vs Alianza', '2024-08-30 18:32:33.034');
INSERT INTO bet_schema.bet (id, league_id, "match", match_date) VALUES(2, 2, 'Barcelona vs Real Madrid', '2024-08-10 18:32:33.034');

INSERT INTO bet_schema.bet_option (id, rate, bet_id, description) VALUES(1, 0.30, 1, 'Universitario');
INSERT INTO bet_schema.bet_option (id, rate, bet_id, description) VALUES(2, 0.10, 1, 'Empate');
INSERT INTO bet_schema.bet_option (id, rate, bet_id, description) VALUES(3, 0.60, 1, 'Alianza Lima');

INSERT INTO bet_schema.bet_option (id, rate, bet_id, description) VALUES(4, 0.30, 2, 'Barcelona');
INSERT INTO bet_schema.bet_option (id, rate, bet_id, description) VALUES(5, 0.10, 2, 'Empate');
INSERT INTO bet_schema.bet_option (id, rate, bet_id, description) VALUES(6, 0.60, 2, 'Real Madrid');

UPDATE bet_schema.bet SET result_id = 4 WHERE id = 2;