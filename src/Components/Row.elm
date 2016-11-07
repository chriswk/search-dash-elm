module Components.Row exposing (..)

import Html exposing (..)
import Html.Attributes as A
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


emailSenderBox : IndicatorDetailInfo -> List (Html Msg)
emailSenderBox details =
    let
        middleClass =
            S.statusToCssClass details.health

        middleD =
            case details.middle of
                Nothing ->
                    ""

                Just m ->
                    toString m

        arrow =
            Maybe.map S.deltaToArrowClass details.arrow_value

        arrowClass =
            Maybe.withDefault "" arrow
    in
        [ hostNameTd details
        , td [ class [ middleClass ] ] [ text middleD ]
        , td [ A.class arrowClass ] []
        ]


hostNameTd : IndicatorDetailInfo -> Html Msg
hostNameTd details =
    let
        checkName =
            text details.name

        checkUrl =
            case details.info.checkurl of
                Nothing ->
                    checkName

                Just u ->
                    a [ A.href u ] [ checkName ]
    in
        td [ class [ S.HostShortname ] ] [ checkUrl ]


normalSearchBox : IndicatorDetailInfo -> List (Html Msg)
normalSearchBox details =
    let
        status =
            S.statusToCssClass details.status

        cssClass =
            class [ status ]

        circleClass =
            class [ S.Circle, status ]
    in
        [ hostNameTd details
        , td [ cssClass ] []
        , td [ circleClass ] []
        ]


row : IndicatorDetailInfo -> Html Msg
row details =
    let
        boxType =
            case details.arrow_value of
                Nothing ->
                    normalSearchBox details

                Just arrow ->
                    emailSenderBox details
    in
        tr []
            boxType
