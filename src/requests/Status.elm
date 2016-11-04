module Requests.Status exposing (..)

import Models exposing (SiteStatus)
import Parsers.Status as Parser
import Http exposing (Error, url)
import Task exposing (Task)


statusUrl : String
statusUrl =
    "http://localhost:5000/response.json"


fetchStatus : Task Error SiteStatus
fetchStatus =
    Http.get Parser.siteStatusDecoder statusUrl
