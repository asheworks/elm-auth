module PasswordChallengeForm.Stub exposing (..)

import CQRS exposing (..)
import Html exposing (..)
import UI as UI


--

import PasswordChallengeForm.Model exposing (..)
import PasswordChallengeForm.Update as PasswordChallengeForm
import PasswordChallengeForm.View as PasswordChallengeForm


--


main : Program Context Model Command
main =
    CQRS.program
        { decode = PasswordChallengeForm.decode
        , encode = PasswordChallengeForm.encode
        , init = init
        , view = view
        , commandMap = PasswordChallengeForm.commandMap
        , eventMap = PasswordChallengeForm.eventMap
        , eventHandler = eventHandler
        , subscriptions = subscriptions
        }


eventHandler : ( Model, Effect ) -> Cmd Command
eventHandler ( model, effect ) =
    case Debug.log "PasswordChallengeForm Stub - EventHandler" effect of
        DoConfirmPassword password ->
            Cmd.none


subscriptions : Model -> Sub Command
subscriptions model =
    Sub.batch []


init : Model -> ( Model, Maybe Effect )
init model =
    PasswordChallengeForm.init <| validationErrors model


view : Model -> Html Command
view model =
    UI.formControl
        { id = "auth-form"
        , header =
            Just
                [ Html.text "RESET PASSWORD"
                ]
        , section = Just <| PasswordChallengeForm.view model
        , aside = Nothing
        , footer = Nothing
        }


populatedPassword : Model -> Model
populatedPassword model =
    { model
        | username = "Joe@gmail.com"
        , password = "P@ssw0rd"
        , newPassword = "P@ssw0rd"
    }


validationErrors : Model -> Model
validationErrors model =
    { model
        | newPassword = ""
        , newPasswordError = Just "Password is required"
        , error = Nothing
    }


generalError : Model -> Model
generalError model =
    { model
        | error = Just "Invalid Email"
    }
