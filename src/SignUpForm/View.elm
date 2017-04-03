module SignUpForm.View exposing (..)

import Html exposing (..)


--

import SignUpForm.Model exposing (Command(..), Model)
import SignUpForm.Style exposing (..)
import UI as UI
import UI.Button
import UI.FieldLabel
import UI.Input


{ id, class, classList } =
    cssNamespace



--


view : Model -> List (Html Command)
view model =
    [ usernameInput model
    , passwordInput model
    , submit
    ]



-- view : Model -> Html Command
-- view model =
--     UI.formControl
--         { id = "auth-form"
--         , header =
--             Just
--                 [ Html.text "SIGN UP"
--                 ]
--         , section =
--             Just
--                 [ usernameInput model
--                 , passwordInput model
--                 , submit
--                 ]
--         , aside = Nothing
--         , footer = Nothing
--         }


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
            }
        ]


submit : Html Command
submit =
    UI.Button.view
        { id = "submit"
        , label = "SIGN UP"
        , error = False
        , onClick = SignUp
        }
