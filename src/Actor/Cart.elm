module Actor.Cart exposing (Model, actor, mapIn, mapOut)

import ActorName
import Component.Cart as Cart
import Component.Header as Header
import Msg as Msg exposing (Msg)
import Webbhuset.ActorSystem as System
import Webbhuset.ElmUI.Actor as Actor exposing (Actor)
import Webbhuset.PID exposing (PID)


type alias Model =
    Cart.Model


actor : (Cart.Model -> appModel) -> Actor Model appModel Msg
actor toAppModel =
    Actor.fromUI
        { wrapModel = toAppModel
        , wrapMsg = Msg.Cart
        , mapIn = mapIn
        , mapOut = mapOut
        }
        Cart.component


mapIn : Msg.AppMsg -> Maybe Cart.MsgIn
mapIn appMsg =
    case appMsg of
        Msg.Cart msgIn ->
            Just msgIn

        _ ->
            Nothing


mapOut : PID -> Cart.MsgOut -> Msg
mapOut pid (Cart.UpdateTotalPrice price) =
    System.sendToSingleton ActorName.Header (Msg.Header <| Header.UpdatedTotalPrice price)
