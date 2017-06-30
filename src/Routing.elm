module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (TeamMemberId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map TeamRoute top
        , map TeamMemberRoute (s "team" </> string)
        , map TeamRoute (s "team")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


teamMembersPath : String
teamMembersPath =
    "#team"


teamMemberPath : TeamMemberId -> String
teamMemberPath id =
    "#team/" ++ id
