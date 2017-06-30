module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { teamMembers : WebData (List TeamMember)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { teamMembers = RemoteData.Loading
    , route = route
    }


type alias TeamMemberId =
    String


type alias TeamMember =
    { id : TeamMemberId
    , name : String
    }


type Route
    = TeamRoute
    | TeamMemberRoute TeamMemberId
    | NotFoundRoute
