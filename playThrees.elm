module Main exposing (..)

import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { content : List ( Int, Float )
    }


model : Model
model =
    { content = [] }


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Play the Game of Threes", onInput Change ] []
        , Html.ul [] [ toText model.content ]
        ]


play x runs =
    if x == 0 then
        [ ( 0, 0 ) ]
    else if x == 1 then
        List.reverse runs
    else if x % 3 == 0 then
        play (x / 3) (( x, 0 ) :: runs)
    else if (x + 1) % 3 == 0 then
        play ((x + 1) / 3) (( x, 1 ) :: runs)
        --    else if x-1 % 3 == 0 then
    else
        play ((x - 1) / 3) (( x, -1 ) :: runs)


playThrees n =
    play n []


toText : List ( Int, Float ) -> Html msg
toText list =
    let
        toListElem : ( Int, Float ) -> Html msg
        toListElem ( num, mod ) =
            Html.li
                []
                [ text <| "Run: " ++ toString num ++ " Mod: " ++ toString mod ]
    in
        Html.ul [] <| List.map toListElem list



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = playThrees (Result.withDefault 0 (String.toFloat newContent)) }
