module Level exposing (..)

import Dict exposing (Dict)
import Set exposing (Set)


type alias Button =
    { target : Int, value : Bool }


type alias Level =
    { areas : Set Int
    , buttons : Dict Int Button
    }


getArea : Int -> Level -> Bool
getArea i level =
    level.areas |> Set.member i


setArea : Int -> Bool -> Level -> Level
setArea i b level =
    { level
        | areas =
            if b then
                Set.remove i level.areas

            else
                Set.insert i level.areas
    }


getButton : Int -> Level -> Maybe { target : Int, value : Bool }
getButton i level =
    level.buttons |> Dict.get i


removeButton : Int -> Level -> Level
removeButton i level =
    { level
        | buttons = Dict.remove i level.buttons
    }
