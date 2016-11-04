module Models exposing (..)


type Status
    = WEAK
    | GOOD
    | BAD
    | INACTIVE
    | UNKNOWN


type alias SiteStatus =
    { status : String
    , health : String
    , gui : String
    , timeTaken : Int
    , checkPerformed : Float
    , totalTestCount : Int
    , aggregatedTests : Int
    , goodTests : Int
    , failedTests : Int
    , checks : Int
    }
