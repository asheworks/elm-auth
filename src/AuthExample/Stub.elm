module AuthExample.Stub exposing (main, stub)

import CQRS exposing (..)
import Html exposing (div)
import Html.Attributes as Attr
import Css exposing (..)

--

import Auth as Auth
import CognitoPorts as CognitoPorts

--

import AuthExample.Model exposing (..)
import AuthExample.Update as Example
import AuthExample.View as Example

--

import LogInForm.Model as LogInForm
import LogInForm.Stub as LogInForm
import PasswordChallengeForm.Model as PasswordChallengeForm
import PasswordChallengeForm.Stub as PasswordChallengeForm
import SignUpForm.Model as SignUpForm
import SignUpForm.Stub as SignUpForm

--

styles : List Mixin -> Html.Attribute msg
styles =
    asPairs >> Attr.style

main : Program Context Model Command
main =
    program stub

--

-- , init = (\model -> Example.init <| model)

stub : Definition Context Model Command Event Effect
stub =
    { decode = Example.decode
    , encode = Example.encode
    , init = init
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
        Auth_Effect effect_ ->
            CognitoPorts.effects ( model.auth.state, effect_ )


subscriptions : Model -> Sub Command
subscriptions model =
    CognitoPorts.subscriptions Auth_Command


initLogIn : State LogInForm.Model -> State LogInForm.Model
initLogIn model =
    State <| LogInForm.populatedUsernameAndPassword model.state


initPasswordChallenge : State PasswordChallengeForm.Model -> State PasswordChallengeForm.Model
initPasswordChallenge model =
    State <| PasswordChallengeForm.populatedPassword model.state


initSignUp : State SignUpForm.Model -> State SignUpForm.Model
initSignUp model =
    State <| SignUpForm.populatedUsernameAndPassword model.state


initAuth : Auth.Model -> Auth.Model
initAuth model =
    { model
        | logInForm = initLogIn model.logInForm
        , passwordChallengeForm = initPasswordChallenge model.passwordChallengeForm
        , signUpForm = initSignUp model.signUpForm
    }

init : Model -> ( Model, Maybe Effect )
init model =
    Example.init <| { model
        | auth = State <| initAuth model.auth.state
        }
