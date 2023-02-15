module Helpers exposing (toSlug)


toSlug : String -> String
toSlug input =
    input
        |> String.toLower
        |> String.replace " " "-"
