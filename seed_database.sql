-- @file seed_database.sql
-- @brief Helper script to fill UC R6 database with initial values
-- @date 2022-Jan-12
-- @copyright GPLv3
USE ucr6;

INSERT INTO maps VALUES
    ("Bank"),
    ("Chalet"),
    ("Clubhouse"),
    ("Coastline"),
    -- todo: check accents?
    ("Kafe Dostoyevsky"),
    ("Oregon"),
    ("Villa");

INSERT INTO sites VALUES
    ("Bank", "2F Executive Lounge", "2F CEO Office"),
    ("Bank", "1F Staff Room", "1F Open Area"),
    ("Bank", "1F Teller's Office", "1F Archive"),
    ("Bank", "B Lockers", "B CCTV Room"),
    ("Chalet", "2F Master Bedroom", "2F Office"),
    ("Chalet", "1F Bar", "1F Gaming Room"),
    ("Chalet", "1F Dining Room", "1F Kitchen"),
    ("Chalet", "B Wine Cellar", "B Snowmobile Garage"),
    ("Clubhouse", "2F Gym", "2F Bedroom"),
    ("Clubhouse", "2F CCTV Room", "2F Cash Room"),
    ("Clubhouse", "1F Bar", "1F Stage"),
    ("Clubhouse", "B Church", "B Arsenal"),
    ("Coastline", "2F Theater", "2F Penthouse"),
    ("Coastline", "2F Hookah Lounge", "2F Billiards Room"),
    ("Coastline", "1F Blue Bar", "1F Sunrise Bar"),
    ("Coastline", "1F Service Entrance", "1F Kitchen"),
    ("Kafe Dostoyevsky", "3F Cocktail Lounge", "3F Bar"),
    ("Kafe Dostoyevsky", "2F Mining Room", "2F Fireplace Hall"),
    ("Kafe Dostoyevsky", "2F Reading Room", "2F Fireplace Hall"),
    ("Kafe Dostoyevsky", "1F Kitchen Service", "1F Kitchen Cooking"),
    ("Oregon", "2F Main Dorms Hall", "2F Kids Dormitory"),
    ("Oregon", "1F Dining Hall", "1F Kitchen"),
    ("Oregon", "1F Meeting Hall", "1F Kitchen"),
    ("Oregon", "B Laundry Room", "B Supply Room"),
    ("Villa", "2F Aviator Room", "2F Games Room"),
    ("Villa", "2F Trophy Room", "2F Statuary Room"),
    ("Villa", "1F Living Room", "1F Library"),
    ("Villa", "1F Dining Room", "1F Kitchen");


INSERT INTO teams VALUES
    ("UC Red"),
    ("UC Black");

INSERT INTO players VALUES
    ("abab1d1a-98c7-4adf-a2da-88e61418761b", "Kyle", "Gish", "Cream.UC", "UC Red"),
    ("72df8130-2ca3-4be9-86ba-72006b0d4667", "Donald", "Combs", "DLCv2.UC", "UC Red"),
    ("fd2e03fd-96b4-41e0-bedb-e435c02ad49d", "Cam", "Bartsch", "Dubz.-", "UC Red"),
    ("f157e780-8ebd-4d33-b3aa-c40a955d2f08", "Kyle", "Brittingham", "Kithin.UC", "UC Red"),
    ("2b6c9fd2-97b3-475f-91be-9fac07a81c94", "Trey", "Cummings", "Kodiak.UC", "UC Red"),
    ("056a5020-af0a-46a3-85be-26482574fa05", "Eric", "Michalski", "PrestoDragon.UC", "UC Red"),
    ("e13099b7-6ac7-4c85-be44-322134ea9d9e", "Tyler", "Humbert", "Bread.UC", "UC Black"),
    ("602ab4bc-8c6f-400a-a690-d0adc0cdbf58", "Joseph", "Humbert", "Darkmatter.UC", "UC Black"),
    ("9c0c157b-3173-4744-b2de-209a6f3c9a47", "Micah", "Diaz", "Fiddlers.UC", "UC Black"),
    ("7273fb9a-4be6-4a9f-91ed-757c6d321136", "Chris", "Cooley", "OZY.", "UC Black"),
    ("72546077-06ee-405e-a917-e64e9531657d", "Joel", "Martinez-Rycek", "Panda.UC", "UC Black"),
    ("7db78b5c-a796-4bbb-8da2-574b3428af0a", "Justin", "Larsh", "Polar.UC", "UC Black"),
    ("226590f6-5829-4ddd-a998-0fcaebc2c36e", "G", "DiMona", "Wolf.UC", "UC Black");

