module View.Level exposing (..)

import Html exposing (Attribute, Html)
import Html.Attributes
import Layout
import View


base : Bool -> Html msg
base bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "height" "100%"
        , Html.Attributes.style "width" "100%"
        , Html.Attributes.style "background-color" (View.binaryColor bool)
        ]
        Layout.none


area : List (Attribute msg) -> List (Html msg) -> Html msg
area attrs =
    Html.div
        ([ Html.Attributes.style "position" "absolute"
         , Html.Attributes.style "z-index" "1"
         , Html.Attributes.style "height" "100%"
         , Html.Attributes.style "width" "100%"
         , Html.Attributes.style "transition" "clip-path 10s"
         , Html.Attributes.style "transition-timing-function" "cubic-bezier(1 0 1 1)"
         ]
            ++ attrs
        )


button : Bool -> List (Attribute msg) -> msg -> Html msg
button bool attrs onPress =
    Layout.textButton
        ([ Html.Attributes.style "aspect-ratio" "1"
         , Html.Attributes.style "position" "absolute"
         , Html.Attributes.style "border-radius" "100%"
         , Html.Attributes.class "font-size-big"
         , Html.Attributes.style "background-color" (View.binaryColor bool)
         , Html.Attributes.style "color" (View.binaryColor (not bool))
         ]
            ++ attrs
        )
        { label = "Click Me"
        , onPress = onPress |> Just
        }
