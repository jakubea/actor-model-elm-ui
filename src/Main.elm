module Main exposing (Model, init, main, view)

import ActorName exposing (ActorName)
import Bootstrap
import Component.Product as Product
import Component.ProductList as ProductList
import Element exposing (Element)
import Html exposing (Html)
import Msg exposing (Msg)
import Webbhuset.ActorSystem as System


type alias Model =
    System.Model ActorName Bootstrap.Model


main : Program () Model Msg
main =
    System.element
        { spawn = Bootstrap.spawn
        , apply = Bootstrap.applyModel
        , init = init
        , view = view
        , onDebug =
            \error ->
                Debug.log "error" error
                    |> always System.none
        }


init : () -> Msg
init flags =
    [ newProduct "product 1" 22
    , newProduct "product 2" 365
    , newProduct "product 3" 11
    , newProduct "product 4" 3675
    , newProduct "product 5" 186
    , newProduct "product 6" 577
    , newProduct "product 7" 36555
    , System.withSingletonPID ActorName.ProductList System.addView
    , System.withSingletonPID ActorName.Header System.addView
    ]
        |> System.batch


newProduct : String -> Float -> Msg
newProduct name price =
    System.spawn ActorName.Product
        (\pid ->
            System.sendToPID pid
                (Msg.Product <|
                    Product.SetProduct { name = name, price = price, pid = pid }
                )
        )


view : List (Element Msg) -> Html Msg
view actorOutput =
    Element.column
        [ Element.width Element.fill
        ]
        actorOutput
        |> Element.layout []
