module Component.ProductList exposing
    ( Model
    , MsgIn(..)
    , MsgOut(..)
    , component
    )

import Element exposing (Element)
import Element.Background
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Webbhuset.ElmUI.Component as Component exposing (PID)


type MsgIn
    = NoIn
    | ClickedOnProduct PID
    | GotProduct PID


type MsgOut
    = NoOut


type alias Model =
    { pid : PID
    , children : List PID
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
      , children = []
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
        NoIn ->
            ( model
            , []
            , Cmd.none
            )

        GotProduct pid ->
            ( { model | children = model.children ++ [ pid ] }
            , []
            , Cmd.none
            )

        ClickedOnProduct pid ->
            ( model
            , []
            , Cmd.none
            )


view : (MsgIn -> msg) -> Model -> (PID -> Element msg) -> Element msg
view toSelf model renderPID =
    Element.column
        []
        [ Element.el [] (Element.text "Layout Component")
        , model.children
            |> List.map renderPID
            |> Element.column
                [ Element.Background.color <| Element.rgb255 172 184 196
                ]
        ]
