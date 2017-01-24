module Example.Model
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

import CQRS exposing (State)

--

import LogInForm.Model as LogInForm
import SignUpForm.Model as SignUpForm

type alias ContextValues =
    {}


type alias Context =
    Maybe ContextValues


type alias Model =
    { logInForm : State LogInForm.Model
    , signUpForm : State SignUpForm.Model
    }


type Command
    = LogInForm_Command LogInForm.Command
    | SignUpForm_Command SignUpForm.Command


type Event
    = LogInForm_Event LogInForm.Event
    | SignUpForm_Event SignUpForm.Event

type Effect
    = LogInForm_Effect LogInForm.Effect
    | SignUpForm_Effect SignUpForm.Effect

mapContext : Context -> Model
mapContext context =
    Maybe.withDefault
        {}
        context
        |> mapValues


mapValues : ContextValues -> Model
mapValues values =
    defaultModel


defaultModel : Model
defaultModel =
    { logInForm = State <| LogInForm.defaultModel
    , signUpForm = State <| SignUpForm.defaultModel
    }
