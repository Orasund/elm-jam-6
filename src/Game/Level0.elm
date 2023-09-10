module Game.Level0 exposing (..)

import Config
import Game exposing (Args, Color(..), LevelDef)
import Html exposing (Html)
import Html.Attributes
import Layout
import Set
import View.Level


def : LevelDef msg
def =
    { init = Set.fromList [ 0 ]
    , toHtml = toHtml
    }


toHtml : Args msg -> List (Html msg)
toHtml args =
    [ View.Level.base Blue
    , Layout.text
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "100px"
        , Html.Attributes.style "width" "400px"
        , Html.Attributes.style "justify-content" "center"
        , Html.Attributes.style "color" "var(--primary-color)"
        , Html.Attributes.class "font-size-title"
        , Html.Attributes.style "font-weight" "bold"
        ]
        "Lasche"
    , Layout.text
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "240px"
        , Html.Attributes.style "width" "400px"
        , Html.Attributes.style "justify-content" "center"
        , Html.Attributes.style "color" "var(--primary-color)"
        , Html.Attributes.class "font-size-big"
        , Html.Attributes.style "font-weight" "thin"
        ]
        "by"
    , Layout.text
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" "275px"
        , Html.Attributes.style "width" "400px"
        , Html.Attributes.style "justify-content" "center"
        , Html.Attributes.style "color" "var(--primary-color)"
        , Html.Attributes.class "font-size-big"
        ]
        "Lucas Payr"
    ]
        ++ View.Level.downwardsBigButton
            { color = Yellow
            , pos =
                ( Config.screenMinWidth // 2
                , Config.screenMinHeight - 200
                )
            , onPress = args.onPress [ 0 ] |> Just
            }
        ++ [ [ View.Level.base Blue ]
                |> View.Level.area
                    { transition = Set.member 0 args.transitioningArea
                    , visible = Set.member 0 args.areas |> not
                    , center =
                        ( Config.screenMinWidth // 2
                        , Config.screenMinHeight - 200
                        )
                    }
           ]
