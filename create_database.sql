-- @file create_database.sql
-- @brief Fills ucr6 database with initial values
-- @date 2022-Jan-12
-- @copyright GPLv3
CREATE DATABASE ucr6;
USE ucr6;

CREATE TABLE maps (
    name VARCHAR(64) NOT NULL,

    PRIMARY KEY(name)
);

CREATE TABLE sites (
    map VARCHAR(64) NOT NULL,
    site1 VARCHAR(64) NOT NULL,
    site2 VARCHAR(64) NOT NULL,

    PRIMARY KEY(map, site1, site2),
    CONSTRAINT fk_site_map FOREIGN KEY(map) REFERENCES maps(name)
);

CREATE TABLE teams (
    name VARCHAR(64) NOT NULL,
    -- attack_wins INT NOT NULL,
    -- defense_wins INT NOT NULL,
    -- round wins derived from these two above
    -- game_wins INT NOT NULL,
    -- match_wins INT NOT NULL,
    PRIMARY KEY(name)
);

CREATE TABLE players (
    -- uuid is the r6 tracker uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
    uuid CHAR(36) NOT NULL,
    given_name VARCHAR(255) NOT NULL,
    family_name VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    team VARCHAR(64) NOT NULL,

    PRIMARY KEY(uuid),
    CONSTRAINT fk_player_team FOREIGN KEY(team) REFERENCES teams(name)
);

create TABLE matches (
    match_date DATE NOT NULL,
    team VARCHAR(64) NOT NULL,
    opponent VARCHAR(64) NOT NULL,

    PRIMARY KEY(match_date, team, opponent),
    CONSTRAINT fk_match_team FOREIGN KEY(team) REFERENCES teams(name)
);

create TABLE games (
    id VARCHAR(64) NOT NULL,
    map VARCHAR(64) NOT NULL,

    -- foreign composite primary key >.>
    match_date DATE NOT NULL,
    match_team VARCHAR(64) NOT NULL,
    match_opp VARCHAR(64) NOT NULL,

    num_rounds INT NOT NULL,
    -- todo: how to handle checking if winners are valid teams...?

    PRIMARY KEY(id),
    CONSTRAINT fk_game_match FOREIGN KEY(match_date, match_team, match_opp)
        REFERENCES matches(match_date, team, opponent),
    CONSTRAINT fk_game_map FOREIGN KEY(map) REFERENCES maps(name)
);

create TABLE performances (
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

    PRIMARY KEY(player_uuid, game_id),
    CONSTRAINT fk_perf_player FOREIGN KEY(player_uuid) REFERENCES players(uuid),
    CONSTRAINT fk_perf_game FOREIGN KEY(game_id) REFERENCES games(id)
);
