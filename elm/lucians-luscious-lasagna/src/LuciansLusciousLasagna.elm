module LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)


type alias Time =
    Int


type alias Quantity =
    Int


expectedMinutesInOven : Time
expectedMinutesInOven =
    40


preparationTimeInMinutes : Quantity -> Time
preparationTimeInMinutes layers =
    layers * 2


elapsedTimeInMinutes : Quantity -> Time -> Time
elapsedTimeInMinutes layers timeInOwen =
    preparationTimeInMinutes layers + timeInOwen
