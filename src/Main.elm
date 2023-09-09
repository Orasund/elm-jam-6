module Main exposing (..)

import Browser
import Config
import Game exposing (Game)
import Game.Level2
import Html exposing (Html)
import Html.Attributes
import Level
import Overlay exposing (Overlay(..))
import Process
import Random exposing (Generator, Seed)
import Set
import Task
import View
import View.Overlay


type alias Model =
    { game : Game
    , overlay : Maybe Overlay
    , seed : Seed
    }


type Msg
    = NewGame
    | SetOverlay (Maybe Overlay)
    | GotSeed Seed
    | SetState Int
    | LevelCleared


apply : Model -> Generator Model -> Model
apply { seed } generator =
    let
        ( model, newSeed ) =
            Random.step generator seed
    in
    { model | seed = newSeed }


init : () -> ( Model, Cmd Msg )
init () =
    ( { game =
            Level.toGame 1
                |> Maybe.withDefault Game.empty
      , seed = Random.initialSeed 42
      , overlay = Nothing
      }
    , Cmd.none
    )


newGame : Model -> Model
newGame model =
    { model
        | game =
            Level.toGame 1
                |> Maybe.withDefault Game.empty
    }
        |> setOverlay Nothing


gotSeed : Seed -> Model -> Model
gotSeed seed model =
    { model | seed = seed }


setOverlay : Maybe Overlay -> Model -> Model
setOverlay maybeOverlay model =
    { model | overlay = maybeOverlay }


setState : Int -> Model -> ( Model, Cmd Msg )
setState i model =
    let
        game =
            model.game
                |> Game.applyButton i
    in
    ( { model | game = game }
    , if Game.isCleared game then
        Process.sleep 6000
            |> Task.perform (\() -> LevelCleared)

      else
        Cmd.none
    )


levelCleared : Model -> Model
levelCleared model =
    { model
        | game =
            Level.toGame (model.game.level + 1)
                |> Maybe.withDefault Game.empty
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        withNoCmd a =
            ( a, Cmd.none )
    in
    case msg of
        NewGame ->
            newGame model |> withNoCmd

        GotSeed seed ->
            model |> gotSeed seed |> withNoCmd

        SetOverlay maybeOverlay ->
            model |> setOverlay maybeOverlay |> withNoCmd

        SetState i ->
            model
                |> setState i

        LevelCleared ->
            model |> levelCleared |> withNoCmd


viewOverlay : Model -> Overlay -> Html Msg
viewOverlay _ overlay =
    case overlay of
        GameMenu ->
            View.Overlay.gameMenu
                { startGame = NewGame }

        GameEnd ->
            View.Overlay.gameEnd


view :
    Model
    ->
        { title : String
        , body : List (Html Msg)
        }
view model =
    let
        content =
            model.game.areas
                |> Level.toHtml { onPress = SetState } model.game.level
                |> Maybe.withDefault [ View.Overlay.gameEnd ]
    in
    { title = Config.title
    , body =
        [ View.viewportMeta

        --, View.stylesheet
        , model.overlay
            |> Maybe.map (viewOverlay model)
            |> Maybe.map List.singleton
            |> Maybe.withDefault []
            |> (::) (content |> Html.div [ Html.Attributes.class "content" ])
            |> Html.div
                [ Html.Attributes.style "width" (String.fromFloat Config.screenMinWidth ++ "px")
                , Html.Attributes.style "height" (String.fromFloat Config.screenMinHeight ++ "px")
                , Html.Attributes.class "container"
                ]
        ]
    }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
