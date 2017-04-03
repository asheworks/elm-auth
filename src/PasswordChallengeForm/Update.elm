module PasswordChallengeForm.Update exposing (..)

import PasswordChallengeForm.Model exposing (..)


validatePassword : String -> Maybe String
validatePassword value =
    if value == "" then
        Just "Password is required"
    else
        Nothing


--


decode : Context -> Model
decode =
    mapContext


encode : Model -> Context
encode _ =
    Nothing


init : Model -> ( Model, Maybe Effect )
init model =
    ( model, Nothing )


commandMap : Model -> Command -> Event
commandMap model command =
    let
        t1 =
            Debug.log "PasswordChallengeForm CommandMap Command" command
    in
        case command of
            UpdatePassword value ->
                PasswordUpdated value

            UpdateNewPassword value ->
                NewPasswordUpdated value

            Submit ->
                SubmitClicked


eventMap : Model -> Event -> ( Model, Maybe Effect )
eventMap model event =
    case event of
        PasswordUpdated value ->
            ( { model | password = value
              }
            , Nothing
            )
            
        NewPasswordUpdated value ->
            ( { model | newPassword = value
                      , newPasswordError = validatePassword value
              }
            , Nothing
            )

        SubmitClicked ->
            ( model, Just <| DoConfirmPassword model.password )
