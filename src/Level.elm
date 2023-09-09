module Level exposing (..)

import Dict exposing (Dict)
import Game exposing (Game, LevelDef)
import Game.Level1
import Game.Level2
import Html exposing (Html)
import Set exposing (Set)


fromInt : Int -> Maybe (LevelDef msg)
fromInt int =
    case int of
        1 ->
            Game.Level1.def |> Just

        2 ->
            Game.Level2.def |> Just

        _ ->
            Nothing


toHtml : { onPress : Int -> msg } -> Int -> Set Int -> Maybe (List (Html msg))
toHtml args int areas =
    fromInt int
        |> Maybe.map
            (\def ->
                def.toHtml args areas
            )


toGame : Int -> Maybe Game
toGame int =
    fromInt int
        |> Maybe.map
            (\{ init } ->
                Game.new init int
            )
