module TisburyTreasureHunt exposing (..)

import List


type alias PlaceLocation =
    ( Char, Int )


type alias Place =
    ( String, PlaceLocation )


type alias TreasureLocation =
    ( Int, Char )


type alias Treasure =
    ( String, TreasureLocation )


placeLocationToTreasureLocation : PlaceLocation -> TreasureLocation
placeLocationToTreasureLocation placeLocation =
    let
        ( c, i ) =
            placeLocation
    in
    ( i, c )


treasureLocationMatchesPlaceLocation : PlaceLocation -> TreasureLocation -> Bool
treasureLocationMatchesPlaceLocation placeLocation treasureLocation =
    placeLocationToTreasureLocation placeLocation == treasureLocation


countPlaceTreasures : Place -> List Treasure -> Int
countPlaceTreasures place treasures =
    let
        ( _, placeLocation ) =
            place

        treasuresLocations =
            List.map (\( _, location ) -> location) treasures

        here =
            treasureLocationMatchesPlaceLocation placeLocation
    in
    List.filter here treasuresLocations
        |> List.length


specialCaseSwapPossible : Treasure -> Place -> Treasure -> Bool
specialCaseSwapPossible ( foundTreasure, _ ) ( place, _ ) ( desiredTreasure, _ ) =
    case ( foundTreasure, place ) of
        ( "Brass Spyglass", "Abandoned Lighthouse" ) ->
            True

        ( "Amethyst Octopus", "Stormy Breakwater" ) ->
            desiredTreasure == "Crystal Crab" || desiredTreasure == "Glass Starfish"

        ( "Vintage Pirate Hat", "Harbor Managers Office" ) ->
            desiredTreasure == "Model Ship in Large Bottle" || desiredTreasure == "Antique Glass Fishnet Float"

        ( _, _ ) ->
            False
