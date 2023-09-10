module Level exposing (..)

import Game exposing (Game, LevelDef)
import Game.Level0
import Game.Level1
import Game.Level2
import Game.Level3
import Game.Level4
import Html exposing (Html)
import Set exposing (Set)


fromInt : Int -> Maybe (LevelDef msg)
fromInt int =
    case int of
        1 ->
            Game.Level0.def |> Just

        2 ->
            Game.Level1.def |> Just

        3 ->
            Game.Level2.def |> Just

        4 ->
            Game.Level3.def |> Just

        5 ->
            Game.Level4.def |> Just

        _ ->
            Nothing


toHtml :
    { onPress : List Int -> msg
    , areas : Set Int
    , transitioningArea : Set Int
    , reset : msg
    }
    -> Int
    -> Maybe (List (Html msg))
toHtml args int =
    fromInt int
        |> Maybe.map
            (\def ->
                def.toHtml args
            )


toGame : Int -> Maybe Game
toGame int =
    fromInt int
        |> Maybe.map
            (\{ init } ->
                Game.new init int
            )
