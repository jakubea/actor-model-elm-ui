module Actor.Header exposing (Model, actor, mapIn, mapOut)

import Component.Header as Header
import Msg as Msg exposing (Msg)
import Webbhuset.ActorSystem as System
import Webbhuset.ElmUI.Actor as Actor exposing (Actor)
import Webbhuset.PID exposing (PID)


type alias Model =
    Header.Model


actor : (Header.Model -> appModel) -> Actor Model appModel Msg
actor toAppModel =
    Actor.fromUI
        { wrapModel = toAppModel
        , wrapMsg = Msg.Header
        , mapIn = mapIn
        , mapOut = mapOut
        }
        Header.component


mapIn : Msg.AppMsg -> Maybe Header.MsgIn
mapIn appMsg =
    case appMsg of
        Msg.Header msgIn ->
            Just msgIn

        _ ->
            Nothing


mapOut : PID -> Header.MsgOut -> Msg
mapOut pid msgOut =
    System.none
