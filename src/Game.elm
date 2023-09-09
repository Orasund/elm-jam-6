module Game exposing (..)

import Html exposing (Html)
import Set exposing (Set)


type Color
    = Yellow
    | Blue


type alias Game =
    { areas : Set Int
    , level : Int
    }


type alias Args msg =
    { onPress : List Int -> msg
    , areas : Set Int
    , transitioningArea : Set Int
    }


type alias LevelDef msg =
    { init : Set Int
    , toHtml : Args msg -> List (Html msg)
    }


empty : Game
empty =
    { areas = Set.empty
    , level = 0
    }


new : Set Int -> Int -> Game
new areas level =
    { areas = areas
    , level = level
    }


isCleared : Game -> Bool
isCleared game =
    Set.isEmpty game.areas


applyButton : Int -> Game -> Game
applyButton i game =
    (if Set.member i game.areas then
        Set.remove i game.areas

     else
        Set.insert i game.areas
    )
        |> Debug.log "areas"
        |> (\areas -> { game | areas = areas })
