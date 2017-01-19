module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation exposing (Location)
import Routing exposing (parseLocation, Route(..))
import Views.About
import Views.Index
import Views.NotFound

type Msg = OnLocationChange Location

type alias Model =
  {
    route : Routing.Route
  }

initModel : Route -> Model
initModel route =
  { route = route }

init : Location -> (Model, Cmd Msg)
init location =
  let
    currentRoute = parseLocation location
  in
    (initModel currentRoute, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    OnLocationChange location ->
      let
        newRoute = parseLocation location
      in
        ({ model | route = newRoute}, Cmd.none)

page : Model -> Html Msg
page model =
  case model.route of
    About ->
       Views.About.view
    Index ->
      Views.Index.view
    NotFound ->
      Views.NotFound.view

view : Model -> Html Msg
view model =
  div [] [
    ul [] [
      li [] [
        a [href "/#about"] [text "About"]
      ],
      li [] [
        a [href "/#"] [text "Index"]
      ],
      li [] [
        a [href "/#n"] [text "Not Found"]
      ]
    ],
    div [] [ page model ]
  ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

main : Program Never Model Msg
main =
  Navigation.program OnLocationChange {init = init, update = update, view = view, subscriptions = subscriptions}
