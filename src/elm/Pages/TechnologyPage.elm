module Pages.TechnologyPage exposing (..)

import Decoders exposing (..)
import ErrorHandling exposing (buildErrorMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)



-- MODEL


type alias Model =
    { --     techData : List CrewMember
      -- , currentCrewMember : String
      -- , isLaunchVehicle : Bool
      -- , isSpacePort : Bool
      -- , isSpaceCapsule : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { --     techData = []
        --   , currentTech = "Launch vehicle"
        --   , isLaunchVehicle = True
        --   , isSpacePort = False
        --   , isSpaceCapsule = False
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = GetDouglas


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetDouglas ->
            -- ( { model | currentCrewMember = "Douglas Hurley", isDouglas = True, isMark = False, isVictor = False, isAnousheh = False }, Cmd.none )
            ( model, Cmd.none )



-- VIEW


view : Model -> Data -> Html Msg
view model data =
    main_ [ class "main main--crew" ]
        [ h1 [ class "secondary-heading" ] [ span [] [ text "02" ], text "meet your crew" ]
        , viewTech model

        -- , renderCrewMember model data.crew model.currentCrewMember
        ]



-- VIEW FUNCTIONS
-- renderCrewMember : Model -> List CrewMember -> String -> Html Msg
-- renderCrewMember model members memberName =
--     if memberName == "Douglas Hurley" then
--         viewCrewMember model (getSpecificCrewMember members "Douglas Hurley")
--     else if memberName == "Mark Shuttleworth" then
--         viewCrewMember model (getSpecificCrewMember members "Mark Shuttleworth")
--     else if memberName == "Victor Glover" then
--         viewCrewMember model (getSpecificCrewMember members "Victor Glover")
--     else if memberName == "Anousheh Ansari" then
--         viewCrewMember model (getSpecificCrewMember members "Anousheh Ansari")
--     else
--         viewCrewMember model loadingCrewMember


getSpecificCrewMember : List CrewMember -> String -> CrewMember
getSpecificCrewMember crew memberName =
    let
        members =
            List.filter (\member -> member.name == memberName) crew

        crewMember =
            getFirstMember members
    in
    crewMember


getFirstMember : List CrewMember -> CrewMember
getFirstMember list =
    case List.head list of
        Just data ->
            data

        Nothing ->
            loadingCrewMember


loadingCrewMember : CrewMember
loadingCrewMember =
    { name = "Loading..."
    , images = { png = "Loading...", webp = "Loading..." }
    , role = "Loading..."
    , bio = "Loading..."
    }



-- viewTech : Model -> CrewMember -> Html Msg


viewTech : Model -> Html Msg
viewTech _ =
    div [ class "technology-page" ]
        [ text "Hello Technology Page"
        ]



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
-- isDouglas : Model -> String
-- isDouglas model =
--     if model.isDouglas == True then
--         "active"
--     else
--         ""
-- isMark : Model -> String
-- isMark model =
--     if model.isMark == True then
--         "active"
--     else
--         ""
-- isVictor : Model -> String
-- isVictor model =
--     if model.isVictor == True then
--         "active"
--     else
--         ""
-- isAnousheh : Model -> String
-- isAnousheh model =
--     if model.isAnousheh == True then
--         "active"
--     else
--         ""
