module Main exposing (..)
import Html exposing (Html, Attribute, div, input, text, ul, li)
import Html.Events exposing (onInput)
import Html.Attributes exposing (id, placeholder)
import Html.App
import String
import Random exposing (Seed, initialSeed, step)

init : (Int, Cmd Msg)
init = (1, Cmd.none)

randomSequence : Int -> List Int
randomSequence int = 
    let gen = Random.list 10 (Random.int 0 100)
        s = initialSeed int
        (res, ns) = step gen s
    in res

type Msg = SetSeed String 

listItem : a -> Html Msg
listItem item = li [] [text (toString item)]

view : Int -> Html Msg
view seed =
    div [id "container"]
        [ div [id "inputBox"]
            [ input [placeholder "Enter a seed.", onInput SetSeed ] [] 
            ]
        , div [id "outputBox"] 
            [ text "Output:" 
            , ul [] (List.map listItem ( randomSequence seed))  ]
        ]

update : Msg -> Int -> ( Int, Cmd Msg) 
update msg _ =
    case msg of
        SetSeed newValue ->
            ( String.toInt newValue |> Result.toMaybe |> Maybe.withDefault 1, Cmd.none )
        
subscriptions : Int -> Sub Msg
subscriptions seed = Sub.none

main : Program Never
main = 
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

