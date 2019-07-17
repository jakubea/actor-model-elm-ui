module Component.Cart exposing
    ( Model
    , MsgIn(..)
    , MsgOut(..)
    , component
    )

import Element exposing (Element)
import Element.Background
import Element.Font
import Element.Input
import List.Extra
import Webbhuset.Component.SystemEvent as SystemEvent exposing (SystemEvent)
import Webbhuset.ElmUI.Component as Component exposing (PID)


type MsgIn
    = NoIn
    | GotCartItem CartItem
    | ClickedRemove Int


type MsgOut
    = NoOut
    | UpdateTotalPrice Float


type alias CartItem =
    { id : Int
    , name : String
    , price : Float
    }


type alias Model =
    { pid : PID
    , cartItems : List CartItem
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
      , cartItems = []
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

        GotCartItem cartItem ->
            let
                updatedModel =
                    { model
                        | cartItems = model.cartItems ++ [ cartItem ]
                    }
            in
            ( updatedModel
            , [ UpdateTotalPrice <| totalPrice updatedModel.cartItems ]
            , Cmd.none
            )

        ClickedRemove index ->
            let
                updatedModel =
                    { model | cartItems = List.Extra.removeAt index model.cartItems }
            in
            ( updatedModel
            , [ UpdateTotalPrice <| totalPrice updatedModel.cartItems ]
            , Cmd.none
            )


totalPrice : List CartItem -> Float
totalPrice =
    List.map .price >> List.sum


view : Model -> Element MsgIn
view { cartItems } =
    if List.isEmpty cartItems then
        Element.none

    else
        Element.column
            [ Element.Font.color <| Element.rgb255 53 74 94
            , Element.width <| Element.maximum 300 Element.fill
            , Element.centerX
            , Element.Font.size 12
            ]
        <|
            (Element.el
                [ Element.centerX
                , Element.padding 10
                , Element.Font.size 16
                ]
             <|
                Element.text "Shopping cart"
            )
                :: List.indexedMap cartItemView cartItems


cartItemView : Int -> CartItem -> Element MsgIn
cartItemView index { name, price } =
    Element.row
        [ Element.width Element.fill
        , Element.spaceEvenly
        , Element.padding 10
        ]
        [ Element.text name
        , Element.text <| String.fromFloat price ++ ",-"
        , Element.Input.button
            [ Element.Font.size 10
            , Element.Background.color <| Element.rgb255 53 74 94
            , Element.Font.color <| Element.rgb255 227 232 237
            , Element.padding 5
            ]
            { onPress = Just <| ClickedRemove index
            , label = Element.text "X"
            }
        ]
