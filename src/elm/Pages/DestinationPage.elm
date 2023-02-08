module Pages.DestinationPage exposing (Model, Msg, init, subscriptions, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)



-- MODEL


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view _ =
    main_ [ class "main main--destination" ]
        [ h1 [ class "primary-heading" ] [ span [] [ text "01" ], text "Pick your destination" ]
        , div [ class "planet-image" ]
            [ img [ src "./src/assets/destination/image-moon.png", alt "The moon" ] []
            ]
        , ul [ class "planets-list" ]
            [ li [ class "planet" ]
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
            [ p [ class "distance" ] [ text "avg. distance", span [] [ text "384,400" ] ]
            , p [ class "travel-time" ] [ text "est. travel time", span [] [ text "3 days" ] ]
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
