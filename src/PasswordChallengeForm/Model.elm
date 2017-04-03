module PasswordChallengeForm.Model
    exposing
        ( Command(..)
        , Event(..)
        , Effect(..)
        , Context
        , ContextValues
        , Model
        , mapContext
        , mapValues
        , defaultModel
        )


type alias ContextValues =
    {
    }


type alias Context =
    Maybe ContextValues


type alias Model =
    { username : String
    , password : String
    , passwordError : Maybe String
    , newPassword : String
    , newPasswordError : Maybe String
    , error : Maybe String
    }


type Command
    = UpdatePassword String
    | UpdateNewPassword String
    | Submit

type Event
    = PasswordUpdated String
    | NewPasswordUpdated String
    | SubmitClicked

type Effect
    = DoConfirmPassword String


mapContext : Context -> Model
mapContext context =
    Maybe.withDefault
        {
        }
        context
        |> mapValues

mapValues : ContextValues -> Model
mapValues values =
    defaultModel


defaultModel : Model
defaultModel =
    { username = ""
    , password = ""
    , passwordError = Nothing
    , newPassword = ""
    , newPasswordError = Nothing
    , error = Nothing
    }
