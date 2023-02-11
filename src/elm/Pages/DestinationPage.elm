module Pages.DestinationPage exposing (Model, Msg, getPlanetData, init, subscriptions, update, view)

import ErrorHandling exposing (buildErrorMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as D



-- MODEL


type alias Model =
    { planetData : Data
    , errorMessages : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { planetData =
            { destinations = []
            }
      , errorMessages = Nothing
      }
    , getPlanetData
    )



-- UPDATE


type Msg
    = GotData (Result Http.Error Data)


update : Msg -> Model -> ( Model, Cmd.Cmd Msg )
update msg model =
    case msg of
        GotData result ->
            case result of
                Ok data ->
                    ( { model | planetData = data }, Cmd.none )

                Err error ->
                    Debug.log (Debug.toString error)
                        ( { model | errorMessages = Just (buildErrorMessage error) }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    main_ [ class "main main--destination" ]
        [ h1 [ class "secondary-heading" ] [ span [] [ text "01" ], text "Pick your destination" ]
        , div [ class "destination" ]
            [ div [ class "planet-image" ]
                [ img [ src "./src/assets/destination/image-moon.png", alt "The moon" ] []
                ]
            , ul [ class "planets-list" ]
                [ li [ class "planet active" ]
                    [ button [] [ text "moon" ]
                    ]
                , li [ class "planet" ]
                    [ button [] [ text "mars" ]
                    ]
                , li [ class "planet" ]
                    [ button [] [ text "europa" ]
                    ]
                , li [ class "planet" ]
                    [ button [] [ text "titan" ]
                    ]
                ]
            , div [ class "planet-info" ]
                [ h2 [ class "chosen-planet" ] [ text "moon" ]
                , p [ class "planet-description" ] [ text "See our planet as you've never seen it before. A perfect relaxing trip away to help regain perspective and come back refreshed. While you're there, take in some history by visiting the Luna 2 and Apollo 11 landing sites." ]
                ]
            , div [ class "planet-stats" ]
                [ p [ class "distance" ] [ text "avg. distance", span [] [ text "384,400 KM" ] ]
                , p [ class "travel-time" ] [ text "est. travel time", span [] [ text "3 days" ] ]
                ]
            ]

        -- , case model.errorMessages of
        --     Just error ->
        --         p [] [ text error ]
        --     Nothing ->
        --         div [] []
        ]


defaultPlanet : Planet
defaultPlanet =
    { name = "Error"
    , images = { png = "Error", webp = "Error" }
    , description = "Error"
    , distance = "Error"
    , travel = "Error"
    }


getDestinationsData : Model -> Planet
getDestinationsData model =
    case List.head model.planetData.destinations of
        Just data ->
            data

        Nothing ->
            defaultPlanet



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



-- DATA.JSON DECODER


type alias Data =
    { destinations : List Planet
    }


dataDecoder : D.Decoder Data
dataDecoder =
    D.map Data
        (D.field "destinations" <| D.list <| planetDecoder)



-- DESTINATION DATA DECODERS


type alias Planet =
    { name : String
    , images : Images
    , description : String
    , distance : String
    , travel : String
    }


type alias Images =
    { png : String
    , webp : String
    }


imagesDecoder : D.Decoder Images
imagesDecoder =
    D.map2 Images
        (D.field "png" D.string)
        (D.field "webp" D.string)


planetDecoder : D.Decoder Planet
planetDecoder =
    D.map5 Planet
        (D.field "name" D.string)
        (D.field "images" imagesDecoder)
        (D.field "description" D.string)
        (D.field "distance" D.string)
        (D.field "travel" D.string)
