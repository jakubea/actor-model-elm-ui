module Actor.Service exposing (Model, actor, mapIn, mapOut)

import ActorName
import Component.Service as Service
import Msg exposing (Msg)
import Webbhuset.ActorSystem as ActorSystem
import Webbhuset.ElmUI.Actor as Actor exposing (Actor)
import Webbhuset.PID as PID exposing (PID)


type alias Model =
    Service.Model


actor : (Service.Model -> appModel) -> Actor Model appModel Msg
actor toAppModel =
    Actor.fromService
        { wrapModel = toAppModel
        , wrapMsg = Msg.Service
        , mapIn = mapIn
        , mapOut = mapOut
        }
        (Service.component ())


mapIn : Msg.AppMsg -> Maybe Service.MsgIn
mapIn appMsg =
    case appMsg of
        Msg.Service msgIn ->
            Just msgIn

        _ ->
            Nothing


mapOut : PID -> Service.MsgOut -> Msg
mapOut self msgOut =
    case msgOut of
        Service.Init ->
            ActorSystem.none
