module PasswordChallengeForm.View exposing (..)

import Html exposing (..)


--

import PasswordChallengeForm.Model exposing (Command(..), Model)
import UI as UI
import UI.Button
import UI.FieldLabel
import UI.Input


--


view : Model -> List (Html Command)
view model =
    [ userNameLabel model
    , passwordInput model
    , newPasswordInput model
    , submit
    ]



-- view : Model -> Html Command
-- view model =
--     UI.formControl
--         { id = "auth-form"
--         , header =
--             Just
--                 [ Html.text "CONFIRM PASSWORD"
--                 ]
--         , section =
--             Just
--                 [ userNameLabel model
--                 , passwordInput model
--                 , newPasswordInput model
--                 , submit
--                 ]
--         , aside = Nothing
--         , footer = Nothing
--         }


userNameLabel : Model -> Html Command
userNameLabel model =
    UI.FieldLabel.view
        { id = "username-label"
        , label = "User Name: "
        , error = False
        , labelColorHex = Nothing
        }
        [ Html.text model.username
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
        { id = "newPassword-label"
        , label = "New Password: "
        , error = False
        , labelColorHex = Nothing
        }
        [ UI.Input.view
            { id = "newPassword"
            , placeholder = ""
            , inputType = UI.Input.PasswordField
            , value = model.password
            , error = False
            , onInput = UpdateNewPassword
            , onKeyDown = KeyDown
            }
        ]


submit : Html Command
submit =
    UI.Button.view
        { id = "submit"
        , label = "CONFIRM NEW PASSWORD"
        , error = False
        , onClick = Submit
        , onKeyDown = KeyDown
        }



-- UI.labelField
--     { key = "username"
--     , label = "User Name: "
--     , value = model.username
--     }
-- passwordInput : Model -> Html Command
-- passwordInput model =
--     UI.inputField
--         { key = "password"
--         , label = "Password: "
--         , placeholder = ""
--         , inputType = UI.PasswordField
--         , value = model.password
--         , error = model.passwordError
--         , onInput = UpdatePassword
--         }
-- newPasswordInput : Model -> Html Command
-- newPasswordInput model =
--     UI.inputField
--         { key = "newPassword"
--         , label = "New Password: "
--         , placeholder = ""
--         , inputType = UI.PasswordField
--         , value = model.newPassword
--         , error = model.newPasswordError
--         , onInput = UpdateNewPassword
--         }
