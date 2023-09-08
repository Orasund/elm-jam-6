module View exposing (..)

import Config
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
        , Html.Attributes.attribute "content" ("initial-scale=1,user-scalable=no,width=" ++ width)
        ]
        []


binaryColor : Bool -> String
binaryColor bool =
    if bool then
        "var(--primary-color)"

    else
        "var(--secondary-color)"


stylesheet : Html msg
stylesheet =
    --In-Elm Stylesheet is usually easier to load by itch.io
    "" |> Html.text |> List.singleton |> Html.node "style" []
