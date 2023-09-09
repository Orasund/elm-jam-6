module Game.Level1 exposing (..)

import Config
import Game exposing (Args, Color(..), LevelDef)
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


toHtml : Args msg -> List (Html msg)
toHtml args =
    [ View.Level.base Yellow
    , [ firstArea Blue
      , path Blue
      , firstButton Blue (args.onPress 0)
      ]
        |> View.Level.area
            [ Html.Attributes.style "z-index" "1"
            ]
            { transition = False
            , visible = True
            , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
            }
    , [ secondArea Yellow
      , path Yellow
      , secondButton Yellow (args.onPress 1)
      ]
        |> View.Level.area
            [ Html.Attributes.style "z-index" "2"
            ]
            { transition = args.transitioningArea == Just 0
            , visible = Set.member 0 args.areas |> not
            , center = ( 200, 525 )
            }
    , [ View.Level.base Blue
      ]
        |> View.Level.area
            [ Html.Attributes.style "z-index" "3"
            ]
            { transition = args.transitioningArea == Just 1
            , visible = Set.member 1 args.areas |> not
            , center = ( 200, 175 )
            }
    ]


firstButton : Color -> msg -> Html msg
firstButton bool =
    View.Level.button bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "bottom" "75px"
        , Html.Attributes.style "left" "100px"
        , Html.Attributes.class "font-size-big"
        ]


secondButton : Color -> msg -> Html msg
secondButton bool =
    View.Level.button bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" "75px"
        , Html.Attributes.style "left" "25%"
        , Html.Attributes.class "font-size-big"
        ]


path : Color -> Html msg
path bool =
    Layout.el
        [ Html.Attributes.style "width" "100px"
        , Html.Attributes.style "height" "200px"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "250px"
        , Html.Attributes.style "left" "150px"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none


firstArea : Color -> Html msg
firstArea bool =
    Layout.el
        [ Html.Attributes.style "height" "50%"
        , Html.Attributes.style "width" "100%"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none


secondArea : Color -> Html msg
secondArea bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "50%"
        , Html.Attributes.style "height" "50%"
        , Html.Attributes.style "width" "100%"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none
