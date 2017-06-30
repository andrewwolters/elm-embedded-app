module Team.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href, placeholder)
import Html.Events exposing (onClick, onInput)
import Models exposing (TeamMember)
import Msgs exposing (Msg)
import Routing exposing (teamMembersPath)


view : TeamMember -> Html.Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : TeamMember -> Html.Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : TeamMember -> Html.Html Msg
form teamMember =
    div [ class "m3" ]
        [ input [ placeholder teamMember.name, onInput (Msgs.ChangeName teamMember) ] []
        ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href teamMembersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
