module LogInForm.Model
    exposing
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

import Forms exposing (..)

type alias ContextValues =
    { username : Maybe String
    }


type alias Context =
    Maybe ContextValues


type alias Model =
    { username : String
    , usernameError : Maybe String
    , password : String
    , passwordError : Maybe String
    , logInError : Maybe String
    }


type Command
    = UpdateUsername String
    | UpdatePassword String
    | LogIn
    | SignUp
    | ForgotPassword

-- | LogInSuccess { result : String }
-- | LogInError String



type Event
    = UsernameUpdated String
    | PasswordUpdated String
    | LogInRequested String String
    | SignUpRequested
    | ForgotPasswordRequested

-- | LogInSuccessReceived { result : String }
-- | LogInErrorReceived String


type Effect
    = DoLogIn String String
    | ShowSignUp
    | ShowForgotPassword

type Errors
    = InvalidEmail String

mapContext : Context -> Model
mapContext context =
    Maybe.withDefault
        { username = Nothing
        }
        context
        |> mapValues


mapValues : ContextValues -> Model
mapValues values =
    case values.username of
        Nothing -> defaultModel
        Just username ->
            { defaultModel | username = username }


defaultModel : Model
defaultModel =
    { username = ""
    , usernameError = Nothing
    , password = ""
    , passwordError = Nothing
    , logInError = Nothing
    }
