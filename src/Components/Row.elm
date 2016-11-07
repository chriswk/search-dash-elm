module Components.Row exposing (..)

import Html exposing (..)
import Html.CssHelpers
import DashStyles as S
import Models exposing (..)


--- Style


{ class } =
    Html.CssHelpers.withNamespace "searchdash"



---


popover : Popover -> Html Msg
popover pop =
    let
        status =
            case pop.status of
                Nothing ->
                    text ""

                Just s ->
                    thead [] [ text s ]

        popText =
            case pop.text of
                Nothing ->
                    text ""

                Just t ->
                    tbody [] [ text t ]
    in
        table [ class [ S.PopTable ] ]
            [ status
            , popText
            ]


row : IndicatorDetailInfo -> Html Msg
row details =
    let
        healthClass =
            S.statusToCssClass details.status
    in
        tr []
            [ td [ class [ S.HostShortname ] ]
                [ text details.name
                ]
            , td [ class [ healthClass ] ] []
            ]
