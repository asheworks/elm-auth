module SignUpForm.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (defaultValue, for, id, placeholder, type_, value)
import Html.Events exposing (onInput, onClick)

--

import SignUpForm.Model exposing (Command(..), Model)
import SignUpForm.Style exposing (..)
import Forms as Forms


{ id, class, classList } =
    cssNamespace



--

view : Model -> Html Command
view model =
    div
        [ class [ Component ]
        ]
        [ form
            [ id "auth-form" ]
            [ usernameInput model
            , passwordInput model
            , signUpButton model
            , Forms.errorLabel model.signUpError
            , logInButton model
            ]
        ]

usernameInput : Model -> Html Command
usernameInput model =
    div
        []
        [ Forms.inputField
            { key = "username"
            , label = "User Name: "
            , placeholder = "e.g. user@gmail.com"
            , value = model.username
            , error = model.usernameError
            , onInput = UpdateUsername
            }
        ]

passwordInput : Model -> Html Command
passwordInput model =
    div
        []
        [ Forms.inputField
            { key = "password"
            , label = "Password: "
            , placeholder = ""
            , value = model.password
            , error = model.passwordError
            , onInput = UpdatePassword
            }
        ]


signUpButton : Model -> Html Command
signUpButton model =
    div
        [ class [ SignUpButton ]
        , onClick SignUp
        ]
        [ text "SIGN UP"
        ]


logInButton : Model -> Html Command
logInButton model =
    div
        [ class [ LogInButton ]
        , onClick LogIn
        ]
        [ text "Log In To Existing Account"
        ]
