module SignUpForm.Update exposing (..)

import String exposing (trim)
import SignUpForm.Model exposing (..)


validatePassword : String -> Maybe String
validatePassword value =
    if value == "" then
        Just "Password is required"
    else
        Nothing


validateUsername : String -> Maybe String
validateUsername value =
    if value == "" then
        Just "Username is required"
    else
        Nothing


validUsername : Char -> Bool
validUsername char =
    if char == ' ' then
        False
    else
        True



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
            Debug.log "SignUpFormCommandMap Command" command
    in
        case command of
            UpdateUsername value ->
                UsernameUpdated value

            UpdatePassword value ->
                PasswordUpdated value

            SignUp ->
                SignUpClicked

            KeyDown keyCode ->
                KeyPressed keyCode


usernameFilter value =
    String.filter validUsername <| String.trim value


eventMap : Model -> Event -> ( Model, Maybe Effect )
eventMap model event =
    case event of
        UsernameUpdated value ->
            ( { model
                | username = usernameFilter value
                , usernameError = validateUsername value
              }
            , Nothing
            )

        PasswordUpdated value ->
            ( { model
                | password = value
                , passwordError = validatePassword value
              }
            , Nothing
            )

        SignUpClicked ->
            ( model, Just <| DoSignUp model.username model.password )

        KeyPressed keyCode ->
            case keyCode of
                13 ->
                    ( model, Just <| DoSignUp model.username model.password )

                _ ->
                    ( model, Nothing )
