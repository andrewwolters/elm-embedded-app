module Msgs exposing (..)

import Http
import Models exposing (TeamMember, TeamMemberId)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchTeamMembers (WebData (List TeamMember))
    | OnLocationChange Location
    | ChangeName TeamMember String
    | OnTeamMemberSave (Result Http.Error TeamMember)
