module MagicianInTraining exposing (..)

import Array exposing (..)


getCard : Int -> Array Int -> Maybe Int
getCard index deck =
    get index deck


setCard : Int -> Int -> Array Int -> Array Int
setCard index newCard deck =
    set index newCard deck


addCard : Int -> Array Int -> Array Int
addCard newCard deck =
    push newCard deck


removeCard : Int -> Array Int -> Array Int
removeCard index deck =
    if index >= length deck then
        deck

    else
        append
            (slice 0 index deck)
            (slice (index + 1) (length deck) deck)


evenCardCount : Array Int -> Int
evenCardCount deck =
    let
        isEven n =
            modBy 2 n == 0
    in
    length (filter isEven deck)
