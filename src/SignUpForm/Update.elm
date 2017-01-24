module SignUpForm.Update exposing (..)

import String exposing (trim)
import Json.Decode exposing (decodeString)
import SignUpForm.Model exposing (..)
-- import Controllers.Auth.Json as Auth


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

    -- case model.signUpData of
    --     Just data ->
    --         ( model, ShowConfirm data.user.username )

    --     Nothing ->
    --         ( model, Nothing )


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
                SignUpRequested model.username <| model.password

            LogIn ->
                LogInRequested

            -- SignUpSuccess payload ->
            --     SignUpSuccessReceived payload

            -- SignUpError payload ->
            --     SignUpErrorReceived payload

            

            -- ForgotPassword ->
            --     ForgotPasswordRequested
            -- TermsOfService ->
            --     TermsOfServiceRequested

            


defaultError : String
defaultError =
    "An error has occurred"


signUpErrorMap : String -> String
signUpErrorMap message =
    case message of
        -- "Invalid email address format." ->
        --     "Invalid email address format"
        -- "Incorrect username or password." ->
        --     "Incorrect account name or password"
        -- "User does not exist." ->
        --     "Incorrect account name or password"
        -- "Password attempts exceeded" ->
        --     "Too many password attempts"
        _ ->
            -- if String.contains "'password' failed to satisfy constraint" message then
            --     "Invalid password format"
            -- else
            defaultError

usernameFilter value =
    String.filter validUsername <| String.trim value

eventMap : Model -> Event -> ( Model, Maybe Effect )
eventMap model event =
    case event of
        UsernameUpdated value ->
            ( { model | username = usernameFilter value
                          , usernameError = validateUsername value
                          }
                , Nothing
                )

        PasswordUpdated value ->
            ( { model | password = value
                          , passwordError = validatePassword value }
                , Nothing
                )

        LogInRequested ->
            ( model, Just ShowLogIn )

        SignUpRequested username password ->
            ( model, Just <| DoSignUp username password )

        -- SignUpErrorReceived message ->
        --     ( { model | signUpError = Just <| signUpErrorMap message }, None )


        -- SignUpSuccessReceived response ->
        --     case (decodeString Auth.decodeSignUpResponse response.result) of
        --         Ok signUpResponse ->
        --             ( { model | signUpData = Just <| signUpResponse }, ShowConfirm signUpResponse.user.username )

        --         Err message ->
        --             ( { model | signUpError = Just <| signUpErrorMap message }, None )

        

        -- ForgotPasswordRequested ->
        --     ( model, ShowForgotPassword )
        -- TermsOfServiceRequested ->
        --     ( model, ShowTermsOfService )

        


-- eventMap : Model -> Event -> ( Model, Effect )
-- eventMap model event =
--     case event of
--         SignUpRequested username password ->
--             ( model, DoSignUp username <| password )

--         SignUpErrorReceived message ->
--             ( { model | signUpError = Just <| signUpErrorMap message }, None )

--         SignUpSuccessReceived response ->
--             case (decodeString Auth.decodeSignUpResponse response.result) of
--                 Ok signUpResponse ->
--                     ( { model | signUpData = Just <| signUpResponse }, ShowConfirm signUpResponse.user.username )

--                 Err message ->
--                     ( { model | signUpError = Just <| signUpErrorMap message }, None )

--         LogInRequested ->
--             ( model, ShowLogIn )

--         -- ForgotPasswordRequested ->
--         --     ( model, ShowForgotPassword )
--         TermsOfServiceRequested ->
--             ( model, ShowTermsOfService )

--         UsernameUpdated value ->
--             let
--                 value_ =
--                     String.filter validUsername <| String.trim value

--                 model_ =
--                     { model | username = value_ }
--             in
--                 ( { model_ | usernameError = validateUsername value_ }, None )

--         PasswordUpdated value ->
--             let
--                 model_ =
--                     { model | password = value }
--             in
--                 ( { model_ | passwordError = validatePassword value }, None )