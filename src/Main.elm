module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)

type Msg = NoOp | Yes | No

type alias Model = String

init : (Model, Cmd Msg)
init =
  ("", Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Yes -> (model ++ "Yes", Cmd.none)
    No -> (model ++ "No", Cmd.none)
    NoOp -> ("", Cmd.none)

view : Model -> Html Msg
view model =
  div [] [
    button [onClick Yes] [Html.text "Yes"],
    button [onClick No] [Html.text "No"],
    button [onClick NoOp] [Html.text "Clear"],
    span [] [Html.text model]
  ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

main : Program Never Model Msg
main =
  Html.program {init = init, update = update, view = view, subscriptions = subscriptions}
