module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)

type Route
  = About | Index | NotFound

matchers : Parser (Route -> a) a
matchers =
  oneOf [
    map Index top,
    map About (s "about")
  ]

parseLocation : Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route

    Nothing ->
      NotFound
