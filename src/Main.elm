module Main exposing (..)

import Html exposing (..)
import Html.App as App
import DashStyles as Styles
import Time exposing (Time)
import Html.CssHelpers
import Date
import Models exposing (Status(..), SiteStatus)
import Requests.Status as StatusRequest
import Http
import Date.Format
import Task


type Msg
    = NoOp
    | TogglePoll
    | StatusFetchFail Http.Error
    | StatusFetchSucceed SiteStatus


type alias Model =
    { globalStatus : Status
    , polling : Bool
    , siteStatus : Maybe SiteStatus
    , lastError : Maybe Http.Error
    }


dateFormat : String
dateFormat =
    "%Y%m%d %H:%M:%S"



--- Style


{ class } =
    Html.CssHelpers.withNamespace "searchdash"



---


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
    div []
        [ headerBox model
        , boxes model
        , footerBox model
        ]


boxes : Model -> Html Msg
boxes model =
    let
        siteStatus =
            case model.siteStatus of
                Nothing ->
                    ""

                Just stat ->
                    toString stat
    in
        div [] [ text siteStatus ]


headerBox : Model -> Html Msg
headerBox model =
    let
        globalCssStatus =
            case model.globalStatus of
                WEAK ->
                    class [ Styles.Weak ]

                GOOD ->
                    class [ Styles.Good ]

                BAD ->
                    class [ Styles.Bad ]

                INACTIVE ->
                    class [ Styles.Inactive ]

                UNKNOWN ->
                    class [ Styles.Unknown ]

        updateStat =
            case model.siteStatus of
                Nothing ->
                    ""

                Just stat ->
                    let
                        d =
                            Date.fromTime stat.checkPerformed

                        ds =
                            Date.Format.format dateFormat d

                        taken =
                            (toString stat.timeTaken)
                    in
                        " - " ++ ds ++ " (" ++ taken ++ "ms)"

        textTeaser =
            "Search Health" ++ updateStat
    in
        div []
            [ h1 [ globalCssStatus ] [ text textTeaser ] ]


footerBox : Model -> Html Msg
footerBox model =
    div [ class [ Styles.Links ] ]
        [ ul []
            [ li [] [ text "Controlpanel" ]
            ]
        ]


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
            { model | siteStatus = Just status } ! []


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
