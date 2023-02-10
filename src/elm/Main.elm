module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import Pages.DestinationPage as Destination
import Pages.HomePage as HomePage
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
        , Sub.map HomePageMsg (HomePage.subscriptions model.homePageModel)
        , Sub.map DestinationPageMsg (Destination.subscriptions model.destinationPageModel)
        ]



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , bgImage : String
    , headerModel : Header.Model
    , homePageModel : HomePage.Model
    , destinationPageModel : Destination.Model
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key
      , url = url
      , bgImage = "homepage-bg"
      , headerModel = Header.init
      , homePageModel = HomePage.init
      , destinationPageModel = Destination.init
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = HeaderMsg Header.Msg
    | HomePageMsg HomePage.Msg
    | DestinationPageMsg Destination.Msg
    | UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HeaderMsg headerMsg ->
            let
                ( newHeaderModel, cmdHeader ) =
                    Header.update headerMsg model.headerModel
            in
            ( { model | headerModel = newHeaderModel }, Cmd.map HeaderMsg cmdHeader )

        HomePageMsg _ ->
            ( model, Cmd.none )

        DestinationPageMsg _ ->
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
        [ div [ id "root", class (viewRootDivClass model) ]
            [ Html.map HeaderMsg (Header.view model.headerModel)
            , viewPage model
            ]
        ]
    }


viewPage : Model -> Html Msg
viewPage model =
    if model.url.path == "/" then
        -- TODO: Change this back
        -- Html.map HomePageMsg (HomePage.view model.homePageModel)
        Html.map DestinationPageMsg (Destination.view model.destinationPageModel)

    else if model.url.path == "/destination" then
        Html.map DestinationPageMsg (Destination.view model.destinationPageModel)

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


viewRootDivClass : Model -> String
viewRootDivClass model =
    let
        rootClass =
            if String.startsWith "/destination" model.url.path then
                "destination-bg"

            else if String.startsWith "/crew" model.url.path then
                "crew-bg"

            else if String.startsWith "/technology" model.url.path then
                "technology-bg"

            else if String.startsWith "/" model.url.path then
                -- "homepage-bg"
                -- TODO: Change this back
                "destination-bg"

            else
                -- "homepage-bg"
                -- TODO: Change this back
                "destination-bg"
    in
    rootClass



--* HELPER FUNCTIONS
