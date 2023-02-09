module Partials.Header exposing (Model, Msg, init, subscriptions, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)



-- MODEL


type alias Model =
    { menuIsExpanded : String
    , imageSrc : String
    , isHomePage : Bool
    , isDestinationPage : Bool
    , isCrewPage : Bool
    , isTechnologyPage : Bool
    }


init : Model
init =
    { menuIsExpanded = "false"
    , imageSrc = "./src/assets/shared/icon-hamburger.svg"
    , isHomePage = True
    , isDestinationPage = False
    , isCrewPage = False
    , isTechnologyPage = False
    }



-- UPDATE


type Msg
    = HamburgerMenuClicked
    | HomePageClicked
    | DestinationPageClicked
    | CrewPageClicked
    | TechnologyPageClicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HamburgerMenuClicked ->
            ( { model | menuIsExpanded = toggleMenu model, imageSrc = toggleImage model }, Cmd.none )

        HomePageClicked ->
            ( { model | isHomePage = True, isDestinationPage = False, isCrewPage = False, isTechnologyPage = False }, Cmd.none )

        DestinationPageClicked ->
            ( { model | isHomePage = False, isDestinationPage = True, isCrewPage = False, isTechnologyPage = False }, Cmd.none )

        CrewPageClicked ->
            ( { model | isHomePage = False, isDestinationPage = False, isCrewPage = True, isTechnologyPage = False }, Cmd.none )

        TechnologyPageClicked ->
            ( { model | isHomePage = False, isDestinationPage = False, isCrewPage = False, isTechnologyPage = True }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    header [ class "header" ]
        [ div [ class "logo" ]
            [ img [ src "./src/assets/shared/logo.svg", alt "Space Tourism" ] []
            ]
        , nav [ class "navbar", role "navigation", ariaLabel "Main Menu" ]
            [ button [ onClick HamburgerMenuClicked, class "hamburger-menu", ariaExpanded model.menuIsExpanded ]
                [ img [ src model.imageSrc, alt "", ariaHidden True ] []
                , span [ class "sr-only" ] [ text "Menu" ]
                ]
            , ul [ class "nav-items" ]
                [ li [ class "nav-item", class (setHomePage model) ] [ a [ href "/", onClick HomePageClicked ] [ span [] [ text "00" ], text "home" ] ]
                , li [ class "nav-item", class (setDestinationPage model) ] [ a [ href "/destination", onClick DestinationPageClicked ] [ span [] [ text "01" ], text "destination" ] ]
                , li [ class "nav-item", class (setCrewPage model) ] [ a [ href "/crew", onClick CrewPageClicked ] [ span [] [ text "02" ], text "crew" ] ]
                , li [ class "nav-item", class (setTechnologyPage model) ] [ a [ href "/technology", onClick TechnologyPageClicked ] [ span [] [ text "03" ], text "technology" ] ]
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


setHomePage : Model -> String
setHomePage model =
    if model.isHomePage == True then
        "active"

    else
        ""


setDestinationPage : Model -> String
setDestinationPage model =
    if model.isDestinationPage == True then
        "active"

    else
        ""


setCrewPage : Model -> String
setCrewPage model =
    if model.isCrewPage == True then
        "active"

    else
        ""


setTechnologyPage : Model -> String
setTechnologyPage model =
    if model.isTechnologyPage == True then
        "active"

    else
        ""



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
