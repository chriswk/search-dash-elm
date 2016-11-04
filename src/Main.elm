module Main exposing (..)

import Html exposing (..)
import Html.App as App
import DashStyles as Styles
import Time exposing (Time)
import Html.CssHelpers
import Date


type Status
    = WEAK
    | GOOD
    | BAD
    | INACTIVE
    | UNKNOWN


type Msg
    = NoOp
    | UpdatePoll String
    | TogglePoll


type alias UpdateStat =
    { updatedAt : Time, timeTaken : Int }


type alias Model =
    { globalStatus : Status
    , lastUpdated : Maybe UpdateStat
    , polling : Bool
    }



--- Style


{ class } =
    Html.CssHelpers.withNamespace "searchdash"



---


init : ( Model, Cmd Msg )
init =
    { globalStatus = GOOD, lastUpdated = Nothing, polling = True } ! []


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
    div [] []


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
            case model.lastUpdated of
                Nothing ->
                    ""

                Just stat ->
                    let
                        d =
                            Date.fromTime stat.updatedAt

                        ds =
                            toString d

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
    model ! []


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
