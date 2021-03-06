module SignUpForm.Stub exposing (..)

import CQRS exposing (..)
import Navigation as Navigation
import Html exposing (..)
import UI as UI


--

import SignUpForm.Model exposing (..)
import SignUpForm.Update as SignUpForm
import SignUpForm.View as SignUpForm


--


main : Program Context Model Command
main =
    CQRS.program
        { decode = SignUpForm.decode
        , encode = SignUpForm.encode
        , init = init
        , view = view
        , commandMap = SignUpForm.commandMap
        , eventMap = SignUpForm.eventMap
        , eventHandler = eventHandler
        , subscriptions = subscriptions
        }


eventHandler : ( Model, Effect ) -> Cmd Command
eventHandler ( model, effect ) =
    case Debug.log "SignUpForm Stub - EventHandler" effect of
        DoSignUp username password ->
            Cmd.none


subscriptions : Model -> Sub Command
subscriptions model =
    Sub.batch []


init : Model -> ( Model, Maybe Effect )
init model =
    SignUpForm.init <| validationErrors model


view : Model -> Html Command
view model =
    UI.formControl
        { id = "auth-form"
        , header =
            Just
                [ Html.text "SIGN UP"
                ]
        , section = Just <| SignUpForm.view model
        , aside = Nothing
        , footer = Nothing
        }


populatedUsernameAndPassword : Model -> Model
populatedUsernameAndPassword model =
    { model
        | username = "test0001"
        , password = "P@ssw0rd"
    }


validationErrors : Model -> Model
validationErrors model =
    { model
        | username = ""
        , usernameError = Just "User name is required"
        , password = ""
        , passwordError = Just "Password is required"
        , error = Nothing
    }


generalError : Model -> Model
generalError model =
    { model
        | error = Just "Invalid Email"
    }
