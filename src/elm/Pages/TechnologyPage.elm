module Pages.TechnologyPage exposing (..)

import Decoders exposing (..)
import ErrorHandling exposing (buildErrorMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)
import W3.Html exposing (toAttribute)
import W3.Html.Attributes exposing (srcset)



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
    main_ [ class "main main--technology" ]
        [ viewTech model

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
        -- Would like to try putting everything into a grid so the markup is a bit different, thus the -alternative else the secondary-heading rule I've created would apply to this
        [ h1 [ class "secondary-heading-alternative" ] [ span [] [ text "03" ], text "space launch 101" ]
        , div [ class "tech-image" ]
            [ Html.node "picture"
                []
                [ source [ media "(min-width: 1100px)", toAttribute (srcset [ "./src/assets/technology/image-launch-vehicle-portrait.jpg" ]) ] []
                , img [ src "./src/assets/technology/image-launch-vehicle-landscape.jpg", alt "space ship launch" ] []
                ]
            ]
        , ul [ class "tech-list" ]
            [ li [ class "tech" ]
                [ button [] [ text "1" ]
                ]
            , li [ class "tech" ]
                [ button [] [ text "2" ]
                ]
            , li [ class "tech" ]
                [ button [] [ text "3" ]
                ]
            ]
        , div [ class "tech-info" ]
            [ h2 [ class "title" ] [ text "THE TERMINOLOGY…" ]
            , p [ class "name" ] [ text "LAUNCH VEHICLE" ]
            , p [ class "description" ] [ text "A launch vehicle or carrier rocket is a rocket-propelled vehicle used to carry a payload from Earth's surface to space, usually to Earth orbit or beyond. Our WEB-X carrier rocket is the most powerful in operation. Standing 150 metres tall, it's quite an awe-inspiring sight on the launch pad!" ]
            ]
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
