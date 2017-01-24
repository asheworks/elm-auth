module LogInForm.Stub exposing (..)

import CQRS exposing (..)

--

import LogInForm.Model exposing (..)
import LogInForm.Update as LogInForm
import LogInForm.View as LogInForm


-- Ports

-- import PortsAuth as PortsAuth


--

-- , init = LogInForm.init

main : Program Context Model Command
main =
    program
        { decode = LogInForm.decode
        , encode = LogInForm.encode
        , init = init
        , view = LogInForm.view
        , commandMap = LogInForm.commandMap
        , eventMap = LogInForm.eventMap
        , eventHandler = eventHandler
        , subscriptions = subscriptions
        }

-- PortsAuth.auth_LogIn
--     { username = username
--     , password = password
--     }

eventHandler : ( Model, Effect ) -> Cmd Command
eventHandler ( model, effect ) =
    case Debug.log "LogInForm Effect" effect of
        DoLogIn username password ->
            Cmd.none
        
        ShowSignUp ->
            Cmd.none
        
        ShowForgotPassword ->
            Cmd.none


subscriptions : Model -> Sub Command
subscriptions model =
    Sub.batch
        [
        ]

--

init : Model -> ( Model, Maybe Effect )
init model =
    LogInForm.init <| validationErrors model


populatedUsernameAndPassword : Model -> Model
populatedUsernameAndPassword model =
    { model | username = "test0001"
            , password = "P@ssw0rd"
            , logInError = Nothing
    }

validationErrors : Model -> Model
validationErrors model =
    { model | username = ""
            , usernameError = Just "User name is required"
            , password = ""
            , passwordError = Just "Password is required"
            , logInError = Nothing
    }

generalError : Model -> Model
generalError model =
    { model | username = ""
            , password = ""
            , logInError = Just "Invalid Email"
    }
