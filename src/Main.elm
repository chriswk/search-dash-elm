module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)


type Status
    = WEAK
    | GOOD
    | BAD
    | INACTIVE
    | UNKNOWN


type Msg
    = NoOp
    | UpdatePoll String


type alias Model =
    { globalStatus : Status
    }


init : ( Model, Cmd Msg )
init =
    { globalStatus = GOOD } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div [] [ text "Hello" ]


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
