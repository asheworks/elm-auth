module LogInForm.Update exposing (..)

import String exposing (trim)

--

import LogInForm.Model exposing (..)


-- Move these to a library


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
            Debug.log "LogInFormCommandMap Command" command
    in
        case command of
            LogIn ->
                LogInRequested model.username model.password

            UpdateUsername value ->
                UsernameUpdated value

            UpdatePassword value ->
                PasswordUpdated value

            SignUp ->
                SignUpRequested

            ForgotPassword ->
                ForgotPasswordRequested

            -- LogInSuccess payload ->
            --     LogInSuccessReceived payload

            -- LogInError payload ->
            --     LogInErrorReceived payload

            

            


defaultError : String
defaultError =
    "An error has occurred"


logInErrorMap : String -> String
logInErrorMap message =
    case message of
        "Invalid email address format." ->
            "Invalid email address format"

        "Incorrect username or password." ->
            "Incorrect account name or password"

        "User does not exist." ->
            "Incorrect account name or password"

        "Password attempts exceeded" ->
            "Too many password attempts"

        _ ->
            if String.contains "'password' failed to satisfy constraint" message then
                "Invalid password format"
            else
                defaultError

usernameFilter value =
    String.filter validUsername <| String.trim value

eventMap : Model -> Event -> ( Model, Maybe Effect )
eventMap model event =
    let
        t1 =
            Debug.log "LogInForm EventMap Event" event
    in
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

            LogInRequested username password ->
                ( model, Just <| DoLogIn username password )
            
            SignUpRequested ->
                ( model, Nothing )

            ForgotPasswordRequested ->
                ( model, Nothing )

            -- SignUpRequested ->
            --     ( model, ShowSignUp )

            -- ForgotPasswordRequested ->
            --     ( model, ShowForgotPassword )

            -- LogInSuccessReceived result ->
            --     let
            --         t =
            --             Debug.log "LogInForm - LogInSuccessReceived" result
            --     in
            --         ( model, None )

            -- LogInErrorReceived message ->
            --     let
            --         t =
            --             Debug.log "LogInForm - LogInErrorReceived" <| logInErrorMap message
            --     in
            --         ( { model | logInError = Just <| logInErrorMap message }, None )

           

            
                