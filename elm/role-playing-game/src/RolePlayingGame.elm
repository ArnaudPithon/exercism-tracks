module RolePlayingGame exposing (Player, castSpell, introduce, revive)


type alias Player =
    { name : Maybe String
    , level : Int
    , health : Int
    , mana : Maybe Int
    }


introduce : Player -> String
introduce { name } =
    Maybe.withDefault "Mighty Magician" name


revive : Player -> Maybe Player
revive player =
    if player.health /= 0 then
        Nothing

    else if player.level >= 10 then
        Just { player | health = 100, mana = Just 100 }

    else
        Just { player | health = 100 }


castSpell : Int -> Player -> ( Player, Int )
castSpell manaCost player =
    case player.mana of
        Nothing ->
            -- le cout est déduit de la vie
            let
                healthFinale =
                    max 0 (player.health - manaCost)
            in
            ( { player | health = healthFinale }, 0 )

        Just someMana ->
            if someMana < manaCost then
                ( player, 0 )

            else
                ( { player | mana = Just (someMana - manaCost) }, manaCost * 2 )
