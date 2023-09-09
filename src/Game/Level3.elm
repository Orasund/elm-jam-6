module Game.Level3 exposing (..)

import Config
import Game exposing (Args, Color(..), LevelDef)
import Html exposing (Html)
import Html.Attributes
import Layout
import Set
import View.Level


def : LevelDef msg
def =
    { init = Set.fromList [ 0, 2, 4 ]
    , toHtml = toHtml
    }


toHtml : Args msg -> List (Html msg)
toHtml args =
    [ View.Level.base Blue
    , View.Level.upwardsHalfCircle
        { color = Yellow
        , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
        , radius = Config.screenMinWidth // 2
        }
    , View.Level.square
        { color = Yellow
        , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight - 50 )
        , size = 200
        }
    ]
        ++ View.Level.downwardsButton
            { color = Blue
            , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 - 100 )
            , onPress =
                (if Set.member 2 args.areas then
                    [ 1 ]

                 else
                    [ 1, 2, 3 ]
                )
                    |> args.onPress
                    |> Just
            }
        ++ [ [ View.Level.upwardsHalfCircle
                { color = Yellow
                , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
                , radius = Config.screenMinWidth // 2
                }
             ]
                |> View.Level.area
                    { transition = Set.member 1 args.transitioningArea
                    , visible = Set.member 1 args.areas
                    , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 - 100 )
                    }
           , [ View.Level.upwardsHalfCircle
                { color = Blue
                , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
                , radius = Config.screenMinWidth // 2
                }
             , reset args.reset
             ]
                |> View.Level.area
                    { transition = Set.member 2 args.transitioningArea
                    , visible = Set.member 0 args.areas |> not
                    , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 + 100 )
                    }
           ]
        ++ View.Level.upwardsButton
            { color = Yellow
            , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 + 100 )
            , onPress =
                (if Set.member 1 args.areas |> not then
                    [ 2 ]

                 else
                    [ 0, 2, 1 ]
                )
                    |> args.onPress
                    |> Just
            }
        ++ [ [ View.Level.downwardsHalfCircle
                { color = Blue
                , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
                , radius = Config.screenMinWidth // 2
                }
             ]
                |> View.Level.area
                    { transition = Set.member 2 args.transitioningArea
                    , visible = Set.member 2 args.areas |> not
                    , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 + 100 )
                    }
           , View.Level.downwardsHugeButton
                { color = Yellow
                , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
                , onPress =
                    [ 0, 1, 2, 3, 4 ]
                        |> args.onPress
                        |> Just
                }
                |> View.Level.area
                    { transition = Set.member 3 args.transitioningArea
                    , visible = Set.member 3 args.areas
                    , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 - 100 )
                    }
           , [ View.Level.base Blue ]
                |> View.Level.area
                    { transition = Set.member 4 args.transitioningArea
                    , visible = Set.member 4 args.areas |> not
                    , center = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 )
                    }
           ]


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
        , Html.Attributes.style "top" (String.fromInt (Config.screenMinHeight // 2 - 150) ++ "px")
        , Html.Attributes.style "left" (String.fromInt (Config.screenMinWidth // 2 - 50) ++ "px")
        ]
        { label = "Reset"
        , onPress = onPress |> Just
        }
