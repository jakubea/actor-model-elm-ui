module Component.ProductList exposing
    ( Model
    , MsgIn(..)
    , MsgOut(..)
    , component
    )

import Element exposing (Element)
import Element.Background
import Element.Font
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Webbhuset.ElmUI.Component as Component exposing (PID)


type MsgIn
    = GotProduct PID


type MsgOut
    = NoOut


type alias Model =
    { pid : PID
    , products : List PID
    }


component : Component.Layout Model MsgIn MsgOut msg
component =
    { init = init
    , update = update
    , view = view
    , onSystem = always SystemEvent.default
    , subs = subs
    }


init : PID -> ( Model, List MsgOut, Cmd MsgIn )
init pid =
    ( { pid = pid
      , products = []
      }
    , []
    , Cmd.none
    )


kill : Model -> List MsgOut
kill model =
    []


subs : Model -> Sub MsgIn
subs model =
    Sub.none


update : MsgIn -> Model -> ( Model, List MsgOut, Cmd MsgIn )
update msgIn model =
    case msgIn of
        GotProduct pid ->
            ( { model | products = model.products ++ [ pid ] }
            , []
            , Cmd.none
            )


view : (MsgIn -> msg) -> Model -> (PID -> Element msg) -> Element msg
view toSelf { products } renderPID =
    products
        |> List.map renderPID
        |> Element.column
            [ Element.Background.color <| Element.rgb255 227 232 237
            , Element.width Element.fill
            , Element.Font.color <| Element.rgb255 53 74 94
            ]
