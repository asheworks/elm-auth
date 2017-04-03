module Auth
    exposing
        ( Command(..)
        , Event(..)
        , Effect(..)
        , Credentials
        , CredentialsReset
        , Tokens
        , User
        , ContextValues
        , Context
        , Model
        , mapContext
        , mapValues
        , defaultModel
        , commandMap
        , eventMap
        , logInForm
        , passwordChallengeForm
        , signUpForm
        )

{-| This library contains components to interact with authentication providers such as asheworks/elm-cognito

## Models
@docs Credentials, CredentialsReset, Tokens, User

@docs Model

-}

import Html exposing (..)
import CQRS exposing (eventBinder, State)
import LogInForm.Model as LogInForm
import LogInForm.Update as LogInForm
import LogInForm.View as LogInForm
import PasswordChallengeForm.Model as PasswordChallengeForm
import PasswordChallengeForm.Update as PasswordChallengeForm
import PasswordChallengeForm.View as PasswordChallengeForm
import SignUpForm.Model as SignUpForm
import SignUpForm.Update as SignUpForm
import SignUpForm.View as SignUpForm


{-| Credentials

User's log in credentials to the auth provider

-}
type alias Credentials =
    { username : String
    , password : String
    }


{-| CredentialsReset

Pairs log in credentials with a new password to use

-}
type alias CredentialsReset =
    { credentials : Credentials
    , newPassword : Maybe String
    }


{-| Tokens

Provider's reference tokens

-}
type alias Tokens =
    { idToken : String
    , refreshToken : String
    , accessToken : String
    }


{-| User

A user's basic info

-}
type alias User =
    { displayName : String
    , email : String
    }


type alias ContextValues =
    { username : Maybe String
    }


type alias Context =
    Maybe ContextValues


{-| Model

Maintains state for the authentication aspect of an application

user

- If nothing then there is no authenticated user
- If just User then this contains the currently authenticated user

inProgress

- True while a request in in progress

-}
type alias Model =
    { user : Maybe User
    , tokens : Maybe Tokens
    , logInInProgress : Bool
    , logInError : Maybe String
    , logInForm : State LogInForm.Model
    , passwordChallengeInProgress : Bool
    , passwordChallengeForm : State PasswordChallengeForm.Model
    , signUpInProgress : Bool
    , signUpForm : State SignUpForm.Model
    }


type Command
    = LogInForm_Command LogInForm.Command
    | LogInError String
    | LogInFailure String
    | LogInMFARequired String
    | LogInNewPasswordRequired String
    | LogInSuccess Tokens
    | PasswordChallengeForm_Command PasswordChallengeForm.Command
    | PasswordChallengeError String
    | PasswordChallengeFailure String
    | PasswordChallengeSuccess Tokens
    | SignUpForm_Command SignUpForm.Command
    | SignUpError String
    | SignUpFailure String
    | SignUpSuccess String


type Event
    = LogInForm_Event LogInForm.Event
    | LogInErrorReceived String
    | LogInFailureReceived String
    | LogInMFARequiredReceived String
    | LogInNewPasswordRequiredReceived String
    | LogInSuccessReceived Tokens
    | PasswordChallengeForm_Event PasswordChallengeForm.Event
    | PasswordChallengeErrorReceived String
    | PasswordChallengeFailureReceived String
    | PasswordChallengeSuccessReceived Tokens
    | SignUpForm_Event SignUpForm.Event
    | SignUpErrorReceived String
    | SignUpFailureReceived String
    | SignUpSuccessReceived String


type Effect
    = LogInForm_Effect LogInForm.Effect
    | DoLogIn CredentialsReset
    | PasswordChallengeForm_Effect PasswordChallengeForm.Effect
    | DoConfirmPassword CredentialsReset
    | SignUpForm_Effect SignUpForm.Effect
    | DoSignUp Credentials


commandMap : Model -> Command -> Event
commandMap model command =
    let
        t1 =
            Debug.log "Auth Command" command
    in
        case command of
            LogInForm_Command command_ ->
                LogInForm_Event <| LogInForm.commandMap model.logInForm.state command_

            LogInError message ->
                LogInErrorReceived message

            LogInFailure message ->
                LogInFailureReceived message

            LogInMFARequired message ->
                LogInMFARequiredReceived message

            LogInNewPasswordRequired message ->
                LogInNewPasswordRequiredReceived message

            LogInSuccess tokens ->
                LogInSuccessReceived tokens

            PasswordChallengeForm_Command command_ ->
                PasswordChallengeForm_Event <| PasswordChallengeForm.commandMap model.passwordChallengeForm.state command_

            PasswordChallengeError message ->
                PasswordChallengeErrorReceived message

            PasswordChallengeFailure message ->
                PasswordChallengeFailureReceived message

            PasswordChallengeSuccess tokens ->
                PasswordChallengeSuccessReceived tokens

            SignUpForm_Command command_ ->
                SignUpForm_Event <| SignUpForm.commandMap model.signUpForm.state command_

            SignUpError message ->
                SignUpErrorReceived message

            SignUpFailure message ->
                SignUpFailureReceived message

            SignUpSuccess message ->
                SignUpSuccessReceived message


