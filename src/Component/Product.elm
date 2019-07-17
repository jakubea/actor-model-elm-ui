module Component.Product exposing
    ( Model
    , MsgIn(..)
    , MsgOut(..)
    , component
    )

import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Events
import Element.Font
import Element.Input
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Webbhuset.ElmUI.Component as Component exposing (PID)


type MsgIn
    = NoIn
    | SetProduct Model
    | ClickedOnProduct


type MsgOut
    = NoOut
    | SendToProductList
    | IncreaseTotalPrice Float


type alias Model =
    { pid : PID
    , name : String
    , price : Float
    }


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
      , name = ""
      , price = 0
      }
    , []
    , Cmd.none
    )


subs : Model -> Sub MsgIn
subs model =
    Sub.none


update : MsgIn -> Model -> ( Model, List MsgOut, Cmd MsgIn )
update msgIn model =
    case msgIn of
        SetProduct newModel ->
            ( newModel
            , [ SendToProductList ]
            , Cmd.none
            )

        ClickedOnProduct ->
            ( model, [ IncreaseTotalPrice model.price ], Cmd.none )

        NoIn ->
            ( model
            , []
            , Cmd.none
            )


view : Model -> Element MsgIn
view { name, price } =
    Element.row
        [ Element.padding 10
        , Element.centerY
        , Element.Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , Element.Border.color <| Element.rgb255 53 74 94
        , Element.Border.dashed
        , Element.Events.onClick ClickedOnProduct
        , Element.width <| Element.fill
        ]
        [ Element.el [ Element.width <| Element.fillPortion 1 ] <| Element.text name
        , Element.el [ Element.width <| Element.fillPortion 1 ] <| Element.text <| String.fromFloat price
        , Element.Input.button [ Element.Font.size 10 ]
            { onPress = Just ClickedOnProduct, label = Element.text "ADD TO CART" }
        ]
