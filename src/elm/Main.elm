module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import Partials.Header as Header
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
        [ Sub.map HeaderMsg (Header.subscriptions model.headerModel)
        ]



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , headerModel : Header.Model
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key, url = url, headerModel = Header.init }, Cmd.none )



-- UPDATE


type Msg
    = HeaderMsg Header.Msg
    | Msg2
    | UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HeaderMsg msgHeader ->
            let
                ( newHeaderModel, cmdHeader ) =
                    Header.update msgHeader model.headerModel
            in
            ( { model | headerModel = newHeaderModel }, Cmd.map HeaderMsg cmdHeader )

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
            [ Html.map HeaderMsg (Header.view model.headerModel)
            , viewPage model
            ]
        ]
    }


viewPage : Model -> Html Msg
viewPage model =
    if model.url.path == "/" then
        text "Home Page"

    else if model.url.path == "/destination" then
        text "Destination Page"

    else if model.url.path == "/crew" then
        text "Crew Page"

    else if model.url.path == "/technology" then
        text "Technology Page"

    else
        text "Not Found Page"


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
