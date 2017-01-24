module Example.Style
    exposing
        ( CssClasses(..)
        , CssIds(..)
        , cssNamespace
        , css
        )

import Css exposing (..)
import Css.Elements as Elements
import Html.CssHelpers exposing (Namespace, withNamespace)
import Css.Namespace exposing (namespace)
-- import Styles.Colors exposing (..)


type CssClasses
    = Component
    | Container


type CssIds
    = None


cssNamespace : Namespace String a b c
cssNamespace =
    withNamespace "Auth_Example_"


css : Stylesheet
css =
    (stylesheet << namespace cssNamespace.name)
        [ (.) Component
            []
        , (.) Container
            [ displayFlex
            , flexDirection row
            , padding (px 20)
            , border3 (px 1) solid (hex "#f00")
            ]
        ]
