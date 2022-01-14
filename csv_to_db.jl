using Dates
using DataFrames
using MySQL

conn = DBInterface.connect(MySQL.Connection,
                           "localhost",
                           "spervaiz",
                           "",
                           db="ucr6",
                           unix_socket="/var/run/mysqld/mysqld.sock")


for filename in readdir("csvs", join=true)
    open(filename, "r") do file
        lines = [split(line, ',') for line in readlines(file)]
        df = DateFormat("U d y H:M")
        matchid = lines[6][2]
        team = "UC Red"
        opponent = "KSU"
        date = Date(lines[6][3], df)
        println(date)
        map = lines[6][7]
        winning_team = lines[6][8]
        rounds = parse(Int, lines[6][9]) + parse(Int, lines[6][10])

        try
            query = "INSERT INTO matches VALUES ('$date', '$team', '$opponent');"
            DBInterface.execute(conn, query)
        catch e
            if !isnothing(findfirst("Duplicate entry", e.msg))
            else
                rethrow(e)
            end
        end
        try
            query = "INSERT INTO games VALUES ('$matchid', '$map', '$date', '$team', '$opponent', $rounds);"
            DBInterface.execute(conn, query)
        catch e
            if !isnothing(findfirst("Duplicate entry", e.msg))
            else
                rethrow(e)
            end
        end

        for i in 10:19
            username = lines[i][4]
            trade_diff = lines[i][10]
            kost = lines[i][11]
            kills = lines[i][17]
            refrags = lines[i][18]
            headshots = lines[i][19]
            ud_kills = lines[i][20]
            one_v_X = lines[i][21]
            multikill_rds = lines[i][22]
            deaths = lines[i][23]
            trades_in = lines[i][24]
            trades_out = lines[i][25]
            op_kills = lines[i][26]
            op_deaths = lines[i][27]
            entry_kills = lines[i][28]
            entry_deaths = lines[i][29]
            plants = lines[i][30]
            disables = lines[i][31]
            teamkills_out = lines[i][32]
            teamkills_in = lines[i][33]
            points = lines[i][34]
            last_alive = lines[i][35]
            if last_alive == "undefined"
                last_alive = 0
            end
            # TODO: write script to handle assists
            assists = "0"

            print("* Parsing data from game $matchid for player $username...")

            query = "SELECT * FROM players AS p WHERE p.username='$username';"
            res = DataFrame(DBInterface.execute(conn, query))

            if size(res, 1) == 0
                print("\n    /!\\ Skipping player not on any team roster /!\\\n\n")
                continue
            end
            println(" done!")

            uuid = res.uuid[1]
            query = string("INSERT INTO performances VALUES ('$uuid', '$matchid',",
                           "$kills, $deaths, $assists, $teamkills_in, ",
                           "$teamkills_out, $refrags, $headshots, $ud_kills, ",
                           "$one_v_X, $multikill_rds, $trades_out, $trades_in, ",
                           "$op_kills, $op_deaths, $entry_kills, $entry_deaths, ",
                           "$plants, $disables, $last_alive, $points, $kost);")
            println(query)
            DBInterface.execute(conn, query)
        end

    end
end
