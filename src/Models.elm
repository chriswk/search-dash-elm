module Models exposing (..)

import Dict exposing (Dict)


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
    , indicators : Dict String Indicator
    }


type alias IndicatorInfo =
    { details : IndicatorDetail
    , checkUrl : Maybe String
    , popOver : Popover
    , numChecks : Int
    }


type alias IndicatorDetail =
    { status : String
    , health : String
    , indicators : Dict String IndicatorDetailInfo
    , checks : Int
    }


type alias IndicatorDetailInfo =
    { status : String
    , health : String
    , name : String
    , time : Int
    , checks : Int
    , parent : Maybe String
    , cached : Bool
    , muted : Bool
    }


type alias Indicator =
    { status : String
    , health : String
    , name : String
    , time : Int
    , info : IndicatorInfo
    , checks : Int
    , cached : Bool
    }


type alias Popover =
    { title : String
    , status : String
    , test : Maybe String
    }
