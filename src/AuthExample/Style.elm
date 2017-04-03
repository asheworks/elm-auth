module AuthExample.Style
    exposing
        ( CssClasses(..)
        , CssIds(..)
        , cssNamespace
        , css
        )

import Css exposing (..)
-- import Css.Elements as Elements
import Html.CssHelpers exposing (Namespace, withNamespace)
import Css.Namespace exposing (namespace)
-- import Styles.Colors exposing (..)


type CssClasses
    = Component
    | Container
    | Label


type CssIds
    = None


cssNamespace : Namespace String a b c
cssNamespace =
    withNamespace "Auth_AuthExample_"


css : Stylesheet
css =
    (stylesheet << namespace cssNamespace.name)
        [ (.) Component
            [ displayFlex
            , flexDirection column
            ]
        , (.) Container
            [ displayFlex
            , flexDirection column
            , padding (px 20)
            , borderBottom3 (px 1) solid (hex "#a00")
            , borderRight3 (px 1) solid (hex "#a00")
            ]
        , (.) Label
            [ padding (px 10)
            , borderBottom3 (px 1) solid (hex "#555")
            , fontSize (em 1.2)
            , color (hex "#833")
            , marginBottom (px 20)
            ]
        ]
