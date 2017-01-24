module SignUpForm.Stub exposing (..)

import CQRS exposing (..)
import Navigation as Navigation

--

import SignUpForm.Model exposing (..)
import SignUpForm.Update as SignUpForm
import SignUpForm.View as SignUpForm

--

-- import PortsAuth as PortsAuth

--


main : Program Context Model Command
main =
    program
        { decode = SignUpForm.decode
        , encode = SignUpForm.encode
        , init = init
        , view = SignUpForm.view
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
        --     PortsAuth.auth_SignUp
        --         { username = username
        --         , password = password
        --         }

        ShowConfirm username ->
            Navigation.newUrl "#confirm"
        
        ShowLogIn ->
            Navigation.newUrl "#login"

        -- _ ->
        --     Cmd.none


subscriptions : Model -> Sub Command
subscriptions model =
    Sub.batch []

        -- [ PortsAuth.auth_SignUpError SignUpError
        -- , PortsAuth.auth_SignUpSuccess SignUpSuccess
        -- ]


init : Model -> ( Model, Maybe Effect )
init model =
    SignUpForm.init <| validationErrors model

populatedUsernameAndPassword : Model -> Model
populatedUsernameAndPassword model =
    { model | username = "test0001"
            , password = "P@ssw0rd"
    }

validationErrors : Model -> Model
validationErrors model =
    { model | username = ""
            , usernameError = Just "User name is required"
            , password = ""
            , passwordError = Just "Password is required"
    }

generalError : Model -> Model
generalError model =
    { model | signUpError = Just "Invalid Email"
    }