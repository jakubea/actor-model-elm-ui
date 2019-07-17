module Actor.Product exposing (Model, actor, mapIn, mapOut)

import ActorName
import Component.Cart as Cart
import Component.Product as Product
import Component.ProductList as ProductList
import Msg exposing (Msg)
import Webbhuset.ActorSystem as System
import Webbhuset.ElmUI.Actor as Actor exposing (Actor)
import Webbhuset.PID exposing (PID)


type alias Model =
    Product.Model


actor : (Product.Model -> appModel) -> Actor Model appModel Msg
actor toAppModel =
    Actor.fromUI
        { wrapModel = toAppModel
        , wrapMsg = Msg.Product
        , mapIn = mapIn
        , mapOut = mapOut
        }
        Product.component


mapIn : Msg.AppMsg -> Maybe Product.MsgIn
mapIn appMsg =
    case appMsg of
        Msg.Product msgIn ->
            Just msgIn

        _ ->
            Nothing


mapOut : PID -> Product.MsgOut -> Msg
mapOut pid msgOut =
    case msgOut of
        Product.SendToProductList ->
            System.sendToSingleton ActorName.ProductList
                (Msg.ProductList <| ProductList.GotProduct pid)

        Product.SendToCart { id, name, price } ->
            System.sendToSingleton ActorName.Cart
                (Msg.Cart <| Cart.GotCartItem { id = id, name = name, price = price })
