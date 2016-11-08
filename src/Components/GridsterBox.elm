module Components.GridsterBox exposing (..)

import Html exposing (..)
import Html.Attributes as A
import DashStyles as S
import Models exposing (..)
import Html.CssHelpers
import Components.Row as Row
import Dict


--- Style


{ class } =
    Html.CssHelpers.withNamespace "searchdash"



---


gridsterBox : Indicator -> Html Msg
gridsterBox indicator =
    let
        health =
            S.statusToCssClass indicator.health

        heightClass =
            S.heightToCssClass indicator.height

        widthClass =
            S.widthToCssClass 1

        colClass =
            S.colToCssClass indicator.column

        rowClass =
            S.rowToCssClass indicator.row

        cssClasses =
            class [ health, heightClass, widthClass, colClass, rowClass, S.GridsterRow ]

        title =
            case indicator.info.checkUrl of
                Nothing ->
                    text indicator.name

                Just u ->
                    a [ A.href u ] [ text indicator.name ]

        header =
            h1 [ class [ S.Title ] ]
                [ title ]

        rows =
            case indicator.info.details of
                Empty ->
                    []

                Detail d ->
                    Dict.values d.indicators

        tableRows =
            List.map Row.row rows

        dataTable =
            table [ class [ S.DataTable ] ]
                [ tbody [] tableRows
                ]
    in
        li
            [ cssClasses ]
            [ div [ class [ health ] ]
                [ header
                , dataTable
                ]
            ]
