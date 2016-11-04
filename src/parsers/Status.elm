module Parsers.Status exposing (..)

import Json.Decode.Extra exposing ((|:), date)
import Json.Decode exposing (Decoder, decodeValue, succeed, string, (:=), float, at, list, int)
import Models exposing (SiteStatus)


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
