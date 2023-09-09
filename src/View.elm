module View exposing (..)

import Config
import Game exposing (Color(..))
import Html exposing (Html)
import Html.Attributes


viewportMeta : Html msg
viewportMeta =
    let
        width : String
        width =
            --device-width
            String.fromFloat Config.screenMinWidth
    in
    Html.node "meta"
        [ Html.Attributes.name "viewport"
        , Html.Attributes.attribute "content" ("user-scalable=no,width=" ++ width)

        --  , Html.Attributes.attribute "content" ("initial-scale=1,user-scalable=no,width=" ++ width)
        ]
        []


boolColor : Bool -> String
boolColor bool =
    if bool then
        "var(--secondary-color)"

    else
        "var(--primary-color)"


color : Color -> String
color bool =
    case bool of
        Blue ->
            boolColor True

        Yellow ->
            boolColor False


negColor : Color -> String
negColor bool =
    case bool of
        Blue ->
            boolColor False

        Yellow ->
            boolColor True


stylesheet : Html msg
stylesheet =
    --In-Elm Stylesheet is usually easier to load by itch.io
    "" |> Html.text |> List.singleton |> Html.node "style" []
