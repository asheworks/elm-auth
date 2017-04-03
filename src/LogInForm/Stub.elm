module LogInForm.Stub exposing (..)

import CQRS exposing (..)
import Html exposing (..)
import UI as UI


--

import LogInForm.Model exposing (..)
import LogInForm.Update as LogInForm
import LogInForm.View as LogInForm


--
-- , view = LogInForm.view


main : Program Context Model Command
main =
    CQRS.program
        { decode = LogInForm.decode
        , encode = LogInForm.encode
        , init = init
        , view = view
        , commandMap = LogInForm.commandMap
        , eventMap = LogInForm.eventMap
        , eventHandler = eventHandler
        , subscriptions = subscriptions
        }


eventHandler : ( Model, Effect ) -> Cmd Command
eventHandler ( model, effect ) =
    case Debug.log "LogInForm Effect" effect of
        DoLogIn username password ->
            Cmd.none


subscriptions : Model -> Sub Command
subscriptions model =
    Sub.batch []


init : Model -> ( Model, Maybe Effect )
init model =
    LogInForm.init <| validationErrors model


view : Model -> Html Command
view model =
    UI.formControl
        { id = "auth-form"
        , header =
            Just
                [ Html.text "LOG IN"
                ]
        , section = Just <| LogInForm.view model
        , aside = Nothing
        , footer = Nothing
        }


populatedUsernameAndPassword : Model -> Model
populatedUsernameAndPassword model =
    { model
        | username = "test0001"
        , password = "@Password1"
        , logInError = Nothing
    }


validationErrors : Model -> Model
validationErrors model =
    { model
        | username = ""
        , usernameError = Just "User name is required"
        , password = ""
        , passwordError = Just "Password is required"
        , logInError = Nothing
    }


generalError : Model -> Model
generalError model =
    { model
        | username = ""
        , password = ""
        , newPassword = ""
        , logInError = Just "Invalid Email"
    }
