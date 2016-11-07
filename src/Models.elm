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


type IndicatorDetail
    = Empty
    | Detail { status : String, health : String, indicators : Dict String IndicatorDetailInfo, checks : Int }


type alias IndicatorInfo =
    { checkUrl : Maybe String
    , details : IndicatorDetail
    , numChecks : Int
    , popOver : Popover
    }


type alias IndicatorDetailInfo =
    { arrow_value : Maybe Float
    , cached : Bool
    , checks : Int
    , health : String
    , info : IndicatorDetailInfoInfo
    , lastWeek : Maybe Int
    , middle : Maybe Int
    , muted : Bool
    , name : String
    , parent : Maybe String
    , percent_change : Maybe Float
    , percent_change_yesterday : Maybe Float
    , status : String
    , time : Int
    , today : Maybe Int
    , yesterday : Maybe Int
    }


type alias IndicatorDetailInfoInfo =
    { checkurl : Maybe String
    , popover : Popover
    , numChecks : Int
    }


type alias Indicator =
    { status : String
    , health : String
    , name : String
    , time : Int
    , info : IndicatorInfo
    , checks : Int
    , cached : Bool
    , height : Int
    }


type alias Popover =
    { title : Maybe String
    , status : Maybe String
    , text : Maybe String
    }
