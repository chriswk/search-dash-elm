module DashStyles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Css.Elements as E
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
    (stylesheet << namespace "searchdash")
        [ E.body
            [ overflowX auto
            , minWidth (px 1280)
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
                [ children
                    [ E.a []
                    ]
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
        ]
