module Update exposing (..)

import Commands exposing (saveTeamMemberCmd)
import Models exposing (Model, TeamMember)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchTeamMembers response ->
            ( { model | teamMembers = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeName teamMember name ->
            let
                updatedTeamMember =
                    { teamMember | name = name }
            in
                ( model, saveTeamMemberCmd updatedTeamMember )

        Msgs.OnTeamMemberSave (Ok teamMember) ->
            ( updateTeamMember model teamMember, Cmd.none )

        Msgs.OnTeamMemberSave (Err error) ->
            ( model, Cmd.none )


updateTeamMember : Model -> TeamMember -> Model
updateTeamMember model updatedTeamMember =
    let
        pick currentTeamMember =
            if updatedTeamMember.id == currentTeamMember.id then
                updatedTeamMember
            else
                currentTeamMember

        updateTeamMemberList teamMembers =
            List.map pick teamMembers

        updatedTeamMembers =
            RemoteData.map updateTeamMemberList model.teamMembers
    in
        { model | teamMembers = updatedTeamMembers }
