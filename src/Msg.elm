module Msg exposing (AppMsg(..), Msg)

import ActorName exposing (ActorName)
import Component.Header as Header
import Component.Service as Service
import Webbhuset.ActorSystem as ActorSystem


type alias Msg =
    ActorSystem.SysMsg ActorName AppMsg


type AppMsg
    = Header Header.MsgIn
    | Service Service.MsgIn
    | Dummy
