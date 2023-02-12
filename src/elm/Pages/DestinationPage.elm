module Pages.DestinationPage exposing (Model, Msg, getPlanetData, init, subscriptions, update, view)

import Decoders exposing (..)
import ErrorHandling exposing (buildErrorMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import Http



-- MODEL


type alias Model =
    { planetData : List Planet
    , errorMessages : Maybe String
    , currentPlanet : Planet
    , isMoon : Bool
    , isMars : Bool
    , isEuropa : Bool
    , isTitan : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { planetData = []
      , errorMessages = Nothing
      , currentPlanet = loadingPlanet
      , isMoon = True
      , isMars = False
      , isEuropa = False
      , isTitan = False
      }
    , getPlanetData
    )



-- UPDATE


type Msg
    = GotData (Result Http.Error Data)
    | GetMoon
    | GetMars
    | GetEuropa
    | GetTitan


update : Msg -> Model -> ( Model, Cmd.Cmd Msg )
update msg model =
    case msg of
        GotData result ->
            case result of
                Ok data ->
                    ( { model | planetData = data.destinations }, Cmd.none )

                Err error ->
                    ( { model | errorMessages = Just (buildErrorMessage error) }, Cmd.none )

        GetMoon ->
            let
                filteredPlanet =
                    List.filter
                        (\planet -> planet.name == "Moon")
                        model.planetData

                planetHead =
                    case List.head filteredPlanet of
                        Just planet ->
                            planet

                        Nothing ->
                            loadingPlanet
            in
            ( { model | currentPlanet = planetHead, isMoon = True, isMars = False, isEuropa = False, isTitan = False }, Cmd.none )

        GetMars ->
            let
                filteredPlanet =
                    List.filter
                        (\planet -> planet.name == "Mars")
                        model.planetData

                planetHead =
                    case List.head filteredPlanet of
                        Just planet ->
                            planet

                        Nothing ->
                            loadingPlanet
            in
            ( { model | currentPlanet = planetHead, isMoon = False, isMars = True, isEuropa = False, isTitan = False }, Cmd.none )

        GetEuropa ->
            let
                filteredPlanet =
                    List.filter
                        (\planet -> planet.name == "Europa")
                        model.planetData

                planetHead =
                    case List.head filteredPlanet of
                        Just planet ->
                            planet

                        Nothing ->
                            loadingPlanet
            in
            ( { model | currentPlanet = planetHead, isMoon = False, isMars = False, isEuropa = True, isTitan = False }, Cmd.none )

        GetTitan ->
            let
                filteredPlanet =
                    List.filter
                        (\planet -> planet.name == "Titan")
                        model.planetData

                planetHead =
                    case List.head filteredPlanet of
                        Just planet ->
                            planet

                        Nothing ->
                            loadingPlanet
            in
            ( { model | currentPlanet = planetHead, isMoon = False, isMars = False, isEuropa = False, isTitan = True }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    main_ [ class "main main--destination" ]
        [ h1 [ class "secondary-heading" ] [ span [] [ text "01" ], text "Pick your destination" ]
        , if model.currentPlanet.name == "Loading..." then
            defaultPlanet

          else
            viewPlanet model model.currentPlanet
        ]


loadingPlanet : Planet
loadingPlanet =
    { name = "Loading..."
    , images = { png = "Loading...", webp = "Loading..." }
    , description = "Loading..."
    , distance = "Loading..."
    , travel = "Loading..."
    }


defaultPlanet : Html Msg
defaultPlanet =
    div [ class "destination" ]
        [ div [ class "planet-image" ]
            [ img [ src "./src/assets/destination/image-moon.png", alt "Moon" ] []
            ]
        , ul [ class "planets-list" ]
            [ li [ class "planet active" ]
                [ button [ onClick GetMoon ] [ text "moon" ]
                ]
            , li [ class "planet" ]
                [ button [ onClick GetMars ] [ text "mars" ]
                ]
            , li [ class "planet" ]
                [ button [ onClick GetEuropa ] [ text "europa" ]
                ]
            , li [ class "planet" ]
                [ button [ onClick GetTitan ] [ text "titan" ]
                ]
            ]
        , div [ class "planet-info" ]
            [ h2 [ class "chosen-planet" ] [ text "Moon" ]
            , p [ class "planet-description" ] [ text "See our planet as you’ve never seen it before. A perfect relaxing trip away to help regain perspective and come back refreshed. While you’re there, take in some history by visiting the Luna 2 and Apollo 11 landing sites." ]
            ]
        , div [ class "planet-stats" ]
            [ p [ class "distance" ] [ text "avg. distance", span [] [ text "384,400 km" ] ]
            , p [ class "travel-time" ] [ text "est. travel time", span [] [ text "3 days" ] ]
            ]
        ]


viewPlanet : Model -> Planet -> Html Msg
viewPlanet model planet =
    div [ class "destination" ]
        [ div [ class "planet-image" ]
            [ img [ src ("./src/assets/destination/image-" ++ planet.name ++ ".png"), alt planet.name ] []
            ]
        , ul [ class "planets-list" ]
            [ li [ class "planet", class (isMoon model) ]
                [ button [ onClick GetMoon ] [ text "moon" ]
                ]
            , li [ class "planet", class (isMars model) ]
                [ button [ onClick GetMars ] [ text "mars" ]
                ]
            , li [ class "planet", class (isEuropa model) ]
                [ button [ onClick GetEuropa ] [ text "europa" ]
                ]
            , li [ class "planet", class (isTitan model) ]
                [ button [ onClick GetTitan ] [ text "titan" ]
                ]
            ]
        , div [ class "planet-info" ]
            [ h2 [ class "chosen-planet" ] [ text planet.name ]
            , p [ class "planet-description" ] [ text planet.description ]
            ]
        , div [ class "planet-stats" ]
            [ p [ class "distance" ] [ text "avg. distance", span [] [ text planet.distance ] ]
            , p [ class "travel-time" ] [ text "est. travel time", span [] [ text planet.travel ] ]
            ]
        ]



-- HTTP REQUESTS


getPlanetData : Cmd Msg
getPlanetData =
    Http.get
        { url = "./data.json"
        , expect = Http.expectJson GotData dataDecoder
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- SET ACTIVE CLASS


isMoon : Model -> String
isMoon model =
    if model.isMoon == True then
        "active"

    else
        ""


isMars : Model -> String
isMars model =
    if model.isMars == True then
        "active"

    else
        ""


isEuropa : Model -> String
isEuropa model =
    if model.isEuropa == True then
        "active"

    else
        ""


isTitan : Model -> String
isTitan model =
    if model.isTitan == True then
        "active"

    else
        ""
