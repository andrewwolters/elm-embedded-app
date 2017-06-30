module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Msgs exposing (Msg)
import Models exposing (TeamMemberId, TeamMember)
import RemoteData


fetchTeamMembers : Cmd Msg
fetchTeamMembers =
    Http.get fetchTeamMembersUrl teamMembersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchTeamMembers


fetchTeamMembersUrl : String
fetchTeamMembersUrl =
    "http://localhost:4000/team"


saveTeamMemberUrl : TeamMemberId -> String
saveTeamMemberUrl teamMemberId =
    "http://localhost:4000/team/" ++ teamMemberId


saveTeamMemberRequest : TeamMember -> Http.Request TeamMember
saveTeamMemberRequest teamMember =
    Http.request
        { body = teamMemberEncoder teamMember |> Http.jsonBody
        , expect = Http.expectJson teamMemberDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveTeamMemberUrl teamMember.id
        , withCredentials = False
        }


saveTeamMemberCmd : TeamMember -> Cmd Msg
saveTeamMemberCmd teamMember =
    saveTeamMemberRequest teamMember
        |> Http.send Msgs.OnTeamMemberSave



-- DECODERS


teamMembersDecoder : Decode.Decoder (List TeamMember)
teamMembersDecoder =
    Decode.list teamMemberDecoder


teamMemberDecoder : Decode.Decoder TeamMember
teamMemberDecoder =
    decode TeamMember
        |> required "id" Decode.string
        |> required "name" Decode.string


teamMemberEncoder : TeamMember -> Encode.Value
teamMemberEncoder teamMember =
    let
        attributes =
            [ ( "id", Encode.string teamMember.id )
            , ( "name", Encode.string teamMember.name )
            ]
    in
        Encode.object attributes
