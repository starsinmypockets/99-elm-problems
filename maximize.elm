module Main exposing (..)

import Html exposing (Html, text)
import Debug exposing (log)


maximize : List comparable -> List comparable
maximize list =
    case List.head (List.reverse (List.sort list)) of
        Nothing ->
            []
                -- this should never occur
                |> log "Nothing"

        Just val ->
            List.repeat (List.length list) val
                |> log "Something"


t =
    maximize [ 2, 4, 6, 8, 10 ]
        |> log "t"


main : Html.Html a
main =
    Html.text <|
        case test of
            0 ->
                "Your implementation passed all tests."

            1 ->
                "Your implementation failed one test."

            x ->
                "Your implementation failed " ++ (toString x) ++ " tests."


test : Int
test =
    List.length <|
        List.filter ((==) False)
            [ maximize [ 1, 1, 1, 1, 2, 5, 5, 2, 1 ]
                == [ 5, 5, 5, 5, 5, 5, 5, 5, 5 ]
            , maximize [ 2, 1, 1, 1 ] == [ 2, 2, 2, 2 ]
            , maximize [ 2, 2, 122, 1, 1, 1 ] == [ 122, 122, 122, 122, 122, 122 ]
            , maximize [ 1 ] == [ 1 ]
            , maximize [] == []
            , maximize [ "aab", "b", "b", "aa" ]
                == [ "b", "b", "b", "b" ]
            ]
