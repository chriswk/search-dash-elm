port module Stylesheets exposing (..)

import Css.File exposing (..)
import Styles
import Html exposing (div)
import Html.App as App


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    toFileStructure [ ( "styles.css", compile [ Styles.css ] ) ]

main : Program.never
main =
  App.program {
    init = ( (), files cssFiles )
    , view = \_ -> (div [] [])
    , update = \_ _ -> ( (), Cmd.none )
    , subscriptions = \_ -> Sub.none
}
