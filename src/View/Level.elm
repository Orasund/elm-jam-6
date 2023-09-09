module View.Level exposing (..)

import Config
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


area : { transition : Bool, center : ( Int, Int ), visible : Bool } -> List (Html msg) -> Html msg
area args =
    let
        ( x, y ) =
            args.center
    in
    Html.div
        ((if args.transition then
            [ Html.Attributes.class "areaTransition"
            , Html.Attributes.style "height" "100%"
            , Html.Attributes.style "width" "100%"
            ]

          else
            []
         )
            ++ [ Html.Attributes.style "position" "absolute"
               , "circle("
                    ++ (if args.visible then
                            String.fromFloat Config.screenMinHeight

                        else
                            String.fromFloat 0
                       )
                    ++ "px at "
                    ++ String.fromInt x
                    ++ "px "
                    ++ String.fromInt y
                    ++ "px)"
                    |> Html.Attributes.style "clip-path"
               ]
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


upwardsHalfCircle : { color : Color, pos : ( Int, Int ), radius : Int } -> Html msg
upwardsHalfCircle args =
    let
        ( x, y ) =
            args.pos
    in
    Layout.el
        [ Html.Attributes.style "aspect-ratio" "1"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "left" (String.fromInt (x - args.radius) ++ "px")
        , Html.Attributes.style "top" (String.fromInt (y - args.radius) ++ "px")
        , Html.Attributes.style "height" (String.fromInt args.radius ++ "px")
        , Html.Attributes.style "width" (String.fromInt (args.radius * 2) ++ "px")
        , Html.Attributes.style "border-radius"
            (String.fromInt args.radius
                ++ "px "
                ++ String.fromInt args.radius
                ++ "px 0 0"
            )
        , Html.Attributes.style "background-color" (View.color args.color)
        ]
        Layout.none


downwardsHalfCircle : { color : Color, pos : ( Int, Int ), radius : Int } -> Html msg
downwardsHalfCircle args =
    let
        ( x, y ) =
            args.pos
    in
    Layout.el
        [ Html.Attributes.style "aspect-ratio" "1"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "left" (String.fromInt (x - args.radius) ++ "px")
        , Html.Attributes.style "top" (String.fromInt y ++ "px")
        , Html.Attributes.style "height" (String.fromInt args.radius ++ "px")
        , Html.Attributes.style "width" (String.fromInt (args.radius * 2) ++ "px")
        , Html.Attributes.style "border-radius"
            ("0 0 "
                ++ String.fromInt args.radius
                ++ "px "
                ++ String.fromInt args.radius
                ++ "px"
            )
        , Html.Attributes.style "background-color" (View.color args.color)
        ]
        Layout.none


square : { color : Color, pos : ( Int, Int ), size : Int } -> Html msg
square args =
    let
        ( x, y ) =
            args.pos
    in
    Layout.el
        [ Html.Attributes.style "width" (String.fromInt args.size ++ "px")
        , Html.Attributes.style "height" (String.fromInt args.size ++ "px")
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "left" (String.fromInt (x - args.size // 2) ++ "px")
        , Html.Attributes.style "top" (String.fromInt (y - args.size // 2) ++ "px")
        , Html.Attributes.style "background-color" (View.color args.color)
        ]
        Layout.none


bottomHalf : Color -> Html msg
bottomHalf color =
    Layout.el
        [ Html.Attributes.style "width" (String.fromInt Config.screenMinWidth ++ "px")
        , Html.Attributes.style "height" (String.fromInt (Config.screenMinHeight // 2) ++ "px")
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" (String.fromInt (Config.screenMinHeight // 2) ++ "px")
        , Html.Attributes.style "left" "0"
        , Html.Attributes.style "background-color" (View.color color)
        ]
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


downwardsBigButton : { color : Color, pos : ( Int, Int ), onPress : msg } -> List (Html msg)
downwardsBigButton args =
    let
        ( x, y ) =
            args.pos
    in
    [ Layout.el
        [ Html.Attributes.style "width" "100px"
        , Html.Attributes.style "height" "200px"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" (String.fromInt y ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 50) ++ "px")
        , Html.Attributes.style "background-color" (View.color args.color)
        ]
        Layout.none
    , button args.color
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" (String.fromInt (y - 100) ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 100) ++ "px")
        , Html.Attributes.class "font-size-big"
        ]
        args.onPress
    ]


downwardsHugeButton : { color : Color, pos : ( Int, Int ), onPress : msg } -> List (Html msg)
downwardsHugeButton args =
    let
        ( x, y ) =
            args.pos
    in
    [ Layout.el
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "height" "400px"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" (String.fromInt y ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 100) ++ "px")
        , Html.Attributes.style "background-color" (View.color args.color)
        ]
        Layout.none
    , button args.color
        [ Html.Attributes.style "width" "400px"
        , Html.Attributes.style "top" (String.fromInt (y - 200) ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 200) ++ "px")
        , Html.Attributes.class "font-size-big"
        ]
        args.onPress
    ]


downwardsButton : { color : Color, pos : ( Int, Int ), onPress : msg } -> List (Html msg)
downwardsButton args =
    let
        ( x, y ) =
            args.pos
    in
    [ Layout.el
        [ Html.Attributes.style "width" "50px"
        , Html.Attributes.style "height" "100px"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" (String.fromInt y ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 25) ++ "px")
        , Html.Attributes.style "background-color" (View.color args.color)
        ]
        Layout.none
    , button args.color
        [ Html.Attributes.style "width" "100px"
        , Html.Attributes.style "top" (String.fromInt (y - 50) ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 50) ++ "px")
        , Html.Attributes.style "font-weight" "bold"
        ]
        args.onPress
    ]


upwardsBigButton : { color : Color, pos : ( Int, Int ), onPress : msg } -> List (Html msg)
upwardsBigButton args =
    let
        ( x, y ) =
            args.pos
    in
    [ Layout.el
        [ Html.Attributes.style "width" "100px"
        , Html.Attributes.style "height" "200px"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" (String.fromInt (y - 200) ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 50) ++ "px")
        , Html.Attributes.style "background-color" (View.color args.color)
        ]
        Layout.none
    , button args.color
        [ Html.Attributes.style "width" "200px"
        , Html.Attributes.style "top" (String.fromInt (y - 100) ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 100) ++ "px")
        , Html.Attributes.class "font-size-big"
        ]
        args.onPress
    ]


upwardsButton : { color : Color, pos : ( Int, Int ), onPress : msg } -> List (Html msg)
upwardsButton args =
    let
        ( x, y ) =
            args.pos
    in
    [ Layout.el
        [ Html.Attributes.style "width" "50px"
        , Html.Attributes.style "height" "100px"
        , Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "top" (String.fromInt (y - 100) ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 25) ++ "px")
        , Html.Attributes.style "background-color" (View.color args.color)
        ]
        Layout.none
    , button args.color
        [ Html.Attributes.style "width" "100px"
        , Html.Attributes.style "top" (String.fromInt (y - 50) ++ "px")
        , Html.Attributes.style "left" (String.fromInt (x - 50) ++ "px")
        , Html.Attributes.style "font-weight" "bold"
        ]
        args.onPress
    ]
