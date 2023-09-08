module Game.Level1 exposing (..)

import Array exposing (Array)
import Dict
import Html exposing (Html)
import Html.Attributes
import Layout
import Level exposing (Button, Level)
import Set exposing (Set)
import View


init : Level
init =
    { areas = Set.fromList [ 0 ]
    , buttons = Dict.fromList [ ( 0, { target = 1, value = False } ) ]
    }


toHtml : { onPress : Int -> msg } -> Level -> List (Html msg)
toHtml args level =
    [ level |> Level.getArea 0 |> base
    , level |> Level.getArea 1 |> area
    , level
        |> Level.getButton 0
        |> Maybe.map (defaultButton (args.onPress 0))
        |> Maybe.withDefault Layout.none
    ]


defaultButton : msg -> Button -> Html msg
defaultButton onPress button =
    Layout.textButton
        [ Html.Attributes.style "aspect-ratio" "1"
        , Html.Attributes.style "width" "50%"
        , Html.Attributes.style "color" (View.binaryColor button.value)
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "bottom" "75px"
        , Html.Attributes.style "left" "25%"
        , Html.Attributes.style "border-radius" "100%"
        ]
        { label = ""
        , onPress = onPress |> Just
        }


base : Bool -> Html msg
base bool =
    Layout.el
        [ Html.Attributes.style "height" "100%"
        , Html.Attributes.style "width" "100%"
        , Html.Attributes.style "background-color" (View.binaryColor bool)
        ]
        Layout.none


area : Bool -> Html msg
area bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "50%"
        , Html.Attributes.style "height" "50%"
        , Html.Attributes.style "width" "100%"
        , Html.Attributes.style "background-color" (View.binaryColor bool)
        ]
        Layout.none
