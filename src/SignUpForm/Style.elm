module SignUpForm.Style
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
    | LogInButton
    | SignUpButton
    | ForgotPasswordButton

      -- | WhiteBox
      -- | Title
    -- | InputWrapper
    -- | Input
    -- | InputError
    -- | LabelWrapper
    -- | Label
    -- | Error
    
    -- | TermsWrapper
    -- | TermsLink
    -- | Hidden


type CssIds
    = None


cssNamespace : Namespace String a b c
cssNamespace =
    withNamespace "SignUpForm_"


offBlack = (hex "#f00")

white = (hex "#0f0")

css : Stylesheet
css =
    (stylesheet << namespace cssNamespace.name)
        [ (.) Component
            [ children
                [ Elements.form
                    [ displayFlex
                    , flexDirection column
                    , padding (px 0)
                    , margin (px 0)
                    , maxWidth (px 600)
                    ]
                , Elements.input
                    [ outline3 (px 1) solid offBlack
                    ]
                , Elements.p
                    [ flexGrow (int 1)
                    , textAlign right
                    , property "user-select" "none"
                    ]
                ]
            ]
        , (.) SignUpButton
            [ cursor pointer
            , backgroundColor (hex "#f6b314")
            , color white
            , textTransform capitalize
            , fontSize (em 1.2)
            , width (px 200)
            , alignSelf center
            , textAlign center
            , margin3 (px 20) auto (px 5)
            , padding3 (px 17) (px 42) (px 16)
            , borderRadius (px 4)
            , property "user-select" "none"
            , hover
                [ backgroundColor offBlack
                ]
            ]
        , (.) LogInButton
            [ cursor pointer
            , color (hex "#BBB")
            , textAlign center
            , fontSize (em 1)
            , paddingTop (px 15)
            , property "user-select" "none"
            , hover
                [ color (hex "#F88")
                ]
            ]
        ]


        -- , (.) Input
        --     [ flex (int 1)
        --     , padding2 (px 15) (px 20)
        --     , fontSize (em 1.3)
        --     , borderRadius (px 4)
        --     , border3 (px 1) solid (hex "#BBB")
        --     , marginBottom (px 20)
        --     ]
        -- , (.) InputError
        --     [ outline3 (px 1) solid (hex "#f00")
        --     ]
        -- , (.) InputWrapper
        --     [ flex (int 1)
        --     , displayFlex
        --     , flexDirection column
        --     ]
        -- , (.) LabelWrapper
        --     [ flex (int 1)
        --     , displayFlex
        --     , flexDirection row
        --     ]
        -- , (.) Label
        --     [ flex (int 1)
        --     , color (hex "#333")
        --     , paddingTop (px 10)
        --     , fontSize (em 1.35)
        --     , fontWeight bold
        --     , margin4 (px 0) (px 0) (px 20) (px 0)
        --     , property "user-select" "none"
        --     ]
        -- , (.) Error
        --     [ flex (int 1)
        --     , color (rgb 255 0 0)
        --     , paddingTop (px 10)
        --     , fontSize (em 1.1)
        --     , property "user-select" "none"
        --     , textAlign center
        --     ]
        
        -- , (.) TermsWrapper
        --     [ width (px 500)
        --     , displayFlex
        --     , flexDirection row
        --     , color white
        --     , margin4 (px 12) (px 32) (px 0) (px 32)
        --     , fontSize (em 1)
        --     , cursor default
        --     ]
        -- , (.) TermsLink
        --     [ textDecoration underline
        --     , cursor pointer
        --     , textAlign left
        --     , paddingLeft (px 5)
        --     , property "user-select" "none"
        --     , hover
        --         [ color (hex "#f33")
        --         , fontWeight bold
        --         ]
        --     ]
        -- , (.) Hidden
        --     [ property "visibility" "hidden"
        --     , property "user-select" "none"
        --     ]
        -- ]
