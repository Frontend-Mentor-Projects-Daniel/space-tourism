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
    , headerModel : HeaderModel
    }


headerModel : HeaderModel
headerModel =
    { menuIsExpanded = "false"
    , imageSrc = "./src/assets/shared/icon-hamburger.svg"
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key, url = url, headerModel = headerModel }, Cmd.none )



-- UPDATE


type Msg
    = HamburgerMenuClicked
    | Msg2
    | UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HamburgerMenuClicked ->
            ( { model | headerModel = { menuIsExpanded = toggleMenu model, imageSrc = toggleImage model } }, Cmd.none )

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
    { title = "Space Tourism"
    , body =
        [ div [ id "root" ]
            [ viewHeader model
            ]
        ]
    }



--& VIEW HEADER


type alias HeaderModel =
    { menuIsExpanded : String
    , imageSrc : String
    }


viewHeader : Model -> Html Msg
viewHeader model =
    header [ class "header center" ]
        [ div [ class "logo" ]
            [ img [ src "./src/assets/shared/logo.svg", alt "Space Tourism" ] []
            ]
        , nav [ class "navbar", role "navigation", ariaLabel "Main Menu" ]
            [ button [ onClick HamburgerMenuClicked, class "hamburger-menu", ariaExpanded model.headerModel.menuIsExpanded ]
                [ img [ src model.headerModel.imageSrc, alt "", ariaHidden True ] []
                , span [ class "sr-only" ] [ text "Menu" ]
                ]
            , ul [ class "nav-items" ]
                [ li [ class "nav-item active" ] [ a [ href "/" ] [ span [] [ text "00" ], text "home" ] ]
                , li [ class "nav-item" ] [ a [ href "/" ] [ span [] [ text "01" ], text "destination" ] ]
                , li [ class "nav-item" ] [ a [ href "/" ] [ span [] [ text "02" ], text "crew" ] ]
                , li [ class "nav-item" ] [ a [ href "/" ] [ span [] [ text "03" ], text "technology" ] ]
                ]
            ]
        ]


toggleMenu : Model -> String
toggleMenu model =
    if model.headerModel.menuIsExpanded == "false" then
        "true"

    else
        "false"


toggleImage : Model -> String
toggleImage model =
    if model.headerModel.imageSrc == "./src/assets/shared/icon-hamburger.svg" then
        "./src/assets/shared/icon-close.svg"

    else
        "./src/assets/shared/icon-hamburger.svg"



--* HELPER FUNCTIONS
