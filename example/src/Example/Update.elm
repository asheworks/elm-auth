module Example.Update exposing (..)

import CQRS exposing (eventBinder)

--

import Example.Model exposing (..)
import LogInForm.Update as LogInForm
import SignUpForm.Update as SignUpForm

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
    let
        t1 =
            Debug.log "Example - CommandMap" command
    in
        case command of
            LogInForm_Command command_ ->
                LogInForm_Event <| LogInForm.commandMap model.logInForm.state command_

            SignUpForm_Command command_ ->
                SignUpForm_Event <| SignUpForm.commandMap model.signUpForm.state command_


eventMap : Model -> Event -> ( Model, Maybe Effect )
eventMap model event =
    let
        t1 =
            Debug.log "Example - EventMap" event
    in
        case event of
            LogInForm_Event event_ ->
                eventBinder
                    LogInForm.eventMap
                    model.logInForm
                    (\( state ) -> { model | logInForm = state })
                    LogInForm_Effect
                    event_

            SignUpForm_Event event_ ->
                eventBinder
                    SignUpForm.eventMap
                    model.signUpForm
                    (\( state ) -> { model | signUpForm = state })
                    SignUpForm_Effect
                    event_