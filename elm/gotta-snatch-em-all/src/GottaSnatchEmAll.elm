module GottaSnatchEmAll exposing (..)

import List exposing (member)
import Set exposing (Set)


type alias Card =
    String


newCollection : Card -> Set Card
newCollection card =
    Set.singleton card


addCard : Card -> Set Card -> ( Bool, Set Card )
addCard card collection =
    ( Set.member card collection
    , Set.insert card collection
    )


tradeCard : Card -> Card -> Set Card -> ( Bool, Set Card )
tradeCard yourCard theirCard collection =
    let
        worth =
            Set.member yourCard collection || not (Set.member theirCard collection)
    in
    ( worth, Set.remove yourCard collection )


removeDuplicates : List Card -> List Card
removeDuplicates cards =
    Set.fromList cards |> Set.toList


extraCards : Set Card -> Set Card -> Int
extraCards yourCollection theirCollection =
    Set.diff yourCollection theirCollection
        |> Set.size


boringCards : List (Set Card) -> List Card
boringCards collections =
    let
        bore coll =
            case coll of
                set1 :: otherSets ->
                    Set.intersect set1 (bore otherSets)

                [] ->
                    Set.empty
    in
    bore collections |> Set.toList


totalCards : List (Set Card) -> Int
totalCards collections =
    Debug.todo "Please implement totalCards"


splitShinyCards : Set Card -> ( List Card, List Card )
splitShinyCards collection =
    Debug.todo "Please implement splitShinyCards"
