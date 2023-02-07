module Pages.HomePage exposing (Model, Msg, init, subscriptions, update, view)

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
    main_ [ class "main main--homepage" ]
        [ div [ class "homepage" ]
            [ div [ class "text-content" ]
                [ h1 [ class "primary-heading" ]
                    [ span [] [ text "so, you want to travel to" ]
                    , text "space"
                    ]
                , p [ class "primary-text" ] [ text "Let's face it; if you want to go to space, you might as well genuinely go to outer space and not hover kind of on the edge of it. Well sit back, and relax because we’ll give you a truly out of this world experience!" ]
                ]
            , button [ class "homepage-button" ] [ text "explore" ]
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
