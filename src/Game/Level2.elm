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
    { init = Set.fromList [ 1, 2 ]
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
    , buttomSquare Yellow
    , leftPath Yellow
    , leftButton Yellow (args.onPress 1)
    , [ leftSquare Blue
      ]
        |> View.Level.area []
            { transition = args.transitioningArea == Just 1
            , visible = Set.member 1 args.areas |> not
            , center = ( 75, 275 )
            }
    , [ rightSquare Blue ]
        |> View.Level.area []
            { transition = args.transitioningArea == Just 2
            , visible = Set.member 2 args.areas |> not
            , center = ( 75, 275 )
            }
    , toggle
        { color = backColor
        , areas = args.areas
        , area = 0
        , onPress = args.onPress |> Just
        , transition = False
        , visible = True
        , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
        }
    , toggle
        { color = frontColor
        , areas = args.areas
        , area = 0
        , onPress = Nothing
        , transition = transitiningFirst
        , visible = transitiningFirst
        , center =
            if frontColor == Blue then
                ( 200, 175 )

            else
                ( 200, 525 )
        }
    ]


toggle : { color : Color, area : Int, areas : Set Int, onPress : Maybe (Int -> msg), transition : Bool, visible : Bool, center : ( Int, Int ) } -> Html msg
toggle args =
    case args.color of
        Blue ->
            [ secondCircle Blue
            , path Blue
            , args.onPress
                |> Maybe.map (\f -> firstButton Blue (f args.area))
                |> Maybe.withDefault (firstCircle Blue)
            ]
                |> View.Level.area []
                    { transition = args.transition
                    , visible = args.visible
                    , center = args.center
                    }

        Yellow ->
            [ args.onPress
                |> Maybe.map (\f -> secondButton Yellow (f args.area))
                |> Maybe.withDefault (secondCircle Yellow)
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
        , Html.Attributes.style "top" "425px"
        , Html.Attributes.style "left" "100px"
        , Html.Attributes.class "font-size-big"
        ]


firstCircle : Color -> Html msg
firstCircle bool =
    View.Level.circle bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" "425px"
        , Html.Attributes.style "left" "100px"
        ]


secondButton : Color -> msg -> Html msg
secondButton bool =
    View.Level.button bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" "75px"
        , Html.Attributes.style "left" "100px"
        , Html.Attributes.class "font-size-big"
        ]


secondCircle : Color -> Html msg
secondCircle bool =
    View.Level.circle bool
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" "75px"
        , Html.Attributes.style "left" "100px"
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


buttomSquare : Color -> Html msg
buttomSquare color =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "350px"
        , Html.Attributes.style "height" "350px"
        , Html.Attributes.style "width" "400px"
        , Html.Attributes.style "background-color" (View.color color)
        ]
        Layout.none


leftSquare : Color -> Html msg
leftSquare bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "0px"
        , Html.Attributes.style "height" "700px"
        , Html.Attributes.style "width" "200px"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none


rightSquare : Color -> Html msg
rightSquare bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "0px"
        , Html.Attributes.style "left" "200px"
        , Html.Attributes.style "height" "700px"
        , Html.Attributes.style "width" "200px"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none
