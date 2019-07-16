module Component.Product exposing
    ( Model
    , MsgIn(..)
    , MsgOut(..)
    , component
    )

import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Font
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Webbhuset.ElmUI.Component as Component exposing (PID)


type MsgIn
    = NoIn


type MsgOut
    = NoOut
    | SendToProductList


type alias Model =
    { pid : PID
    , name : String
    , price : Float
    }


component : Component.UI Model MsgIn MsgOut
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
      , name = "name"
      , price = 99
      }
    , [ SendToProductList ]
    , Cmd.none
    )


subs : Model -> Sub MsgIn
subs model =
    Sub.none


update : MsgIn -> Model -> ( Model, List MsgOut, Cmd MsgIn )
update msgIn model =
    case msgIn of
        NoIn ->
            ( model
            , []
            , Cmd.none
            )


view : Model -> Element MsgIn
view { name } =
    Element.row
        [ Element.padding 10
        , Element.centerY
        , Element.Border.widthXY 0 2
        , Element.Border.color <| Element.rgb255 53 74 94
        ]
        [ Element.text name
        ]
