module Components.Header exposing (..)

import Html exposing (..)
import DashStyles as S
import Html.CssHelpers
import Models exposing (..)
import Date
import Date.Format


--- Style


{ class } =
    Html.CssHelpers.withNamespace "searchdash"



---


headerBox : Model -> Html Msg
headerBox model =
    let
        globalCssStatus =
            S.statToCssClass model.globalStatus

        cssClasses =
            class [ S.PageTitle, globalCssStatus ]

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
            [ h1 [ cssClasses ] [ text textTeaser ] ]
