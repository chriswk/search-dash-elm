module Components.Header exposing (..)

import Html exposing (..)
import DashStyles as Styles
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
