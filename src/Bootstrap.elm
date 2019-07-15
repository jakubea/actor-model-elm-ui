module Bootstrap exposing (Model(..), actors, applyModel, spawn)

import Actor.Header as Header
import Actor.Service as Service
import ActorName
import Msg
import Webbhuset.ActorSystem as ActorSystem


type Model
    = Header Header.Model
    | Service Service.Model


actors =
    { header = Header.actor Header
    , service = Service.actor Service
    }


spawn actor =
    case actor of
        ActorName.Header ->
            actors.header.init

        ActorName.Service ->
            actors.service.init


applyModel model =
    case model of
        Header m ->
            ActorSystem.applyModel actors.header m

        Service m ->
            ActorSystem.applyModel actors.service m
