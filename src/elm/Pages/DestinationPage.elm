module Pages.DestinationPage exposing (Model, Msg, init, subscriptions, update, view)

import Decoders exposing (..)
import ErrorHandling exposing (buildErrorMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)



-- MODEL


type alias Model =
    { planetData : List Planet
    , errorMessages : Maybe String
    , currentPlanetString : String
    , isMoon : Bool
    , isMars : Bool
    , isEuropa : Bool
    , isTitan : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { planetData = []
      , errorMessages = Nothing
      , currentPlanetString = "Moon"
      , isMoon = True
      , isMars = False
      , isEuropa = False
      , isTitan = False
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = GetMoon
    | GetMars
    | GetEuropa
    | GetTitan


update : Msg -> Model -> ( Model, Cmd.Cmd Msg )
update msg model =
    case msg of
        GetMoon ->
            ( { model | currentPlanetString = "Moon", isMoon = True, isMars = False, isEuropa = False, isTitan = False }, Cmd.none )

        GetMars ->
            ( { model | currentPlanetString = "Mars", isMoon = False, isMars = True, isEuropa = False, isTitan = False }, Cmd.none )

        GetEuropa ->
            ( { model | currentPlanetString = "Europa", isMoon = False, isMars = False, isEuropa = True, isTitan = False }, Cmd.none )

        GetTitan ->
            ( { model | currentPlanetString = "Titan", isMoon = False, isMars = False, isEuropa = False, isTitan = True }, Cmd.none )



-- VIEW


view : Model -> Data -> Html Msg
view model data =
    main_
        [ class "main main--destination" ]
        [ h1 [ class "secondary-heading" ] [ span [] [ text "01" ], text "Pick your destination" ]
        , renderPlanet model data.destinations model.currentPlanetString
        ]


renderPlanet : Model -> List Planet -> String -> Html Msg
renderPlanet model planets planet =
    if planet == "Moon" then
        viewPlanet model (getSpecificPlanet planets "Moon")

    else if planet == "Mars" then
        viewPlanet model (getSpecificPlanet planets "Mars")

    else if planet == "Europa" then
        viewPlanet model (getSpecificPlanet planets "Europa")

    else if planet == "Titan" then
        viewPlanet model (getSpecificPlanet planets "Titan")

    else
        viewPlanet model loadingPlanet


getFirstPlanet : List Planet -> Planet
getFirstPlanet list =
    case List.head list of
        Just data ->
            data

        Nothing ->
            loadingPlanet


getSpecificPlanet : List Planet -> String -> Planet
getSpecificPlanet planets keyWord =
    let
        currentPlanetList =
            List.filter (\planet -> planet.name == keyWord) planets

        currentPlanet =
            getFirstPlanet currentPlanetList
    in
    currentPlanet


loadingPlanet : Planet
loadingPlanet =
    { name = "Loading..."
    , images = { png = "Loading...", webp = "Loading..." }
    , description = "Loading..."
    , distance = "Loading..."
    , travel = "Loading..."
    }


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
