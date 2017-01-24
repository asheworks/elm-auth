module Example.View exposing (..)

import Html exposing (..)

--

import Example.Style exposing (..)
import Example.Model exposing (Command(..), Model)


-- import Auth.Components.LogIn.View as LogIn
-- import Auth.LogIn.Model as T
-- import Auth as Auth
import LogInForm.Model as LogInForm
import LogInForm.View as LogInForm

import SignUpForm.Model as SignUpForm
import SignUpForm.View as SignUpForm

--


{ id, class, classList } =
    cssNamespace



--

wrapper : Html Command -> Html Command
wrapper child =
    [ child ]
        |> div [ class [ Container ] ]

view : Model -> Html Command
view model =
    List.map wrapper
        [ model.logInForm.state |> LogInForm.view |> map LogInForm_Command
        , model.signUpForm.state |> SignUpForm.view |> map SignUpForm_Command
        ]
        |> div [ class [ Component ] ]
