module Parsers.Status exposing (..)

import Json.Decode.Extra exposing ((|:), maybeNull, withDefault)
import Json.Decode exposing (Decoder, decodeValue, dict, succeed, string, (:=), float, map, at, list, int, bool, maybe, oneOf, null)
import Models exposing (..)
import Dict exposing (Dict)


siteStatusDecoder : Decoder SiteStatus
siteStatusDecoder =
    succeed SiteStatus
        |: ("status" := string)
        |: ("health" := string)
        |: ("GUI" := string)
        |: ("time" := int)
        |: ("now" := float)
        |: ("tests_incl_aggr" := int)
        |: ("aggr_tests" := int)
        |: ("good_tests" := int)
        |: ("failed_tests" := int)
        |: ("checks" := int)
        |: ("indicators" := (dict indicatorDecoder))


indicatorsDecoder : Decoder (Dict String Indicator)
indicatorsDecoder =
    dict indicatorDecoder


indicatorDecoder : Decoder Indicator
indicatorDecoder =
    succeed Indicator
        |: ("status" := string)
        |: ("health" := string)
        |: ("name" := string)
        |: ("time" := int)
        |: ("info" := indicatorInfoDecoder)
        |: ("checks" := int)
        |: ("cached" := bool)


indicatorInfoDecoder : Decoder IndicatorInfo
indicatorInfoDecoder =
    succeed IndicatorInfo
        |: ("details" := indicatorDetailsDecoder)
        |: ("checkurl" := maybeNull string)
        |: ("popOver" := popoverDecoder)
        |: ("numChecks" := int)


popoverDecoder : Decoder Popover
popoverDecoder =
    succeed Popover
        |: ("title" := string)
        |: ("status" := string)
        |: ("text" := (maybe string))


indicatorDetailsDecoder : Decoder IndicatorDetail
indicatorDetailsDecoder =
    succeed IndicatorDetail
        |: ("status" := string)
        |: ("health" := string)
        |: ("indicators" := (dict indicatorDetailInfoDecoder))
        |: ("checks" := int)


indicatorDetailInfoDecoder : Decoder IndicatorDetailInfo
indicatorDetailInfoDecoder =
    succeed IndicatorDetailInfo
        |: ("status" := string)
        |: ("health" := string)
        |: ("name" := string)
        |: ("time" := int)
        |: ("checks" := int)
        |: ("parent" := maybeNull string)
        |: ("cached" := bool)
        |: ("muted" := bool)
