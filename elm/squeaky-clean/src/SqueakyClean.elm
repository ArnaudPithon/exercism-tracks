module SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)

import List
import String exposing (..)


clean1 : String -> String
clean1 str =
    replace " " "_" str


clean2 : String -> String
clean2 str =
    let
        r : String -> String -> String
        r c s =
            replace c "[CTRL]" s
    in
    clean1 str
        |> r "\n"
        |> r "\t"
        |> r "\u{000D}"


clean3 : String -> String
clean3 str =
    let
        capitalize : String -> String
        capitalize s =
            case uncons s of
                Just ( h, t ) ->
                    toUpper (fromChar h) ++ t

                Nothing ->
                    s

        c3 : String -> String
        c3 s =
            case split "-" s of
                head :: tail ->
                    join "" <| head :: List.map capitalize tail

                _ ->
                    s
    in
    clean2 str |> c3


clean4 : String -> String
clean4 str =
    clean3 str |> filter (not << Char.isDigit)


clean : String -> String
clean str =
    let
        isGreek c =
            'α' <= c && c <= 'ω'
    in
    clean4 str |> filter (not << isGreek)
