module Pages.TechnologyPage exposing (..)

import Decoders exposing (..)
import ErrorHandling exposing (buildErrorMessage)
import Helpers exposing (toSlug)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import W3.Html exposing (toAttribute)
import W3.Html.Attributes exposing (srcset)



-- MODEL


type alias Model =
    { techData : List Tech
    , currentTech : String
    , isLaunchVehicle : Bool
    , isSpacePort : Bool
    , isSpaceCapsule : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { techData = []
      , currentTech = "Launch vehicle"
      , isLaunchVehicle = True
      , isSpacePort = False
      , isSpaceCapsule = False
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = GetLaunchVehicle
    | GetSpacePort
    | GetSpaceCapsule


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetLaunchVehicle ->
            ( { model | currentTech = "Launch vehicle", isLaunchVehicle = True, isSpaceCapsule = False, isSpacePort = False }, Cmd.none )

        GetSpacePort ->
            ( { model | currentTech = "Spaceport", isLaunchVehicle = False, isSpaceCapsule = False, isSpacePort = True }, Cmd.none )

        GetSpaceCapsule ->
            ( { model | currentTech = "Space capsule", isLaunchVehicle = False, isSpaceCapsule = True, isSpacePort = False }, Cmd.none )



-- VIEW


view : Model -> Data -> Html Msg
view model data =
    main_ [ class "main main--technology" ]
        [ renderTech model data.tech model.currentTech
        ]



-- VIEW FUNCTIONS


renderTech : Model -> List Tech -> String -> Html Msg
renderTech model tech techName =
    if techName == "Launch vehicle" then
        viewTech model (getSpecificTech tech "Launch vehicle")

    else if techName == "Spaceport" then
        viewTech model (getSpecificTech tech "Spaceport")

    else if techName == "Space capsule" then
        viewTech model (getSpecificTech tech "Space capsule")

    else
        viewTech model loadingTech


viewTech : Model -> Tech -> Html Msg
viewTech model data =
    div [ class "technology-page wrapper" ]
        -- Would like to try putting everything into a grid so the markup is a bit different, thus the -alternative else the secondary-heading rule I've created would apply to this
        [ h1 [ class "secondary-heading-alternative" ] [ span [] [ text "03" ], text "space launch 101" ]
        , div [ class "tech-image full-bleed" ]
            [ Html.node "picture"
                []
                [ source [ media "(min-width: 1100px)", toAttribute (srcset [ "./src/assets/technology/image-" ++ toSlug data.name ++ "-portrait.jpg" ]) ] []
                , img [ src ("./src/assets/technology/image-" ++ toSlug data.name ++ "-landscape.jpg"), alt data.name ] []
                ]
            ]
        , ul [ class "tech-list" ]
            [ li [ class "tech-list-item", class (isLaunchVehicle model) ]
                [ button [ onClick GetLaunchVehicle ] [ text "1" ]
                ]
            , li [ class "tech-list-item", class (isSpacePort model) ]
                [ button [ onClick GetSpacePort ] [ text "2" ]
                ]
            , li [ class "tech-list-item", class (isSpaceCapsule model) ]
                [ button [ onClick GetSpaceCapsule ] [ text "3" ]
                ]
            ]
        , div [ class "tech-info" ]
            [ h2 [ class "title" ] [ text "THE TERMINOLOGY…" ]
            , p [ class "name" ] [ text data.name ]
            , p [ class "description" ] [ text data.description ]
            ]
        ]


getSpecificTech : List Tech -> String -> Tech
getSpecificTech tech techName =
    let
        members =
            List.filter (\member -> member.name == techName) tech

        crewMember =
            getFirstMember members
    in
    crewMember


getFirstMember : List Tech -> Tech
getFirstMember list =
    case List.head list of
        Just data ->
            data

        Nothing ->
            loadingTech


loadingTech : Tech
loadingTech =
    { name = "Loading..."
    , images = { portrait = "Loading...", landscape = "Loading..." }
    , description = "Loading..."
    }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- HELPER FUNCTIONS


toSlug : String -> String
toSlug input =
    input
        |> String.toLower
        |> String.replace " " "-"



-- SET ACTIVE CLASS


isLaunchVehicle : Model -> String
isLaunchVehicle model =
    if model.isLaunchVehicle == True then
        "active"

    else
        ""


isSpacePort : Model -> String
isSpacePort model =
    if model.isSpacePort == True then
        "active"

    else
        ""


isSpaceCapsule : Model -> String
isSpaceCapsule model =
    if model.isSpaceCapsule == True then
        "active"

    else
        ""
