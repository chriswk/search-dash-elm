module Components.Footer exposing (..)

import Html exposing (..)
import DashStyles as Styles
import Html.CssHelpers
import Models exposing (..)


--- Style


{ class } =
    Html.CssHelpers.withNamespace "searchdash"



---


footerBox : Model -> Html Msg
footerBox model =
    let
        error =
            case model.lastError of
                Nothing ->
                    ""

                Just err ->
                    toString err
    in
        div [ class [ Styles.Links ] ]
            [ ul []
                [ li [] [ text "Controlpanel" ]
                , text error
                ]
            ]
