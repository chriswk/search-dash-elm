module Parsers.Status exposing (..)

import Json.Decode.Pipeline exposing (required, decode, optional, nullable)
import Json.Decode exposing (Decoder, andThen, decodeValue, dict, succeed, string, (:=), float, map, at, list, int, bool, maybe, oneOf, null)
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


indicatorInfoDecoder : Decoder IndicatorInfo
indicatorInfoDecoder =
    succeed IndicatorInfo
        |> required "details" (nullable indicatorDetailsDecoder)
        |> required "checkurl" (nullable string)
        |> required "popOver" popoverDecoder
        |> required "numChecks" int


popoverDecoder : Decoder Popover
popoverDecoder =
    succeed Popover
        |> required "title" (nullable string)
        |> required "status" (nullable string)
        |> required "text" (nullable string)


indicatorDetailsDecoder : Decoder IndicatorDetail
indicatorDetailsDecoder =
    succeed IndicatorDetail
        |> required "status" string
        |> required "health" string
        |> required "indicators" (dict indicatorDetailInfoDecoder)
        |> required "checks" int


indicatorDetailInfoDecoder : Decoder IndicatorDetailInfo
indicatorDetailInfoDecoder =
    succeed IndicatorDetailInfo
        |> required "status" string
        |> required "health" string
        |> required "name" string
        |> required "time" int
        |> required "checks" int
        |> required "parent" (nullable string)
        |> required "cached" bool
        |> required "muted" bool
