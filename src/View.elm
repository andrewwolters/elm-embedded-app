module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, TeamMemberId)
import Models exposing (Model)
import Msgs exposing (Msg)
import Team.Edit
import Team.List
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.TeamRoute ->
            Team.List.view model.teamMembers

        Models.TeamMemberRoute id ->
            teamMemberEditPage model id

        Models.NotFoundRoute ->
            notFoundView


teamMemberEditPage : Model -> TeamMemberId -> Html Msg
teamMemberEditPage model teamMemberId =
    case model.teamMembers of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success teamMembers ->
            let
                maybeTeamMember =
                    teamMembers
                        |> List.filter (\teamMember -> teamMember.id == teamMemberId)
                        |> List.head
            in
                case maybeTeamMember of
                    Just teamMember ->
                        Team.Edit.view teamMember

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
