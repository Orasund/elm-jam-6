module Game.Level5 exposing (..)

import Config
import Game exposing (Args, Color(..), LevelDef)
import Html exposing (Html)
import Set
import View.Level


def : LevelDef msg
def =
    { init = [ 1, 2 ] |> Set.fromList
    , toHtml = toHtml
    }


toHtml : Args msg -> List (Html msg)
toHtml args =
    [ View.Level.base Yellow
    , View.Level.square
        { color = Blue
        , width = Config.screenMinWidth // 2
        , height = Config.screenMinHeight // 2
        , pos =
            ( Config.screenMinWidth // 4
            , Config.screenMinHeight // 4
            )
        }
    , View.Level.square
        { color = Blue
        , width = Config.screenMinWidth // 2
        , height = Config.screenMinHeight // 2
        , pos =
            ( Config.screenMinWidth * 3 // 4
            , Config.screenMinHeight * 3 // 4
            )
        }
    , View.Level.circle
        { color = Blue
        , pos = ( Config.screenMinWidth, 0 )
        , radius = 200
        }
    , View.Level.circle
        { color = Blue
        , pos = ( 0, Config.screenMinHeight )
        , radius = 200
        }
    ]
        ++ View.Level.rightwardsButton
            { color = Yellow
            , pos = ( 100, Config.screenMinHeight // 2 - 100 )
            , onPress =
                if Set.isEmpty args.transitioningArea |> not then
                    Nothing

                else
                    [ 1 ] |> args.onPress |> Just
            }
        ++ View.Level.upwardsButton
            { color = Blue
            , pos = ( 100, Config.screenMinHeight // 2 + 100 )
            , onPress =
                if Set.isEmpty args.transitioningArea |> not then
                    Nothing

                else
                    [ 0 ] |> args.onPress |> Just
            }
        ++ View.Level.downwardsButton
            { color = Blue
            , pos = ( 300, Config.screenMinHeight // 2 - 100 )
            , onPress =
                if Set.isEmpty args.transitioningArea |> not then
                    Nothing

                else
                    [ 3 ] |> args.onPress |> Just
            }
        ++ View.Level.leftwardsButton
            { color = Yellow
            , pos = ( 300, Config.screenMinHeight // 2 + 100 )
            , onPress =
                if Set.isEmpty args.transitioningArea |> not then
                    Nothing

                else
                    [ 2 ] |> args.onPress |> Just
            }
        ++ [ View.Level.upwardsButton
                { color = Yellow
                , pos = ( 100, Config.screenMinHeight // 2 + 100 )
                , onPress = Nothing
                }
                |> View.Level.area
                    { transition = Set.member 0 args.transitioningArea
                    , visible = Set.member 0 args.areas
                    , center = ( 100, Config.screenMinHeight // 2 + 100 )
                    }
           , View.Level.rightwardsButton
                { color = Blue
                , pos = ( 100, Config.screenMinHeight // 2 - 100 )
                , onPress = Nothing
                }
                |> View.Level.area
                    { transition = Set.member 1 args.transitioningArea
                    , visible = Set.member 1 args.areas |> not
                    , center = ( 100, Config.screenMinHeight // 2 - 100 )
                    }
           , View.Level.leftwardsButton
                { color = Blue
                , pos = ( 300, Config.screenMinHeight // 2 + 100 )
                , onPress = Nothing
                }
                |> View.Level.area
                    { transition = Set.member 2 args.transitioningArea
                    , visible = Set.member 2 args.areas |> not
                    , center = ( 300, Config.screenMinHeight // 2 + 100 )
                    }
           , View.Level.downwardsButton
                { color = Yellow
                , pos = ( 300, Config.screenMinHeight // 2 - 100 )
                , onPress = Nothing
                }
                |> View.Level.area
                    { transition = Set.member 3 args.transitioningArea
                    , visible = Set.member 3 args.areas
                    , center = ( 300, Config.screenMinHeight // 2 - 100 )
                    }
           , [ View.Level.square
                { color = Yellow
                , width = Config.screenMinWidth // 2
                , height = Config.screenMinHeight // 2
                , pos =
                    ( Config.screenMinWidth // 4
                    , Config.screenMinHeight // 4
                    )
                }
             ]
                |> View.Level.area
                    { transition = Set.member 0 args.transitioningArea
                    , visible = Set.member 0 args.areas
                    , center = ( 100, Config.screenMinHeight // 2 + 100 )
                    }
           , [ View.Level.square
                { color = Blue
                , width = Config.screenMinWidth // 2
                , height = Config.screenMinHeight // 2
                , pos =
                    ( Config.screenMinWidth * 3 // 4
                    , Config.screenMinHeight // 4
                    )
                }
             ]
                |> View.Level.area
                    { transition = Set.member 1 args.transitioningArea
                    , visible = Set.member 1 args.areas |> not
                    , center = ( 100, Config.screenMinHeight // 2 - 100 )
                    }
           , [ View.Level.square
                { color = Blue
                , width = Config.screenMinWidth // 2
                , height = Config.screenMinHeight // 2
                , pos =
                    ( Config.screenMinWidth // 4
                    , Config.screenMinHeight * 3 // 4
                    )
                }
             ]
                |> View.Level.area
                    { transition = Set.member 2 args.transitioningArea
                    , visible = Set.member 2 args.areas |> not
                    , center = ( 300, Config.screenMinHeight // 2 + 100 )
                    }
           , [ View.Level.square
                { color = Yellow
                , width = Config.screenMinWidth // 2
                , height = Config.screenMinHeight // 2
                , pos =
                    ( Config.screenMinWidth * 3 // 4
                    , Config.screenMinHeight * 3 // 4
                    )
                }
             ]
                |> View.Level.area
                    { transition = Set.member 3 args.transitioningArea
                    , visible = Set.member 3 args.areas
                    , center = ( 300, Config.screenMinHeight // 2 - 100 )
                    }
           ]
