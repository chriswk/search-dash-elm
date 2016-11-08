module Parsers.Status exposing (..)

import Json.Decode.Pipeline exposing (required, decode, optional, nullable)
import Json.Decode exposing (Decoder, object1, andThen, decodeValue, dict, succeed, string, (:=), float, map, at, list, int, bool, maybe, oneOf, null)
import Models exposing (..)
import Dict exposing (Dict)


siteStatusDecoder : Decoder SiteStatus
siteStatusDecoder =
    decode SiteStatus
        |> required "status" string
        |> required "health" string
        |> required "GUI" string
        |> required "time" int
        |> required "now" float
        |> required "tests_incl_aggr" int
        |> required "aggr_tests" int
        |> required "good_tests" int
        |> required "failed_tests" int
        |> required "checks" int
        |> required "indicators" (dict indicatorDecoder)


indicatorsDecoder : Decoder (Dict String Indicator)
indicatorsDecoder =
    dict indicatorDecoder


indicatorDecoder : Decoder Indicator
indicatorDecoder =
    decode Indicator
        |> required "status" string
        |> required "health" string
        |> required "name" string
        |> required "time" int
        |> required "info" indicatorInfoDecoder
        |> required "checks" int
        |> required "cached" bool
        |> required "height" int
        |> required "row" int
        |> required "column" int


indicatorInfoDecoder : Decoder IndicatorInfo
indicatorInfoDecoder =
    succeed IndicatorInfo
        |> required "checkurl" (nullable string)
        |> optional "details" indicatorDetailsDecoder Empty
        |> required "numChecks" int
        |> required "popOver" popoverDecoder


popoverDecoder : Decoder Popover
popoverDecoder =
    succeed Popover
        |> required "title" (nullable string)
        |> required "status" (nullable string)
        |> required "text" (nullable string)


toDetail : Int -> String -> String -> Dict String IndicatorDetailInfo -> IndicatorDetail
toDetail checks health status indicators =
    Detail { checks = checks, health = health, status = status, indicators = indicators }


indicatorDetailsDecoder : Decoder IndicatorDetail
indicatorDetailsDecoder =
    decode toDetail
        |> required "checks" int
        |> required "health" string
        |> required "status" string
        |> required "indicators" (dict indicatorDetailInfoDecoder)


indicatorDetailInfoDecoder : Decoder IndicatorDetailInfo
indicatorDetailInfoDecoder =
    succeed IndicatorDetailInfo
        |> optional "arrow_value" (nullable float) Nothing
        |> required "cached" bool
        |> required "checks" int
        |> required "health" string
        |> required "info" detailInfoInfoDecoder
        |> optional "lastWeek" (nullable int) Nothing
        |> optional "middle" (nullable int) Nothing
        |> required "muted" bool
        |> required "name" string
        |> required "parent" (nullable string)
        |> optional "percent_change" (nullable float) Nothing
        |> optional "percent_change_yesterday" (nullable float) Nothing
        |> required "status" string
        |> required "time" int
        |> optional "today" (nullable int) Nothing
        |> optional "yesterday" (nullable int) Nothing


detailInfoInfoDecoder : Decoder IndicatorDetailInfoInfo
detailInfoInfoDecoder =
    decode IndicatorDetailInfoInfo
        |> required "checkurl" (nullable string)
        |> required "popOver" popoverDecoder
        |> required "numChecks" int
