module Actor.ProductList exposing (Model, actor, mapIn, mapOut)

import Component.ProductList as ProductList
import Msg exposing (Msg)
import Webbhuset.ActorSystem as System
import Webbhuset.ElmUI.Actor as Actor exposing (Actor)
import Webbhuset.PID exposing (PID)


type alias Model =
    ProductList.Model


actor : (ProductList.Model -> appModel) -> Actor Model appModel Msg
actor toAppModel =
    Actor.fromLayout
        { wrapModel = toAppModel
        , wrapMsg = Msg.ProductList
        , mapIn = mapIn
        , mapOut = mapOut
        }
        ProductList.component


mapIn : Msg.AppMsg -> Maybe ProductList.MsgIn
mapIn appMsg =
    case appMsg of
        Msg.ProductList msgIn ->
            Just msgIn

        _ ->
            Nothing


mapOut : PID -> ProductList.MsgOut -> Msg
mapOut pid msgOut =
    System.none
