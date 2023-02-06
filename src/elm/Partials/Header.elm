module Partials.Header exposing (Model, Msg, init, subscriptions, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)



-- MODEL


type alias Model =
    { menuIsExpanded : String
    , imageSrc : String
    }


init : Model
init =
    { menuIsExpanded = "false"
    , imageSrc = "./src/assets/shared/icon-hamburger.svg"
    }



-- UPDATE


type Msg
    = HamburgerMenuClicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HamburgerMenuClicked ->
            ( { model | menuIsExpanded = toggleMenu model, imageSrc = toggleImage model }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    header [ class "header center" ]
        [ div [ class "logo" ]
            [ img [ src "./src/assets/shared/logo.svg", alt "Space Tourism" ] []
            ]
        , nav [ class "navbar", role "navigation", ariaLabel "Main Menu" ]
            [ button [ onClick HamburgerMenuClicked, class "hamburger-menu", ariaExpanded model.menuIsExpanded ]
                [ img [ src model.imageSrc, alt "", ariaHidden True ] []
                , span [ class "sr-only" ] [ text "Menu" ]
                ]
            , ul [ class "nav-items" ]
                [ li [ class "nav-item active" ] [ a [ href "/" ] [ span [] [ text "00" ], text "home" ] ]
                , li [ class "nav-item" ] [ a [ href "/destination" ] [ span [] [ text "01" ], text "destination" ] ]
                , li [ class "nav-item" ] [ a [ href "/crew" ] [ span [] [ text "02" ], text "crew" ] ]
                , li [ class "nav-item" ] [ a [ href "/technology" ] [ span [] [ text "03" ], text "technology" ] ]
                ]
            ]
        ]


toggleMenu : Model -> String
toggleMenu model =
    if model.menuIsExpanded == "false" then
        "true"

    else
        "false"


toggleImage : Model -> String
toggleImage model =
    if model.imageSrc == "./src/assets/shared/icon-hamburger.svg" then
        "./src/assets/shared/icon-close.svg"

    else
        "./src/assets/shared/icon-hamburger.svg"



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
