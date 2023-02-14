module Decoders exposing (..)

import Json.Decode as D



-- DATA.JSON DECODER


type alias Data =
    { destinations : List Planet
    , crew : List CrewMember
    , tech : List Tech
    }


dataDecoder : D.Decoder Data
dataDecoder =
    D.map3 Data
        (D.field "destinations" <| D.list <| planetDecoder)
        (D.field "crew" <| D.list <| crewDecoder)
        (D.field "technology" <| D.list <| technologyDecoder)



-- DESTINATION DECODERS


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



-- CREW DECODERS


type alias CrewMember =
    { name : String
    , images : Images
    , role : String
    , bio : String
    }


crewDecoder : D.Decoder CrewMember
crewDecoder =
    D.map4 CrewMember
        (D.field "name" D.string)
        (D.field "images" imagesDecoder)
        (D.field "role" D.string)
        (D.field "bio" D.string)



-- TECHNOLOGY DECODERS


type alias TechImages =
    { portrait : String
    , landscape : String
    }


type alias Tech =
    { name : String
    , images : TechImages
    , description : String
    }


techImagesDecoder : D.Decoder TechImages
techImagesDecoder =
    D.map2 TechImages
        (D.field "portrait" D.string)
        (D.field "landscape" D.string)


technologyDecoder : D.Decoder Tech
technologyDecoder =
    D.map3 Tech
        (D.field "name" D.string)
        (D.field "images" techImagesDecoder)
        (D.field "description" D.string)
