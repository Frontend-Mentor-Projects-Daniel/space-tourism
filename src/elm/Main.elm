module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import Pages.HomePage as HomePage
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map HomePageMsg (HomePage.subscriptions model.homePageModel)
        ]



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , homePageModel : HomePage.Model
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key, url = url, homePageModel = HomePage.init }, Cmd.none )



-- UPDATE


type Msg
    = HomePageMsg HomePage.Msg
    | Msg2
    | UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomePageMsg msgHomePage ->
            let
                ( newHomePageModel, cmdHomePage ) =
                    HomePage.update msgHomePage model.homePageModel
            in
            ( { model | homePageModel = newHomePageModel }, Cmd.map HomePageMsg cmdHomePage )

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


view : Model -> Browser.Document Msg
view model =
    { title = viewTitle model
    , body =
        [ div [ id "root" ]
            [ viewPage model
            ]
        ]
    }


viewPage : Model -> Html Msg
viewPage model =
    if model.url.path == "/" then
        Html.map HomePageMsg (HomePage.view model.homePageModel)

    else if model.url.path == "/destination" then
        Html.map HomePageMsg (HomePage.view model.homePageModel)

    else if model.url.path == "/crew" then
        Html.map HomePageMsg (HomePage.view model.homePageModel)

    else if model.url.path == "/technology" then
        Html.map HomePageMsg (HomePage.view model.homePageModel)

    else
        Html.map HomePageMsg (HomePage.view model.homePageModel)


viewTitle : Model -> String
viewTitle model =
    if String.startsWith "/destination" model.url.path then
        "Destination Page"

    else if String.startsWith "/crew" model.url.path then
        "Crew Page"

    else if String.startsWith "/technology" model.url.path then
        "Technology Page"

    else if String.startsWith "/" model.url.path then
        "Home Page"

    else
        "404 - Page Not Found"



--* HELPER FUNCTIONS