logInEventMap : Model -> LogInForm.Event -> ( Model, Maybe Effect )
logInEventMap model event =
    case event of
        {-
           Track log in progress and trigger cognito side effect
        -}
        LogInForm.LogInClicked ->
            -- if model.logInInProgress then
            --     ( model, Nothing )
            -- else
            ( { model | logInInProgress = True }
            , Just <|
                DoLogIn
                    { credentials =
                        { username = model.logInForm.state.username
                        , password = model.logInForm.state.password
                        }
                    , newPassword = Just model.logInForm.state.newPassword
                    }
            )

        {-
           Pass the events that aren't intercepted down to the log in child
        -}
        _ as childEvent ->
            eventBinder
                LogInForm.eventMap
                model.logInForm
                (\state -> { model | logInForm = state })
                LogInForm_Effect
                childEvent


passwordChallengeEventMap : Model -> PasswordChallengeForm.Event -> ( Model, Maybe Effect )
passwordChallengeEventMap model event =
    case event of
        {-
           Track password challenge progress and trigger cognito side effect
        -}
        PasswordChallengeForm.SubmitClicked ->
            -- if model.passwordChallengeInProgress then
            --     ( model, Nothing )
            -- else
            ( { model | passwordChallengeInProgress = True }
            , Just <|
                DoConfirmPassword
                    { credentials =
                        { username = model.passwordChallengeForm.state.username
                        , password = model.passwordChallengeForm.state.password
                        }
                    , newPassword = Just model.passwordChallengeForm.state.newPassword
                    }
            )

        {-
           Pass the events that aren't intercepted down to the log in child
        -}
        _ as childEvent ->
            eventBinder
                PasswordChallengeForm.eventMap
                model.passwordChallengeForm
                (\state -> { model | passwordChallengeForm = state })
                PasswordChallengeForm_Effect
                childEvent


signUpEventMap : Model -> SignUpForm.Event -> ( Model, Maybe Effect )
signUpEventMap model event =
    case event of
        {-
           Track log in progress and trigger cognito side effect
        -}
        SignUpForm.SignUpClicked ->
            -- if model.signUpInProgress then
            --     ( model, Nothing )
            -- else
            ( { model | signUpInProgress = True }
            , Just <|
                DoSignUp
                    { username = model.signUpForm.state.username
                    , password = model.signUpForm.state.password
                    }
            )

        {-
           Pass the events that aren't intercepted down to the sign up child
        -}
        _ as childEvent ->
            eventBinder
                SignUpForm.eventMap
                model.signUpForm
                (\state -> { model | signUpForm = state })
                SignUpForm_Effect
                childEvent


eventMap : Model -> Event -> ( Model, Maybe Effect )
eventMap model event =
    let
        t1 =
            Debug.log "Auth Event" event
    in
        case event of
            LogInForm_Event event_ ->
                logInEventMap model event_

            LogInErrorReceived message ->
                ( { model
                    | logInError = Just message
                  }
                , Nothing
                )

            -- ( model, Nothing )
            LogInFailureReceived message ->
                ( { model
                    | logInError = Just message
                  }
                , Nothing
                )

            LogInMFARequiredReceived message ->
                ( model, Nothing )

            LogInNewPasswordRequiredReceived message ->
                let
                    logInForm =
                        model.logInForm.state
                in
                    ( { model
                        | logInForm = State { logInForm | showNewPassword = True }
                      }
                    , Nothing
                    )

            -- ( model, Nothing )
            LogInSuccessReceived tokens ->
                ( { model
                    | user = Just <| User model.logInForm.state.username model.logInForm.state.username
                    , tokens = Just tokens
                  }
                , Nothing
                )

            PasswordChallengeForm_Event event_ ->
                passwordChallengeEventMap model event_

            PasswordChallengeErrorReceived message ->
                ( model, Nothing )

            PasswordChallengeFailureReceived message ->
                ( model, Nothing )

            PasswordChallengeSuccessReceived tokens ->
                ( { model
                    | tokens = Just tokens
                  }
                , Nothing
                )

            -- ( model, Nothing )
            SignUpForm_Event event_ ->
                signUpEventMap model event_

            SignUpErrorReceived message ->
                ( model, Nothing )

            SignUpFailureReceived message ->
                ( model, Nothing )

            SignUpSuccessReceived message ->
                ( model, Nothing )


mapContext : Context -> Model
mapContext context =
    Maybe.withDefault
        { username = Nothing
        }
        context
        |> mapValues


mapValues : ContextValues -> Model
mapValues values =
    defaultModel


defaultModel : Model
defaultModel =
    { user = Nothing
    , tokens = Nothing
    , logInInProgress = False
    , logInError = Nothing
    , logInForm = State <| LogInForm.defaultModel
    , passwordChallengeInProgress = False
    , passwordChallengeForm = State <| PasswordChallengeForm.defaultModel
    , signUpInProgress = False
    , signUpForm = State <| SignUpForm.defaultModel
    }


logInForm : (Command -> parentCommand) -> State Model -> List (Html parentCommand)
logInForm mapper authModel =
    LogInForm.view authModel.state.logInForm.state
        |> List.map
            (\item ->
                item
                    |> map LogInForm_Command
                    |> map mapper
            )


passwordChallengeForm : (Command -> parentCommand) -> State Model -> List (Html parentCommand)
passwordChallengeForm mapper authModel =
    PasswordChallengeForm.view authModel.state.passwordChallengeForm.state
        |> List.map
            (\item ->
                item
                    |> map PasswordChallengeForm_Command
                    |> map mapper
            )


signUpForm : (Command -> parentCommand) -> State Model -> List (Html parentCommand)
signUpForm mapper authModel =
    SignUpForm.view authModel.state.signUpForm.state
        |> List.map
            (\item ->
                item
                    |> map SignUpForm_Command
                    |> map mapper
            )
