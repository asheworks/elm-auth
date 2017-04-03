module SignUpForm.Model
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
    , usernameError : Maybe String
    , password : String
    , passwordError : Maybe String
    , error : Maybe String
    }


type Command
    = UpdateUsername String
    | UpdatePassword String
    | SignUp

type Event
    = UsernameUpdated String
    | PasswordUpdated String
    | SignUpClicked

type Effect
    = DoSignUp String String


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
    , usernameError = Nothing
    , password = ""
    , passwordError = Nothing
    , error = Nothing
    }
