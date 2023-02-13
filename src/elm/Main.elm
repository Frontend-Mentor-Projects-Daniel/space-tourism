module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Decoders exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import Http
import Pages.CrewPage as CrewPage
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
    , headerModel : Header.Model
    , homePageModel : HomePage.Model
    , destinationPageModel : Destination.Model
    , crewPageModel : CrewPage.Model
    , data : Data
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        ( destModel, destCmds ) =
            Destination.init

        ( crewModel, crewCmds ) =
            CrewPage.init
    in
    ( { key = key
      , url = url
      , headerModel = Header.init
      , homePageModel = HomePage.init
      , destinationPageModel = destModel
      , crewPageModel = crewModel
      , data =
            { destinations = []
            , crew = []
            }
      }
    , getData
    )



-- Cmd.batch ([ Destination.getPlanetData, destCmds ] |> List.map (Cmd.map DestinationPageMsg))
-- UPDATE


type Msg
    = HeaderMsg Header.Msg
    | HomePageMsg HomePage.Msg
    | DestinationPageMsg Destination.Msg
    | CrewPageMsg CrewPage.Msg
    | UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | GotData (Result Http.Error Data)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotData result ->
            case result of
                Ok data ->
                    ( { model | data = data }, Cmd.none )

                Err error ->
                    ( model, Cmd.none )

        HeaderMsg headerMsg ->
            let
                ( newHeaderModel, cmdHeader ) =
                    Header.update headerMsg model.headerModel
            in
            ( { model | headerModel = newHeaderModel }, Cmd.map HeaderMsg cmdHeader )

        HomePageMsg _ ->
            ( model, Cmd.none )

        DestinationPageMsg destinationPageMsg ->
            let
                ( newDestinationpageModel, cmdDest ) =
                    Destination.update destinationPageMsg model.destinationPageModel
            in
            ( { model | destinationPageModel = newDestinationpageModel }, Cmd.map DestinationPageMsg cmdDest )

        CrewPageMsg crewPageMsg ->
            let
                ( newCrewPageModel, cmdCrew ) =
                    CrewPage.update crewPageMsg model.crewPageModel
            in
            ( { model | crewPageModel = newCrewPageModel }, Cmd.map CrewPageMsg cmdCrew )

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
        Html.map HomePageMsg (HomePage.view model.homePageModel)

    else if model.url.path == "/destination" then
        Html.map DestinationPageMsg (Destination.view model.destinationPageModel model.data)

    else if model.url.path == "/crew" then
        Html.map CrewPageMsg (CrewPage.view model.crewPageModel model.data)

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
                "homepage-bg"

            else
                "homepage-bg"
    in
    rootClass



-- HTTP REQUEST


getData : Cmd Msg
getData =
    Http.get
        { url = "./data.json"
        , expect = Http.expectJson GotData dataDecoder
        }
