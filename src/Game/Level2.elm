module Game.Level2 exposing (..)

import Config
import Game exposing (Args, Color(..), LevelDef)
import Html exposing (Html)
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
             , View.Level.reset
                { onPress = args.reset
                , pos = ( Config.screenMinWidth // 2, Config.screenMinHeight // 2 - 100 )
                }
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
