module Bootstrap exposing (Model(..), actors, applyModel, spawn)

import Actor.Cart as Cart
import Actor.Header as Header
import Actor.Product as Product
import Actor.ProductList as ProductList
import ActorName
import Msg
import Webbhuset.ActorSystem as ActorSystem


type Model
    = Header Header.Model
    | Product Product.Model
    | ProductList ProductList.Model
    | Cart Cart.Model


actors =
    { header = Header.actor Header
    , product = Product.actor Product
    , productList = ProductList.actor ProductList
    , cart = Cart.actor Cart
    }


spawn actor =
    case actor of
        ActorName.Header ->
            actors.header.init

        ActorName.Product ->
            actors.product.init

        ActorName.ProductList ->
            actors.productList.init

        ActorName.Cart ->
            actors.cart.init


applyModel model =
    case model of
        Header m ->
            ActorSystem.applyModel actors.header m

        Product m ->
            ActorSystem.applyModel actors.product m

        ProductList m ->
            ActorSystem.applyModel actors.productList m

        Cart m ->
            ActorSystem.applyModel actors.cart m
