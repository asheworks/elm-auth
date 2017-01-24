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

-- import Json.Decode exposing (decodeString)
-- import Controllers.Auth.Model as Auth
-- import Controllers.Auth.Json as Auth


type alias ContextValues =
    {}


type alias Context =
    Maybe ContextValues


type alias Model =
    { username : String
    , usernameError : Maybe String
    , password : String
    , passwordError : Maybe String
    , signUpError : Maybe String
    }

-- , signUpData : Maybe Auth.SignUpResponse


type Command
    = UpdateUsername String
    | UpdatePassword String
    | SignUp
    | LogIn

-- | SignUpSuccess { result : String }
-- | SignUpError String


type Event
    = UsernameUpdated String
    | PasswordUpdated String
    | SignUpRequested String String
    | LogInRequested

-- | SignUpSuccessReceived { result : String }
-- | SignUpErrorReceived String

type Effect
    = DoSignUp String String
    | ShowConfirm String
    | ShowLogIn


mapContext : Context -> Model
mapContext context =
    Maybe.withDefault
        {}
        context
        |> mapValues


-- decodeData : Maybe String -> Maybe Auth.SignUpResponse
-- decodeData value =
--     case value of
--         Just json ->
--             Result.toMaybe <| decodeString Auth.decodeSignUpResponse json

--         Nothing ->
--             Nothing


mapValues : ContextValues -> Model
mapValues values =
    defaultModel


defaultModel : Model
defaultModel =
    { username = ""
    , usernameError = Nothing
    , password = ""
    , passwordError = Nothing
    , signUpError = Nothing
    }

-- , signUpData = Nothing
