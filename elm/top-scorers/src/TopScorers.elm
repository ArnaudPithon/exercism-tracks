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
    -- Pourrait être fortement simplifiée en utilisant List.map et
    -- String.join
    -- L'idée étant simplement de mapper la liste des joueurs avec une
    -- liste composée avec formatPlayer, puis je construire une chaine
    -- en rejoignant la liste avec ", "
    let
        build : String -> String -> String
        build acc playerString =
            case acc of
                "" ->
                    playerString

                _ ->
                    acc ++ ", " ++ playerString

        format : PlayerName -> String -> String
        format name acc =
            formatPlayer name players
                |> build acc
    in
    Dict.keys players
        |> List.foldl format ""


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
