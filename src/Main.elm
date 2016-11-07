module Main exposing (..)

import Html exposing (..)
import Html.Attributes as A
import Html.App as App
import DashStyles as Styles
import Html.CssHelpers
import Date
import Models exposing (..)
import Requests.Status as StatusRequest
import Http
import Date.Format
import Task
import Dict
import Components.GridsterBox as G
import Components.Footer as Footer
import Components.Header as Header


--- Style


{ id, class, classList } =
    Html.CssHelpers.withNamespace "searchdash"



---


statusDecoder : String -> Status
statusDecoder status =
    case status of
        "BAD" ->
            BAD

        "WEAK" ->
            WEAK

        "GOOD" ->
            GOOD

        "INACTIVE" ->
            INACTIVE

        _ ->
            UNKNOWN


getStatus : Cmd Msg
getStatus =
    Task.perform StatusFetchFail StatusFetchSucceed StatusRequest.fetchStatus


init : ( Model, Cmd Msg )
init =
    { globalStatus = UNKNOWN, polling = True, siteStatus = Nothing, lastError = Nothing } ! [ getStatus ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div [ id [ Styles.StatusHolder ] ]
        [ Header.headerBox model
        , statusHolder model
        , Footer.footerBox model
        ]


statusHolder : Model -> Html Msg
statusHolder model =
    let
        statusH =
            case model.siteStatus of
                Nothing ->
                    text ""

                Just status ->
                    let
                        indicators =
                            Dict.values status.indicators

                        elements =
                            List.map G.gridsterBox indicators
                    in
                        ul [] elements
    in
        div [ A.id "statusHolder", class [ Styles.Gridster ] ]
            [ statusH ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        TogglePoll ->
            { model | polling = not model.polling } ! []

        StatusFetchFail error ->
            Debug.log "Failed fetching data" { model | lastError = Just error } ! []

        StatusFetchSucceed status ->
            let
                globalStatus =
                    statusDecoder status.status
            in
                { model | siteStatus = Just status, globalStatus = globalStatus } ! []


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
