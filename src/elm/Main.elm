module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , property : String
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key, url = url, property = "Space Tourism" }, Cmd.none )



-- UPDATE


type Msg
    = Msg1
    | Msg2
    | UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg1 ->
            ( model, Cmd.none )

        Msg2 ->
            ( model, Cmd.none )

        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = model.property
    , body =
        [ div [ id "root" ]
            [ viewHeader
            ]
        ]
    }



-- TYPES
-- VIEW FUNCTIONS
-- <img src="./src/assets/shared/logo.svg" />
-- <img src="./src/assets/shared/icon-hamburger.svg">
-- <img src="./src/assets/shared/icon-close.svg">


viewHeader : Html msg
viewHeader =
    header [ class "main-header" ]
        [ div [ class "logo" ]
            [ img [ src "./src/assets/shared/logo.svg", alt "Space Tourism" ] []
            ]
        , nav [ class "navbar", role "navigation", ariaLabel "Main Menu" ]
            [ button [ class "hamburger-menu", ariaExpanded "false" ]
                [ img [ src "./src/assets/shared/icon-hamburger.svg", alt "", ariaHidden True ] []
                , span [ class "sr-only" ] [ text "Menu" ]
                ]
            , ul [ class "nav-items hidden" ]
                [ li [ class "nav-item" ] [ span [] [ text "00" ], text "home" ]
                , li [ class "nav-item" ] [ span [] [ text "01" ], text "destination" ]
                , li [ class "nav-item" ] [ span [] [ text "02" ], text "crew" ]
                , li [ class "nav-item" ] [ span [] [ text "03" ], text "technology" ]
                ]
            ]
        ]



-- viewHomePage : Html msg
-- viewHomePage =
--     div [] []
-- HELPER FUNCTIONS
