port module Main exposing (..)

import Browser
import Config
import Game exposing (Game)
import Html exposing (Html)
import Html.Attributes
import Level
import Overlay exposing (Overlay(..))
import Process
import Random exposing (Generator, Seed)
import Set exposing (Set)
import Task
import View
import View.Overlay


port playSound : String -> Cmd msg


type alias Model =
    { game : Game
    , overlay : Maybe Overlay
    , seed : Seed
    , transitioningArea : Set Int
    }


type Msg
    = NewGame
    | SetOverlay (Maybe Overlay)
    | GotSeed Seed
    | StartTransition (List Int)
    | EndTransition
    | SetState (List Int)
    | ClearedLevel
    | ResetLevel


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
            Level.toGame 6
                |> Maybe.withDefault Game.empty
      , seed = Random.initialSeed 42
      , overlay = Nothing
      , transitioningArea = Set.empty
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


startTransition : List Int -> Model -> ( Model, Cmd Msg )
startTransition list model =
    if Set.isEmpty model.transitioningArea then
        ( { model | transitioningArea = list |> Set.fromList }
        , Task.succeed ()
            |> Task.perform (\() -> SetState list)
        )

    else
        ( model, Cmd.none )


endTransition : Model -> Model
endTransition model =
    { model | transitioningArea = Set.empty }


setState : List Int -> Model -> ( Model, Cmd Msg )
setState list model =
    let
        game =
            list
                |> List.foldl Game.applyButton model.game
    in
    ( { model
        | game = game
        , overlay = Nothing
      }
    , [ if Game.isCleared game then
            Process.sleep 4000
                |> Task.perform (\() -> ClearedLevel)

        else
            Process.sleep 3000
                |> Task.perform (\() -> EndTransition)
      , playSound "buttonPress"
      ]
        |> Cmd.batch
    )


levelCleared : Model -> Model
levelCleared model =
    { model
        | game =
            Level.toGame (model.game.level + 1)
                |> Maybe.withDefault Game.empty
        , transitioningArea = Set.empty
        , overlay = Just LevelCleared
    }


resetLevel : Model -> ( Model, Cmd Msg )
resetLevel model =
    ( { model
        | game = Level.toGame model.game.level |> Maybe.withDefault Game.empty
        , transitioningArea = Set.empty
        , overlay = Just LevelCleared
      }
    , playSound "buttonPress"
    )


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

        SetState list ->
            model |> setState list

        StartTransition list ->
            model |> startTransition list

        EndTransition ->
            model |> endTransition |> withNoCmd

        ClearedLevel ->
            model |> levelCleared |> withNoCmd

        ResetLevel ->
            model |> resetLevel


viewOverlay : Model -> Overlay -> Html Msg
viewOverlay _ overlay =
    case overlay of
        GameMenu ->
            View.Overlay.gameMenu
                { startGame = NewGame }

        GameEnd ->
            View.Overlay.gameEnd

        LevelCleared ->
            View.Overlay.levelCleared


view :
    Model
    ->
        { title : String
        , body : List (Html Msg)
        }
view model =
    let
        content =
            model.game.level
                |> Level.toHtml
                    { onPress = StartTransition
                    , areas = model.game.areas
                    , transitioningArea = model.transitioningArea
                    , reset = ResetLevel
                    }
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
