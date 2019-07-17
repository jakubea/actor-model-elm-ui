module Msg exposing (AppMsg(..), Msg)

import ActorName exposing (ActorName)
import Component.Cart as Cart
import Component.Header as Header
import Component.Product as Product
import Component.ProductList as ProductList
import Webbhuset.ActorSystem as ActorSystem


type alias Msg =
    ActorSystem.SysMsg ActorName AppMsg


type AppMsg
    = Header Header.MsgIn
    | Product Product.MsgIn
    | ProductList ProductList.MsgIn
    | Cart Cart.MsgIn
