module Main exposing (..)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)



-- MAIN


main : Html Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { content : String }


init : Model
init =
    { content = "" }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newText ->
            { model | content = newText }



-- VIEW


isPalindrome : String -> Bool
isPalindrome content =
    content == String.reverse content


view : Model -> Html Msg
view model =
    let
        message =
            if isPalindrome model.content then
                "This is a palindrome"

            else
                "Not a palindrome"
    in
    Html.div []
        [ input [ value model.content, onInput Change ] []
        , div [] [ text message ]
        ]
