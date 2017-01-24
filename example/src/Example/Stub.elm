module Example.Stub exposing (main, stub)

import CQRS exposing (..)
import Html exposing (div)
import Html.Attributes as Attr
import Css exposing (..)

--

import Example.Model exposing (..)
import Example.Update as Example
import Example.View as Example

import LogInForm.Stub as LogInForm
import SignUpForm.Stub as SignUpForm

--

-- import Cognito as Cognito
import CognitoPorts as CognitoPorts


--


styles : List Mixin -> Html.Attribute msg
styles =
    asPairs >> Attr.style

main : Program Context Model Command
main =
    program stub

--

stub : Definition Context Model Command Event Effect
stub =
    { decode = Example.decode
    , encode = Example.encode
    , init = (\model -> Example.init <| validationErrors model)
    , view = (\model -> Example.view model |> view)
    , commandMap = Example.commandMap
    , eventMap = Example.eventMap
    , eventHandler = eventHandler
    , subscriptions = subscriptions
    }

view : Html.Html command -> Html.Html command
view child =
    div
        [ styles
            [ backgroundColor (hex "#EEE")
            , property "width" "calc(100vw - 150px)"
            , property "height" "calc(100vh - 150px)"
            , minWidth (px 800)
            , minHeight (px 600)
            , marginLeft (px 25)
            , marginTop (px 25)
            , padding (px 50)
            , overflow scroll
            ]
        ]
        [ child
        ]

eventHandler : ( Model, Effect ) -> Cmd msg
eventHandler ( model, effect ) =
    case Debug.log "Example eventHandler" effect of
        _ ->
            CognitoPorts.cmd_AsheWorks_ElmCognito_LogIn 
                { username = "asdf"
                , password = "asdf"
                }


subscriptions : Model -> Sub Command
subscriptions model =
    Sub.batch []


init : Model -> ( Model, Maybe Effect )
init model =
    Example.init <| validationErrors model

validationErrors : Model -> Model
validationErrors model =
    { model | logInForm = stateMap LogInForm.validationErrors model.logInForm
            , signUpForm = stateMap SignUpForm.populatedUsernameAndPassword model.signUpForm
    }

-- DoLogIn username password ->
--     PortsAuth.auth_LogIn
--         { username = username
--         , password = password
--         }
--
--
--
-- [ PortsAuth.auth_LogInError LogInError
-- , PortsAuth.auth_LogInSuccess LogInSuccess
-- ]
