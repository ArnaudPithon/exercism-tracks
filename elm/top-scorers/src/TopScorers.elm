module TopScorers exposing (..)

import Dict exposing (Dict)
import List
import TopScorersSupport exposing (PlayerName)


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName playerGoalCounts =
    let
        count =
            Dict.get playerName playerGoalCounts
                |> Maybe.withDefault 0
    in
    Dict.insert playerName (count + 1) playerGoalCounts


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers playerNames =
    List.foldl updateGoalCountForPlayer Dict.empty playerNames


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold playerGoalCounts =
    Dict.filter (\_ count -> count >= goalThreshold) playerGoalCounts


resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName playerGoalCounts =
    let
        update =
            Maybe.map (\_ -> 0)
    in
    Dict.update playerName update playerGoalCounts


formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName playerGoalCounts =
    let
        goals name =
            Dict.get name playerGoalCounts
                |> Maybe.withDefault 0
                |> String.fromInt
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
