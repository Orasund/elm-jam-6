module Game.Level2 exposing (..)

import Config
import Game exposing (LevelDef)
import Html exposing (Html)
import Html.Attributes
import Layout
import Set exposing (Set)
import View
import View.Level


def : LevelDef msg
def =
    { init = Set.fromList [ 0, 1 ]
    , toHtml = toHtml
    }


toHtml : { onPress : Int -> msg } -> Set Int -> List (Html msg)
toHtml args level =
    [ [ secondArea False
      , path False
      , secondButton False (args.onPress 1)
      ]
        |> View.Level.area
            [ Html.Attributes.style "z-index" "2"
            , "circle("
                ++ (if Set.member 0 level then
                        String.fromFloat 0

                    else
                        String.fromFloat Config.screenMinHeight
                   )
                ++ "px at 200px 525px)"
                |> Html.Attributes.style "clip-path"
            ]
    , [ View.Level.base True
      ]
        |> View.Level.area
            [ Html.Attributes.style "z-index" "3"
            , "circle("
                ++ (if Set.member 1 level then
                        String.fromFloat 0

                    else
                        String.fromFloat Config.screenMinHeight
                   )
                ++ "px at 200px 175px)"
                |> Html.Attributes.style "clip-path"
            ]
    , [ firstArea True
      , path True
      , firstButton True (args.onPress 0)
      ]
        |> View.Level.area
            [ Html.Attributes.style "z-index" "1"
            ]
    , View.Level.base False
    ]


firstButton : Bool -> msg -> Html msg
firstButton bool =
    View.Level.button bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "bottom" "75px"
        , Html.Attributes.style "left" "100px"
        ]


secondButton : Bool -> msg -> Html msg
secondButton bool =
    View.Level.button bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" "75px"
        , Html.Attributes.style "left" "25%"
        ]


path : Bool -> Html msg
path bool =
    Layout.el
        [ Html.Attributes.style "width" "100px"
        , Html.Attributes.style "height" "200px"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "250px"
        , Html.Attributes.style "left" "150px"
        , Html.Attributes.style "background-color" (View.binaryColor bool)
        ]
        Layout.none


firstArea : Bool -> Html msg
firstArea bool =
    Layout.el
        [ Html.Attributes.style "height" "50%"
        , Html.Attributes.style "width" "100%"
        , Html.Attributes.style "background-color" (View.binaryColor bool)
        ]
        Layout.none


secondArea : Bool -> Html msg
secondArea bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "50%"
        , Html.Attributes.style "height" "50%"
        , Html.Attributes.style "width" "100%"
        , Html.Attributes.style "background-color" (View.binaryColor bool)
        ]
        Layout.none
