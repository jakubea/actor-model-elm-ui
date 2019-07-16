module Main exposing (Model, init, main, view)

import ActorName exposing (ActorName)
import Bootstrap
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
    [ System.withSingletonPID ActorName.Header System.addView

    -- , System.spawn ActorName.Product (\pid -> System.sendToSingleton ActorName.ProductList (Msg.ProductList <| ProductList.GotProduct pid))
    , System.spawnSingleton ActorName.Product
    , System.spawnSingleton ActorName.Product
    , System.spawnSingleton ActorName.Product
    , System.withSingletonPID ActorName.ProductList System.addView
    , System.spawnSingleton ActorName.Service
    ]
        |> System.batch


view : List (Element Msg) -> Html Msg
view actorOutput =
    Element.column
        [ Element.width Element.fill
        ]
        actorOutput
        |> Element.layout []
