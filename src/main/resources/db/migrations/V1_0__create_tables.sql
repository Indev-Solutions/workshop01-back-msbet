CREATE TABLE bet_schema.bet (
	id int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	league_id int4 NOT NULL,
	"match" varchar NOT NULL,
	match_date timestamptz NOT NULL,
	result_id int4,
	status INTEGER,
	CONSTRAINT bet_pk PRIMARY KEY (id)
);

CREATE TABLE bet_schema.bet_option (
	id int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	description varchar NOT NULL,
	rate numeric(2, 2) NOT NULL,
	bet_id int4 NOT NULL,
	CONSTRAINT bet_option_pk PRIMARY KEY (id),
	CONSTRAINT bet_option_fk FOREIGN KEY (bet_id) REFERENCES bet_schema.bet(id)
);