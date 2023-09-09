module Game.Level1 exposing (..)

import Config
import Game exposing (Args, Color(..), LevelDef)
import Html exposing (Html)
import Html.Attributes
import Layout
import Set
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
      , firstButton Blue (args.onPress [ 0 ])
      ]
        |> View.Level.area
            { transition = False
            , visible = True
            , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
            }
    , [ secondArea Yellow
      , path Yellow
      , secondButton Yellow (args.onPress [ 1 ])
      ]
        |> View.Level.area
            { transition = Set.member 0 args.transitioningArea
            , visible = Set.member 0 args.areas |> not
            , center = ( 200, 525 )
            }
    , [ View.Level.base Blue
      ]
        |> View.Level.area
            { transition = Set.member 1 args.transitioningArea
            , visible = Set.member 1 args.areas |> not
            , center = ( 200, 175 )
            }
    ]


firstButton : Color -> msg -> Html msg
firstButton bool =
    View.Level.button bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" "425px"
        , Html.Attributes.style "left" "100px"
        , Html.Attributes.class "font-size-big"
        ]


secondButton : Color -> msg -> Html msg
secondButton bool =
    View.Level.button bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" "75px"
        , Html.Attributes.style "left" "100px"
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
        [ Html.Attributes.style "height" "350px"
        , Html.Attributes.style "width" "400px"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none


secondArea : Color -> Html msg
secondArea bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "350px"
        , Html.Attributes.style "height" "350px"
        , Html.Attributes.style "width" "400px"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none
