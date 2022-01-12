-- @file create_database.sql
-- @brief Fills ucr6 database with initial values
-- @date 2022-Jan-12
-- @copyright GPLv3
CREATE DATABASE ucr6;
USE ucr6;

CREATE TABLE map (
    name VARCHAR(64) NOT NULL,
    CONSTRAINT pk_name PRIMARY KEY(name)
);

CREATE TABLE site (
    map VARCHAR(64) NOT NULL,
    site1 VARCHAR(64) NOT NULL,
    site2 VARCHAR(64) NOT NULL,
    CONSTRAINT pk_site PRIMARY KEY(map, site1, site2),
    CONSTRAINT fk_map FOREIGN KEY(map) REFERENCES map(name)
);

CREATE TABLE team (
    name VARCHAR(64) NOT NULL,
    CONSTRAINT pk_team PRIMARY KEY(name)
);

CREATE TABLE player (
    -- uuid is the r6 tracker uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
    uuid CHAR(36) NOT NULL,
    given_name VARCHAR(255) NOT NULL,
    family_name VARCHAR(255) NOT NULL,
    team_name VARCHAR(64) NOT NULL,
    CONSTRAINT pk_player PRIMARY KEY(uuid),
    CONSTRAINT fk_team_name FOREIGN KEY(team_name) REFERENCES team(name)
);

create TABLE game_series (
    id VARCHAR(64) NOT NULL,
    date_ DATE NOT NULL,
    opponent VARCHAR(64) NOT NULL,
    CONSTRAINT pk_match PRIMARY KEY(id)
);

create TABLE game (
    id VARCHAR(64) NOT NULL,
    map VARCHAR(64) NOT NULL,
    -- TODO: figure out a good way to id game series...
    series_id VARCHAR(64) NOT NULL,
    num_rounds INT NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT fk_series_id FOREIGN KEY(series_id) REFERENCES game_series(id),
    CONSTRAINT fk_map_name FOREIGN KEY(map) REFERENCES map(name)
);

create TABLE performance (
    player_uuid CHAR(36) NOT NULL,
    game_id VARCHAR(64) NOT NULL,
    -- Counter statistics:
    kills INT NOT NULL,
    deaths INT NOT NULL,
    assists INT NOT NULL,
    teamkills_in INT NOT NULL,
    teamkills_out INT NOT NULL,
    -- trade_diff INT NOT NULL,
    refrags INT NOT NULL,
    headshots INT NOT NULL,
    underdogs INT NOT NULL,
    1vx INT NOT NULL,
    -- This can be left out if we track per-round data, but we don't
    multikill_rds INT NOT NULL,
    trades_out INT NOT NULL,
    trades_in INT NOT NULL,
    op_kills INT NOT NULL,
    op_deaths INT NOT NULL,
    entry_kills INT NOT NULL,
    entry_deaths INT NOT NULL,
    plants INT NOT NULL,
    disables INT NOT NULL,
    last_alive INT NOT NULL,
    points INT NOT NULL,

    -- Ratio statistics:
    kost DEC(3, 2) NOT NULL,
    -- kpr can be calculated from kills / map(map_id).rounds
    -- srv can be calculated from game(id).rounds - deaths
    -- hs ratio can be calculated from headshots / kills

    CONSTRAINT pk_performance PRIMARY KEY(player_uuid, game_id),
    CONSTRAINT fk_player_uuid FOREIGN KEY(player_uuid) REFERENCES player(uuid),
    CONSTRAINT fk_game_id FOREIGN KEY(game_id) REFERENCES game(id)
);
