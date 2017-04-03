module AuthExample.View exposing (..)

import Html exposing (..)


--

import AuthExample.Style exposing (..)
import AuthExample.Model exposing (Command(..), Model)
import Auth as Auth


--


{ id, class, classList } =
    cssNamespace



--


wrapper : ( String, List (Html Command) ) -> Html Command
wrapper ( label, children ) =
    [ span
        [ class
            [ Label
            ]
        ]
        [ text label
        ]
    ]
        ++ children
        |> div [ class [ Container ] ]


view : Model -> Html Command
view model =
    List.map wrapper
        [ ( "Sign Up", Auth.signUpForm Auth_Command model.auth )
        , ( "Log In", Auth.logInForm Auth_Command model.auth )
        , ( "Password Challenge", Auth.passwordChallengeForm Auth_Command model.auth )
        ]
        |> div [ class [ Component ] ]
