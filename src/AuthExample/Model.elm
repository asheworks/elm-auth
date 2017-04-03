module AuthExample.Model
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

import Auth as Auth

type alias ContextValues =
    {}


type alias Context =
    Maybe ContextValues


type alias Model =
    { auth : State Auth.Model
    }


type Command
    = Auth_Command Auth.Command



type Event
    = Auth_Event Auth.Event


type Effect
    = Auth_Effect Auth.Effect
    

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
    { auth = State <| Auth.defaultModel
    }
