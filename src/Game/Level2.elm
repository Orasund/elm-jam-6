module Game.Level2 exposing (..)

import Config
import Game exposing (Args, Color(..), LevelDef)
import Html exposing (Attribute, Html)
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
    let
        backColor =
            if Set.member 0 args.areas then
                if args.transitioningArea == Just 0 then
                    Blue

                else
                    Yellow

            else if args.transitioningArea == Just 0 then
                Yellow

            else
                Blue

        frontColor =
            if Set.member 0 args.areas then
                if args.transitioningArea == Just 0 then
                    Yellow

                else
                    Blue

            else if args.transitioningArea == Just 0 then
                Blue

            else
                Yellow

        transitiningFirst =
            args.transitioningArea == Just 0
    in
    [ View.Level.base Blue
    , [ firstSquare Yellow
      , leftPath Yellow
      , leftButton Yellow (args.onPress 1)
      ]
        |> View.Level.area
            []
            { transition = False
            , visible = Set.member 1 args.areas
            , center = ( 75, 275 )
            }
    , secondSquare Yellow
    , toggle
        { color = backColor
        , areas = args.areas
        , area = 0
        , onPress = args.onPress
        , transition = False
        , visible = True
        , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
        }
    , toggle
        { color = frontColor
        , areas = args.areas
        , area = 0
        , onPress = args.onPress
        , transition = transitiningFirst
        , visible = transitiningFirst
        , center =
            if frontColor == Blue then
                ( 200, 175 )

            else
                ( 200, 525 )
        }
    ]


toggle : { color : Color, area : Int, areas : Set Int, onPress : Int -> msg, transition : Bool, visible : Bool, center : ( Int, Int ) } -> Html msg
toggle args =
    case args.color of
        Blue ->
            [ secondCircle Blue
            , path Blue
            , firstButton Blue (args.onPress args.area)
            ]
                |> View.Level.area []
                    { transition = args.transition
                    , visible = args.visible
                    , center = args.center
                    }

        Yellow ->
            [ secondButton Yellow (args.onPress args.area)
            , path Yellow
            , firstCircle Yellow
            ]
                |> View.Level.area []
                    { transition = args.transition
                    , visible = args.visible
                    , center = args.center
                    }


firstButton : Color -> msg -> Html msg
firstButton bool =
    View.Level.button bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "bottom" "75px"
        , Html.Attributes.style "left" "100px"
        , Html.Attributes.class "font-size-big"
        ]


firstCircle : Color -> Html msg
firstCircle bool =
    View.Level.circle bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "bottom" "75px"
        , Html.Attributes.style "left" "100px"
        ]


secondButton : Color -> msg -> Html msg
secondButton bool =
    View.Level.button bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" "75px"
        , Html.Attributes.style "left" "25%"
        , Html.Attributes.class "font-size-big"
        ]


secondCircle : Color -> Html msg
secondCircle bool =
    View.Level.circle bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" "75px"
        , Html.Attributes.style "left" "25%"
        ]


leftButton : Color -> msg -> Html msg
leftButton color =
    View.Level.button color
        [ Html.Attributes.style "width" "100px"
        , Html.Attributes.style "top" "225px"
        , Html.Attributes.style "left" "25px"
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


leftPath : Color -> Html msg
leftPath bool =
    Layout.el
        [ Html.Attributes.style "width" "50px"
        , Html.Attributes.style "height" "200px"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "250px"
        , Html.Attributes.style "left" "50px"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none


firstSquare : Color -> Html msg
firstSquare bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "50%"
        , Html.Attributes.style "height" "50%"
        , Html.Attributes.style "width" "50%"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none


secondSquare : Color -> Html msg
secondSquare bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "50%"
        , Html.Attributes.style "left" "50%"
        , Html.Attributes.style "height" "50%"
        , Html.Attributes.style "width" "50%"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none
