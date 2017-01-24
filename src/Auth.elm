module Auth exposing
        ( Command(..)
        , Event(..)
        , Effect(..)
        , Errors(..)
        , Context
        , ContextValues
        , Model
        , mapContext
        , mapValues
        , defaultModel
        )

{-| This library contains components to interact with authentication providers such as asheworks/elm-cognito

## Models
@docs Credentials
@docs User
@docs Model

-}

--- import Auth.Login exposing (..)

-- import LogInForm as LogInForm

{-| Credentials

Structure to carry a user's login credentials to the auth provider

-}
type alias Credentials =
    { username : String
    , password : String
    }

{-| User

Structure to carry a user's basic info
-}
type alias User =
    { displayName : String
    , email : String
    }

{-| Model

Maintains state for the authentication aspect of an application

user

- If nothing then there is no authenticated user
- If just User then this contains the currently authenticated user

-}
type alias Model =
    { user : Maybe User
    }

type Command
    = LogIn Credentials

type Event
    = LogInRequested Credentials

type Effect
    = CallLogIn Credentials


-- type alias CredentialsValidationResult =
--     { general : Maybe (List String)
--     , username : Maybe String
--     , password : Maybe String
--     }


-- type alias ValidationFunc =
--     Credentials -> CredentialsValidationResult


-- type LogInResponses
--     = Success
--     | InvalidUserName


-- type Command
--     = Validate Credentials
--     | LogIn Credentials
--     | LogInAPISuccess String
--     | LogInAPIError String


-- type Event
--     = ValidationCompleted CredentialsValidationResult
--     | LogInRequested Credentials
--     | LogInAPICompleted LogInResponses


-- type Effect
--     = None
--     | CallLogInAPI Credentials

commandMap : Model -> Command -> Event
commandMap model command =
    let
        t1 =
            Debug.log "Auth CommandMap Command" command
    in
        case command of
            LogIn ->
                LogInRequested model.username model.password

eventMap : Model -> Event -> ( Model, Maybe Effect )
eventMap model event =
    let
        t1 =
            Debug.log "Auth EventMap Event" event
    in
        case event of
          LogInRequested username password ->
                  ( model, Just <| DoLogIn username password )