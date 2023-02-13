module Pages.CrewPage exposing (Model, Msg, init, subscriptions, update, view)

import Decoders exposing (..)
import ErrorHandling exposing (buildErrorMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import Http



-- MODEL


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp



-- | GotData (Result Http.Error Data)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- GotData result ->
        --     case result of
        --         Ok data ->
        --             ( { model | planetData = data.destinations }, Cmd.none )
        --         Err error ->
        --             ( { model | errorMessages = Just (buildErrorMessage error) }, Cmd.none )
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    main_ [ class "main main--crew" ]
        [ h1 [ class "secondary-heading" ] [ span [] [ text "02" ], text "meet your crew" ]
        , viewCrewMember model
        ]


viewCrewMember : Model -> Html Msg
viewCrewMember _ =
    div [ class "crew-page" ]
        [ div [ class "crew-image" ]
            [ img [ src "./src/assets/crew/image-douglas-hurley.png", alt "crew member" ] []
            ]
        , div [ class "crew-member-list" ]
            [ li [ class "crew-member active" ]
                [ button [ class "dot" ]
                    [ span [ class "sr-only" ] [ text "commander" ]
                    ]
                ]
            , li [ class "crew-member" ]
                [ button [ class "dot" ]
                    [ span [ class "sr-only" ] [ text "Mission Specialist" ]
                    ]
                ]
            , li [ class "crew-member" ]
                [ button [ class "dot" ]
                    [ span [ class "sr-only" ] [ text "pilot" ]
                    ]
                ]
            , li [ class "crew-member" ]
                [ button [ class "dot" ]
                    [ span [ class "sr-only" ] [ text "Flight Engineer" ]
                    ]
                ]
            ]
        , div [ class "crew-member-info" ]
            [ h2 [ class "title is-cap" ] [ text "commander" ]
            , p [ class "name" ] [ text "Douglas Hurley" ]
            , p [ class "description" ] [ text "Douglas Gerald Hurley is an American engineer, former Marine Corps pilot and former NASA astronaut. He launched into space for the third time as commander of Crew Dragon Demo-2." ]
            ]
        ]



-- HTTP REQUESTS
-- getCrewData : Cmd Msg
-- getCrewData =
--     Http.get
--         { url = "./data.json"
--         , expect = Http.expectJson GotData dataDecoder
--         }
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- SET ACTIVE CLASS
-- DECODERS
