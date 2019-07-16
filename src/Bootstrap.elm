module Bootstrap exposing (Model(..), actors, applyModel, spawn)

import Actor.Header as Header
import Actor.Product as Product
import Actor.ProductList as ProductList
import Actor.Service as Service
import ActorName
import Msg
import Webbhuset.ActorSystem as ActorSystem


type Model
    = Header Header.Model
    | Service Service.Model
    | Product Product.Model
    | ProductList ProductList.Model


actors =
    { header = Header.actor Header
    , product = Product.actor Product
    , productList = ProductList.actor ProductList
    , service = Service.actor Service
    }


spawn actor =
    case actor of
        ActorName.Header ->
            actors.header.init

        ActorName.Service ->
            actors.service.init

        ActorName.Product ->
            actors.product.init

        ActorName.ProductList ->
            actors.productList.init


applyModel model =
    case model of
        Header m ->
            ActorSystem.applyModel actors.header m

        Service m ->
            ActorSystem.applyModel actors.service m

        Product m ->
            ActorSystem.applyModel actors.product m

        ProductList m ->
            ActorSystem.applyModel actors.productList m
