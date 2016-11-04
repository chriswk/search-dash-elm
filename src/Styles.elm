module Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Css.Elements
import Html.CssHelpers exposing (withNamespace)
import Styles.Variables as V
import Color


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


type CssIds
    = Main


css =
    (stylesheet << namespace "search-dash")
        [ body
            [ overflowX auto
            , minWidth (px 1280)
            ]
        , ul
            [ listStyleType none
            , position relative
            ]
        , h1
            [ marginBottom (px 12)
            , marginTop (px 12)
            , paddingTop (px 6)
            , paddingBottom (px 6)
            , textAlign center
            , fontSize (px 30)
            , fontWeight 600
            , children
                [ (.) PageTitle
                    [ children
                        [ (.) Good []
                        , (.) Weak []
                        , (.) Bad []
                        ]
                    ]
                , (.) Title
                    [ children
                        [ Css.Elements.a []
                        ]
                    ]
                ]
            ]
        , table
            [ width (pct 100)
                children
                [ (.) DataTable []
                ]
            ]
        , (.) Good
            [ backgroundColor V.goodColour ]
        , (.) Bad
            [ backgroundColor V.badColour ]
        , (.) Weak
            [ backgroundColor V.weakColour ]
        , (.) Unknown
            [ backgroundColor V.unknownColour ]
        , (.) Inactive
            [ backgroundColor V.inactiveColour ]
        , (.) Circle
            [ borderRadius (pct 50)
            , width (px 18)
            , height (px 18)
            , marginTop (px 5)
            , children
                [ (.) Good
                    [ backgroundColor Color.green ]
                , (.) Weak
                ]
            ]
        ]
