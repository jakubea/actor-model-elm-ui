module Msg exposing (AppMsg(..), Msg)

import ActorName exposing (ActorName)
import Component.Header as Header
import Component.Product as Product
import Component.ProductList as ProductList
import Component.Service as Service
import Webbhuset.ActorSystem as ActorSystem


type alias Msg =
    ActorSystem.SysMsg ActorName AppMsg


type AppMsg
    = Header Header.MsgIn
    | Product Product.MsgIn
    | Service Service.MsgIn
    | ProductList ProductList.MsgIn
