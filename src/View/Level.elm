module View.Level exposing (..)

import Game exposing (Color)
import Html exposing (Attribute, Html)
import Html.Attributes
import Layout
import Set exposing (Set)
import View


base : Color -> Html msg
base bool =
    Layout.el
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "height" "100%"
        , Html.Attributes.style "width" "100%"
        , Html.Attributes.style "background-color" (View.color bool)
        ]
        Layout.none


area : List (Attribute msg) -> { transition : Bool } -> List (Html msg) -> Html msg
area attrs args =
    Html.div
        ([ Html.Attributes.style "position" "absolute"

         --, Html.Attributes.style "z-index" "1"
         , Html.Attributes.style "height" "100%"
         , Html.Attributes.style "width" "100%"
         ]
            ++ (if args.transition then
                    [ Html.Attributes.class "areaTransition" ]

                else
                    []
               )
            ++ attrs
        )


circle : Color -> List (Attribute msg) -> Html msg
circle bool attrs =
    Layout.el
        ([ Html.Attributes.style "aspect-ratio" "1"
         , Html.Attributes.style "position" "absolute"
         , Html.Attributes.style "border-radius" "100%"
         , Html.Attributes.class "font-size-big"
         , Html.Attributes.style "background-color" (View.color bool)
         , Html.Attributes.style "color" (View.negColor bool)
         ]
            ++ attrs
        )
        Layout.none


button : Color -> List (Attribute msg) -> msg -> Html msg
button bool attrs onPress =
    Layout.textButton
        ([ Html.Attributes.style "aspect-ratio" "1"
         , Html.Attributes.style "position" "absolute"
         , Html.Attributes.style "border-radius" "100%"
         , Html.Attributes.style "background-color" (View.color bool)
         , Html.Attributes.style "color" (View.negColor bool)
         ]
            ++ attrs
        )
        { label = "Click Me"
        , onPress = onPress |> Just
        }
