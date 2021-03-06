module LogInForm.View exposing (..)

import Html exposing (..)


--

import LogInForm.Model exposing (Command(..), Model)
import LogInForm.Style exposing (..)


--

import UI.Button
import UI.FieldLabel
import UI.Input


{ id, class, classList } =
    cssNamespace



--


view : Model -> List (Html Command)
view model =
    [ usernameInput model
    ]
        ++ (if model.showNewPassword then
                [ newPasswordInput model
                ]
            else
                [ passwordInput model
                ]
           )
        ++ [ submit
           ]


usernameInput : Model -> Html Command
usernameInput model =
    UI.FieldLabel.view
        { id = "username-label"
        , label = "User Name: "
        , error = False
        , labelColorHex = Nothing
        }
        [ UI.Input.view
            { id = "username"
            , placeholder = "e.g. user@gmail.com"
            , inputType = UI.Input.TextField
            , value = model.username
            , error = False
            , onInput = UpdateUsername
            , onKeyDown = KeyDown
            }
        ]


passwordInput : Model -> Html Command
passwordInput model =
    UI.FieldLabel.view
        { id = "password-label"
        , label = "Password: "
        , error = False
        , labelColorHex = Nothing
        }
        [ UI.Input.view
            { id = "password"
            , placeholder = ""
            , inputType = UI.Input.PasswordField
            , value = model.password
            , error = False
            , onInput = UpdatePassword
            , onKeyDown = KeyDown
            }
        ]


newPasswordInput : Model -> Html Command
newPasswordInput model =
    UI.FieldLabel.view
        { id = "new-password-label"
        , label = "New Password: "
        , error = False
        , labelColorHex = Nothing
        }
        [ UI.Input.view
            { id = "new-password"
            , placeholder = ""
            , inputType = UI.Input.PasswordField
            , value = model.newPassword
            , error = False
            , onInput = UpdateNewPassword
            , onKeyDown = KeyDown
            }
        ]


submit : Html Command
submit =
    UI.Button.view
        { id = "submit"
        , label = "LOG IN"
        , error = False
        , onClick = LogIn
        , onKeyDown = KeyDown
        }
