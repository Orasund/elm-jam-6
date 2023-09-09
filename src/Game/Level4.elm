module Game.Level4 exposing (..)

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
    { init = [ 0, 3, 4 ] |> Set.fromList
    , toHtml = toHtml
    }


toHtml : Args msg -> List (Html msg)
toHtml args =
    [ View.Level.base Blue
    , topSquare Yellow
    , View.Level.bottomHalf Yellow
    ]
        ++ View.Level.upwardsBigButton
            { color = Blue
            , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 + 200 )
            , onPress =
                if Set.member 3 args.areas && Set.member 4 args.areas then
                    args.onPress [ 2, 1 ] |> Just

                else
                    Nothing
            }
        ++ View.Level.downwardsButton
            { color = Yellow
            , pos = ( 75, Config.screenMinHeight // 2 - 100 )
            , onPress = args.onPress [ 3 ] |> Just
            }
        ++ View.Level.downwardsButton
            { color = Yellow
            , pos = ( Config.screenMinWidth - 75, Config.screenMinHeight // 2 - 100 )
            , onPress = args.onPress [ 4 ] |> Just
            }
        ++ [ [ leftSquare Blue ]
                |> View.Level.area
                    { transition = Set.member 3 args.transitioningArea
                    , center = ( 75, Config.screenMinHeight // 2 - 100 )
                    , visible = Set.member 3 args.areas |> not
                    }
           , [ rightSquare Blue ]
                |> View.Level.area
                    { transition = Set.member 4 args.transitioningArea
                    , center = ( Config.screenMinWidth - 75, Config.screenMinHeight // 2 - 100 )
                    , visible = Set.member 4 args.areas |> not
                    }
           , reset args.reset
           , [ View.Level.downwardsBigButton
                { color = Yellow
                , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 - 200 )
                , onPress = Nothing
                }
             , View.Level.upwardsBigButton
                { color = Yellow
                , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 + 200 )
                , onPress =
                    if (Set.member 3 args.areas |> not) && (Set.member 4 args.areas |> not) then
                        [ 0, 1, 2 ] |> args.onPress |> Just

                    else
                        Nothing
                }
             ]
                |> List.concat
                |> View.Level.area
                    { transition = Set.member 2 args.transitioningArea
                    , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 + 200 )
                    , visible = Set.member 2 args.areas || (Set.member 0 args.areas |> not)
                    }
           , [ View.Level.base Blue ]
                |> View.Level.area
                    { transition = Set.member 0 args.transitioningArea
                    , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 + 200 )
                    , visible = Set.member 0 args.areas |> not
                    }
           ]


rightSquare : Color -> Html msg
rightSquare color =
    Layout.el
        [ Html.Attributes.style "width" (String.fromInt (Config.screenMinWidth // 2) ++ "px")
        , Html.Attributes.style "height" (String.fromInt (Config.screenMinHeight - 150) ++ "px")
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "left" "200px"
        , Html.Attributes.style "top" "150px"
        , Html.Attributes.style "background-color" (View.color color)
        ]
        Layout.none


leftSquare : Color -> Html msg
leftSquare color =
    Layout.el
        [ Html.Attributes.style "width" (String.fromInt (Config.screenMinWidth // 2) ++ "px")
        , Html.Attributes.style "height" (String.fromInt (Config.screenMinHeight - 150) ++ "px")
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "left" "0px"
        , Html.Attributes.style "top" "150px"
        , Html.Attributes.style "background-color" (View.color color)
        ]
        Layout.none


topSquare : Color -> Html msg
topSquare color =
    Layout.el
        [ Html.Attributes.style "width" (String.fromInt Config.screenMinWidth ++ "px")
        , Html.Attributes.style "height" "150px"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "left" "0px"
        , Html.Attributes.style "top" "0px"
        , Html.Attributes.style "background-color" (View.color color)
        ]
        Layout.none


reset : msg -> Html msg
reset onPress =
    Layout.textButton
        [ Html.Attributes.style "background-color" "var(--trinary-color)"
        , Html.Attributes.style "aspect-ratio" "1"
        , Html.Attributes.style "color" "white"
        , Html.Attributes.style "font-weight" "bold"
        , Html.Attributes.style "width" "100px"
        , Html.Attributes.style "border-radius" "100%"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" (String.fromInt (Config.screenMinHeight // 2 - 250) ++ "px")
        , Html.Attributes.style "left" (String.fromInt (Config.screenMinWidth // 2 - 50) ++ "px")
        ]
        { label = "Reset"
        , onPress = onPress |> Just
        }
