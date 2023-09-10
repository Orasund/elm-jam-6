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
    { init = [ 1, 2 ] |> Set.fromList
    , toHtml = toHtml
    }


toHtml : Args msg -> List (Html msg)
toHtml args =
    [ View.Level.base Yellow
    , View.Level.bottomHalf Blue
    , View.Level.circle
        { color = Blue
        , pos =
            ( Config.screenMinWidth // 2
            , Config.screenMinHeight // 2 - 200
            )
        , radius = 200
        }
    , topSquare Blue
    ]
        ++ View.Level.downwardsBigButton
            { color = Yellow
            , pos =
                ( Config.screenMinWidth // 2
                , Config.screenMinHeight // 2 - 200
                )
            , onPress = Nothing
            }
        ++ View.Level.upwardsBigButton
            { color = Blue
            , pos =
                ( Config.screenMinWidth // 2
                , Config.screenMinHeight // 2 + 200
                )
            , onPress = Nothing
            }
        ++ View.Level.upwardsButton
            { color = Blue
            , pos =
                ( Config.screenMinWidth // 2
                , Config.screenMinHeight // 2 - 200
                )
            , onPress = [ 0 ] |> args.onPress |> Just
            }
        ++ View.Level.upwardsBigButton
            { color = Yellow
            , pos =
                ( Config.screenMinWidth // 2
                , Config.screenMinHeight // 2 + 200
                )
            , onPress =
                (if Set.member 0 args.areas then
                    [ 0, 1, 2 ]

                 else
                    [ 1 ]
                )
                    |> args.onPress
                    |> Just
            }
        ++ [ [ View.Level.topHalf Yellow ]
                |> View.Level.area
                    { transition = Set.member 0 args.transitioningArea
                    , visible = Set.member 0 args.areas || (Set.member 2 args.areas |> not)
                    , center =
                        ( Config.screenMinWidth // 2
                        , Config.screenMinHeight // 2 - 200
                        )
                    }
           , [ View.Level.downwardsBigButton
                { color = Blue
                , pos =
                    ( Config.screenMinWidth // 2
                    , Config.screenMinHeight // 2 - 200
                    )
                , onPress = Nothing
                }
             , View.Level.upwardsBigButton
                { color = Blue
                , pos =
                    ( Config.screenMinWidth // 2
                    , Config.screenMinHeight // 2 + 200
                    )
                , onPress = Nothing
                }
             ]
                |> List.concat
                |> View.Level.area
                    { transition = Set.member 1 args.transitioningArea
                    , visible = Set.member 1 args.areas |> not
                    , center =
                        ( Config.screenMinWidth // 2
                        , Config.screenMinHeight // 2 + 200
                        )
                    }
           , [ View.Level.topHalf Blue ]
                |> View.Level.area
                    { transition = Set.member 2 args.transitioningArea
                    , visible = Set.member 2 args.areas |> not
                    , center =
                        ( Config.screenMinWidth // 2
                        , Config.screenMinHeight // 2 + 200
                        )
                    }
           , [ View.Level.reset
                { pos =
                    ( Config.screenMinWidth // 2
                    , Config.screenMinHeight // 2 + 200
                    )
                , onPress = args.reset
                }
             ]
                |> View.Level.area
                    { transition = Set.member 1 args.transitioningArea
                    , visible = Set.member 2 args.areas && (Set.member 1 args.areas |> not)
                    , center =
                        ( Config.screenMinWidth // 2
                        , Config.screenMinHeight // 2 + 200
                        )
                    }
           ]


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
