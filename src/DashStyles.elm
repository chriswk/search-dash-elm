module DashStyles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Css.Elements as E
import Styles.Variables as V
import Models exposing (Status(..))


type CssClasses
    = Good
    | Bad
    | Weak
    | Unknown
    | Inactive
    | Circle
    | Skipped
    | DataTable
    | PageTitle
    | UpdatedAt
    | Title
    | IconArrowDown
    | IconArrowUp
    | IconArrowRight
    | Cached
    | HostShortname
    | Widget
    | Gridster
    | Links
    | Popover
    | PopoverContent
    | PopTable
    | Size1Y
    | Size2Y
    | Size3Y
    | Size4Y
    | Size5Y
    | Size6Y
    | Size7Y
    | Size8Y
    | Size9Y
    | Size10Y
    | Size1X
    | Size2X
    | Size3X
    | Size4X
    | Size5X


type CssIds
    = Main
    | StatusHolder


statToCssClass : Status -> CssClasses
statToCssClass status =
    case status of
        WEAK ->
            Weak

        GOOD ->
            Good

        BAD ->
            Bad

        _ ->
            Unknown


statusToCssClass : String -> CssClasses
statusToCssClass status =
    case status of
        "WEAK" ->
            Weak

        "GOOD" ->
            Good

        "BAD" ->
            Bad

        _ ->
            Unknown


deltaToArrowClass : Float -> String
deltaToArrowClass delta =
    if delta > 0 then
        "icon-arrow_up"
    else if delta < 0 then
        "icon-arrow_down"
    else
        "icon-arrow_right"


widthToCssClass : Int -> CssClasses
widthToCssClass w =
    case w of
        1 ->
            Size1X

        2 ->
            Size2X

        3 ->
            Size3X

        4 ->
            Size4X

        5 ->
            Size5X

        _ ->
            Size1X


heightToCssClass : Int -> CssClasses
heightToCssClass height =
    case height of
        1 ->
            Size1Y

        2 ->
            Size2Y

        3 ->
            Size3Y

        4 ->
            Size4Y

        5 ->
            Size5Y

        6 ->
            Size6Y

        7 ->
            Size7Y

        8 ->
            Size8Y

        9 ->
            Size9Y

        10 ->
            Size10Y

        _ ->
            Size1Y


heightToPx : Int -> Mixin
heightToPx h =
    let
        pxCount =
            if h <= 1 then
                120
            else
                (120 + (h * 132))
    in
        height (px pxCount)


widthToPx : Int -> Mixin
widthToPx w =
    let
        pxCount =
            if w <= 1 then
                220
            else
                (200 + (w * 212))
    in
        width (px pxCount)


css : Stylesheet
css =
    (stylesheet << namespace "searchdash")
        [ E.body
            [ overflowX auto
            , minWidth (px 1280)
            , color (hex "ffffff")
            , property "background" <| .value <| (hex "222222")
            ]
        , E.ul
            [ listStyleType none
            , position relative
            ]
        , E.h1
            [ marginBottom (px 12)
            , marginTop (px 12)
            , paddingTop (px 6)
            , paddingBottom (px 6)
            , textAlign center
            , fontSize (px 30)
            , fontWeight (int 600)
            , withClass PageTitle
                [ backgroundColor V.boringGrey
                , withClass Good [ property "background" <| .value <| V.goodColour ]
                , withClass Weak [ property "background" <| .value <| V.weakColour ]
                , withClass Bad [ property "background" <| .value <| V.badColour ]
                ]
            , withClass Title
                [ fontSize (px 14)
                , textAlign left
                , marginLeft (px 3)
                , marginTop (px 5)
                , marginBottom (px 5)
                , color (rgba 0 0 0 0.5)
                ]
            ]
        , E.table
            [ width (pct 100)
            , withClass DataTable
                [ property "tableLayout" <| .value <| fixed
                , whiteSpace noWrap
                , overflow hidden
                , textOverflow ellipsis
                ]
            ]
        , (.) Good
            [ property "background" <| .value <| V.goodColour ]
        , (.) Bad
            [ property "background" <| .value <| V.badColour ]
        , (.) Weak
            [ property "background" <| .value <| V.weakColour ]
        , (.) Unknown
            [ property "background" <| .value <| V.unknownColour ]
        , (.) Inactive
            [ property "background" <| .value <| V.inactiveColour ]
        , (.) Circle
            [ borderRadius (pct 50)
            , width (px 18)
            , height (px 18)
            , marginTop (px 5)
            , withClass Good [ property "background" <| .value <| V.green ]
            , withClass Weak [ property "background" <| .value <| V.yellow ]
            , withClass Bad [ property "background" <| .value <| V.red ]
            , withClass Unknown [ property "background" <| .value <| V.deepPink ]
            ]
        , (.) IconArrowUp [ color V.goodColour ]
        , (.) IconArrowDown [ color V.badColour ]
        , (.) IconArrowRight [ color (hex "ffffff") ]
        , (.) Size1Y [ heightToPx 1 ]
        , (.) Size2Y [ heightToPx 2 ]
        , (.) Size3Y [ heightToPx 3 ]
        , (.) Size4Y [ heightToPx 4 ]
        , (.) Size5Y [ heightToPx 5 ]
        , (.) Size6Y [ heightToPx 6 ]
        , (.) Size7Y [ heightToPx 7 ]
        , (.) Size8Y [ heightToPx 8 ]
        , (.) Size9Y [ heightToPx 9 ]
        , (.) Size10Y [ heightToPx 10 ]
        , (.) Size1X [ widthToPx 1 ]
        , (.) Size2X [ widthToPx 2 ]
        , (.) Size3X [ widthToPx 3 ]
        , (.) Size4X [ widthToPx 4 ]
        , (.) Size5X [ widthToPx 5 ]
        ]
