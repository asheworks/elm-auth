module AuthExample.Update exposing (..)

import CQRS exposing (eventBinder)


--

import AuthExample.Model exposing (..)
import Auth as Auth


--


decode : Context -> Model
decode =
    mapContext


encode : Model -> Context
encode _ =
    Nothing


init : Model -> ( Model, Maybe effect )
init model =
    ( model, Nothing )


commandMap : Model -> Command -> Event
commandMap model command =
    case command of
        Auth_Command command_ ->
            Auth_Event <| Auth.commandMap model.auth.state command_


eventMap : Model -> Event -> ( Model, Maybe Effect )
eventMap model event =
    case event of
        Auth_Event event_ ->
            eventBinder
                Auth.eventMap
                model.auth
                (\state -> { model | auth = state })
                Auth_Effect
                event_
