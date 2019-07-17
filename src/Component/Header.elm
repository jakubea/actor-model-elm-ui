module Component.Header exposing
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
    = UpdatedTotalPrice Float


type MsgOut
    = NoOut


type alias Model =
    { pid : PID
    , totalPrice : Float
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
      , totalPrice = 0
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
        UpdatedTotalPrice totalPrice ->
            ( { model | totalPrice = totalPrice }
            , []
            , Cmd.none
            )


view : Model -> Element MsgIn
view { totalPrice } =
    let
        totalPriceView =
            Element.column []
                [ Element.text "Total price:"
                , Element.el
                    [ Element.alignRight
                    , Element.Font.bold
                    , Element.paddingXY 0 5
                    ]
                  <|
                    Element.text <|
                        String.fromFloat totalPrice
                ]
    in
    Element.row
        [ Element.width Element.fill
        , Element.padding 10
        , Element.centerY
        , Element.height <| Element.px 80
        , Element.Background.color <| Element.rgb255 172 184 196
        , Element.Border.widthXY 0 2
        , Element.Border.color <| Element.rgb255 53 74 94
        , Element.Font.color <| Element.rgb255 53 74 94
        ]
        [ Element.image
            [ Element.width <| Element.px 30
            , Element.height <| Element.px 30
            , Element.alignLeft
            ]
            { src = "http://localhost:3000/logo.svg"
            , description = ""
            }
        , Element.el
            [ Element.centerX
            ]
          <|
            Element.text "E-shop"
        , Element.el [ Element.alignRight ] <|
            totalPriceView
        ]
