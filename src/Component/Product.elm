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
    = SetProduct Product
    | ClickedAddToCart


type MsgOut
    = SendToProductList
    | SendToCart Product


type Model
    = NotReady
    | Ready Product


type alias Product =
    { pid : PID
    , id : Int
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
    ( NotReady
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
            ( Ready newModel
            , [ SendToProductList ]
            , Cmd.none
            )

        ClickedAddToCart ->
            ( model
            , case model of
                Ready product ->
                    [ SendToCart product ]

                NotReady ->
                    []
            , Cmd.none
            )


view : Model -> Element MsgIn
view model =
    case model of
        Ready { name, price } ->
            Element.row
                [ Element.padding 10
                , Element.centerY
                , Element.Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                , Element.Border.color <| Element.rgb255 53 74 94
                , Element.Border.dashed
                , Element.width <| Element.fill
                ]
                [ Element.text name
                , Element.el
                    [ Element.alignRight
                    , Element.paddingXY 30 0
                    ]
                  <|
                    Element.text <|
                        String.fromFloat price
                            ++ ",-"
                , addButtonView
                ]

        NotReady ->
            Element.none


addButtonView : Element MsgIn
addButtonView =
    Element.Input.button
        [ Element.Font.size 10
        , Element.Background.color <| Element.rgb255 53 74 94
        , Element.Font.color <| Element.rgb255 227 232 237
        , Element.padding 10
        , Element.Border.rounded 5
        , Element.Border.width 2
        , Element.Border.color <| Element.rgb255 255 255 255
        , Element.alignRight
        ]
        { onPress = Just ClickedAddToCart
        , label = Element.text "ADD TO CART"
        }
