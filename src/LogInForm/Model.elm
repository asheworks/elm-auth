module LogInForm.Model
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
    { username : Maybe String
    }


type alias Context =
    Maybe ContextValues


type alias Model =
    { username : String
    , usernameError : Maybe String
    , password : String
    , passwordError : Maybe String
    , showNewPassword : Bool
    , newPassword : String
    , newPasswordError : Maybe String
    , logInError : Maybe String
    }


type Command
    = UpdateUsername String
    | UpdatePassword String
    | UpdateNewPassword String
    | LogIn
    | KeyDown Int


type Event
    = UsernameUpdated String
    | PasswordUpdated String
    | NewPasswordUpdated String
    | LogInClicked
    | KeyPressed Int


type Effect
    = DoLogIn String String



-- type Command
--     = UpdateUsername String String
--     | UpdatePassword String String
--     | LogIn String
-- type Event
--     = UsernameUpdated String String
--     | PasswordUpdated String String
--     | LogInClicked String
-- type Effect
--     = DoLogIn String String


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
        Nothing ->
            defaultModel

        Just username ->
            { defaultModel | username = username }


defaultModel : Model
defaultModel =
    { username = ""
    , usernameError = Nothing
    , password = ""
    , passwordError = Nothing
    , showNewPassword = False
    , newPassword = ""
    , newPasswordError = Nothing
    , logInError = Nothing
    }
