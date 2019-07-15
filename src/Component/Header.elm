module Component.Header exposing
    ( Model
    , MsgIn(..)
    , MsgOut(..)
    , component
    )

import Element exposing (Element)
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Webbhuset.ElmUI.Component as Component exposing (PID)


type MsgIn
    = NoIn


type MsgOut
    = NoOut


type alias Model =
    { pid : PID }



--
-- Component
--


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
        NoIn ->
            ( model
            , []
            , Cmd.none
            )


view : Model -> Element MsgIn
view model =
    Element.column
        []
        [ Element.text "Empty Component"
        ]
