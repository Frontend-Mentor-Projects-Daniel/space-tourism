module Decoders exposing (..)

import Json.Decode as D



-- DATA.JSON DECODER


type alias Data =
    { destinations : List Planet
    }


dataDecoder : D.Decoder Data
dataDecoder =
    D.map Data
        (D.field "destinations" <| D.list <| planetDecoder)



-- DESTINATION DATA DECODERS


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
