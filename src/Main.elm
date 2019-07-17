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
    [ System.withSingletonPID ActorName.Cart System.addView
    , newProduct 1 "Product 1" 22
    , newProduct 2 "Product 2" 365
    , newProduct 3 "Product 3" 11
    , newProduct 4 "Product 4" 3675
    , newProduct 5 "Product 5" 186
    , System.withSingletonPID ActorName.ProductList System.addView
    , System.withSingletonPID ActorName.Header System.addView
    ]
        |> System.batch


newProduct : Int -> String -> Float -> Msg
newProduct id name price =
    System.spawn ActorName.Product
        (\pid ->
            Product.SetProduct { id = id, name = name, price = price, pid = pid }
                |> Msg.Product
                |> System.sendToPID pid
        )


view : List (Element Msg) -> Html Msg
view =
    Element.column
        [ Element.width <| Element.maximum 800 Element.fill
        , Element.centerX
        ]
        >> Element.layout []
