module TopScorers exposing (..)

import Dict exposing (Dict)
import TopScorersSupport exposing (PlayerName)


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName playerGoalCounts =
    let
        count =
            Maybe.withDefault 0 (Dict.get playerName playerGoalCounts)
    in
    Dict.insert playerName (count + 1) playerGoalCounts


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers playerNames =
    let
        loop : List PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
        loop list counts =
            case list of
                name :: rest ->
                    loop rest <| updateGoalCountForPlayer name counts

                [] ->
                    counts
    in
    loop playerNames Dict.empty


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold playerGoalCounts =
    Dict.filter (\_ count -> count >= goalThreshold) playerGoalCounts


resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName playerGoalCounts =
    let
        update count =
            Maybe.map (\_ -> Maybe.withDefault 0 Nothing) count
    in
    Dict.update playerName update playerGoalCounts


formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName playerGoalCounts =
    let
        goals name =
            case Dict.get name playerGoalCounts of
                Just v ->
                    String.fromInt v

                Nothing ->
                    "0"
    in
    playerName ++ ": " ++ goals playerName


formatPlayers : Dict PlayerName Int -> String
formatPlayers players =
    let
        format : String -> String -> String
        format acc string =
            case acc of
                "" ->
                    string

                _ ->
                    acc ++ ", " ++ string

        loop : List PlayerName -> String -> String
        loop list output =
            case list of
                player :: rest ->
                    loop rest <| format output (formatPlayer player players)

                [] ->
                    output
    in
    loop (Dict.keys players) ""


combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames game1 game2 =
    let
        onlyOne : PlayerName -> Int -> Dict PlayerName Int -> Dict PlayerName Int
        onlyOne key value =
            Dict.insert key value

        add : PlayerName -> Int -> Int -> Dict PlayerName Int -> Dict PlayerName Int
        add key value1 value2 =
            Dict.insert key (value1 + value2)
    in
    Dict.merge onlyOne add onlyOne game1 game2 Dict.empty
