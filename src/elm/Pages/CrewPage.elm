module Pages.CrewPage exposing (Model, Msg, init, subscriptions, update, view)

import Decoders exposing (..)
import ErrorHandling exposing (buildErrorMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)



-- MODEL


type alias Model =
    { crewData : List CrewMember
    , currentCrewMember : String
    , isDouglas : Bool
    , isMark : Bool
    , isVictor : Bool
    , isAnousheh : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { crewData = []
      , currentCrewMember = "Douglas Hurley"
      , isDouglas = True
      , isMark = False
      , isVictor = False
      , isAnousheh = False
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = GetDouglas
    | GetMark
    | GetVictor
    | GetAnousheh


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetDouglas ->
            ( { model | currentCrewMember = "Douglas Hurley", isDouglas = True, isMark = False, isVictor = False, isAnousheh = False }, Cmd.none )

        GetMark ->
            ( { model | currentCrewMember = "Mark Shuttleworth", isDouglas = False, isMark = True, isVictor = False, isAnousheh = False }, Cmd.none )

        GetVictor ->
            ( { model | currentCrewMember = "Victor Glover", isDouglas = False, isMark = False, isVictor = True, isAnousheh = False }, Cmd.none )

        GetAnousheh ->
            ( { model | currentCrewMember = "Anousheh Ansari", isDouglas = False, isMark = False, isVictor = False, isAnousheh = True }, Cmd.none )



-- VIEW


view : Model -> Data -> Html Msg
view model data =
    main_ [ class "main main--crew" ]
        [ h1 [ class "secondary-heading" ] [ span [] [ text "02" ], text "meet your crew" ]
        , renderCrewMember model data.crew model.currentCrewMember
        ]



-- VIEW FUNCTIONS


renderCrewMember : Model -> List CrewMember -> String -> Html Msg
renderCrewMember model members memberName =
    if memberName == "Douglas Hurley" then
        viewCrewMember model (getSpecificCrewMember members "Douglas Hurley")

    else if memberName == "Mark Shuttleworth" then
        viewCrewMember model (getSpecificCrewMember members "Mark Shuttleworth")

    else if memberName == "Victor Glover" then
        viewCrewMember model (getSpecificCrewMember members "Victor Glover")

    else if memberName == "Anousheh Ansari" then
        viewCrewMember model (getSpecificCrewMember members "Anousheh Ansari")

    else
        viewCrewMember model loadingCrewMember


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


viewCrewMember : Model -> CrewMember -> Html Msg
viewCrewMember model member =
    div [ class "crew-page" ]
        [ div [ class "crew-image" ]
            [ img [ src ("./src/assets/crew" ++ "/image-" ++ toSlug member.name ++ ".png"), alt "crew member", width 597, height 645 ] []
            ]
        , ul [ class "crew-member-list" ]
            [ li [ class "crew-member", class (isDouglas model) ]
                [ button [ class "dot", onClick GetDouglas ]
                    [ span [ class "sr-only" ] [ text member.role ]
                    ]
                ]
            , li [ class "crew-member", class (isMark model) ]
                [ button [ class "dot", onClick GetMark ]
                    [ span [ class "sr-only" ] [ text member.role ]
                    ]
                ]
            , li [ class "crew-member", class (isVictor model) ]
                [ button [ class "dot", onClick GetVictor ]
                    [ span [ class "sr-only" ] [ text member.role ]
                    ]
                ]
            , li [ class "crew-member", class (isAnousheh model) ]
                [ button [ class "dot", onClick GetAnousheh ]
                    [ span [ class "sr-only" ] [ text member.role ]
                    ]
                ]
            ]
        , div [ class "crew-member-info" ]
            [ h2 [ class "title is-cap" ] [ text member.role ]
            , p [ class "name" ] [ text member.name ]
            , p [ class "description" ] [ text member.bio ]
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


isDouglas : Model -> String
isDouglas model =
    if model.isDouglas == True then
        "active"

    else
        ""


isMark : Model -> String
isMark model =
    if model.isMark == True then
        "active"

    else
        ""


isVictor : Model -> String
isVictor model =
    if model.isVictor == True then
        "active"

    else
        ""


isAnousheh : Model -> String
isAnousheh model =
    if model.isAnousheh == True then
        "active"

    else
        ""
