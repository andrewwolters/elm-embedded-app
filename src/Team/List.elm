module Team.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Models exposing (TeamMember)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (teamMemberPath)


view : WebData (List TeamMember) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "TeamMembers" ] ]


maybeList : WebData (List TeamMember) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success teamMembers ->
            list teamMembers

        RemoteData.Failure error ->
            text (toString error)


list : List TeamMember -> Html Msg
list teamMembers =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map teamMemberRow teamMembers)
            ]
        ]


teamMemberRow : TeamMember -> Html Msg
teamMemberRow teamMember =
    tr []
        [ td [] [ text teamMember.id ]
        , td [] [ text teamMember.name ]
        , td []
            [ editBtn teamMember ]
        ]


editBtn : TeamMember -> Html.Html Msg
editBtn teamMember =
    let
        path =
            teamMemberPath teamMember.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
