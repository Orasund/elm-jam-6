module Game exposing (..)

import Array exposing (Array)
import Game.Level1
import Level exposing (Level)


type alias Game =
    { level : Level }


new : Game
new =
    { level = Game.Level1.init }


applyButton : Int -> Game -> Game
applyButton i game =
    game.level
        |> Level.getButton i
        |> Maybe.map
            (\button ->
                game.level
                    |> Level.removeButton i
                    |> Level.setArea button.target button.value
            )
        |> Maybe.withDefault game.level
        |> (\level -> { game | level = level })
