module Models exposing (..)

import Dict exposing (Dict)
import Http


type Msg
    = NoOp
    | TogglePoll
    | StatusFetchFail Http.Error
    | StatusFetchSucceed SiteStatus


type Status
    = WEAK
    | GOOD
    | BAD
    | INACTIVE
    | UNKNOWN


dateFormat : String
dateFormat =
    "%Y%m%d %H:%M:%S"


type alias Model =
    { globalStatus : Status
    , polling : Bool
    , siteStatus : Maybe SiteStatus
    , lastError : Maybe Http.Error
    }


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
    { details : Maybe IndicatorDetail
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
    { title : Maybe String
    , status : Maybe String
    , text : Maybe String
    }
