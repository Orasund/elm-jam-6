module Level exposing (..)

import Game exposing (Game, LevelDef)
import Game.Level1
import Game.Level2
import Game.Level3
import Html exposing (Html)
import Set exposing (Set)


fromInt : Int -> Maybe (LevelDef msg)
fromInt int =
    case int of
        1 ->
            Game.Level1.def |> Just

        2 ->
            Game.Level2.def |> Just

        3 ->
            Game.Level3.def |> Just

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
