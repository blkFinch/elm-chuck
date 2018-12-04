import Html exposing (..)
import Browser exposing(..)
import Html.Events exposing (..)
import Html.Attributes exposing(..)


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        -- , subscriptions = subscriptions
        }


type alias Model =
    { quote : String
    }


type Msg
    = GetQuote


update : Msg -> Model -> Model
update msg model =
    case msg of
        GetQuote ->
            { model | quote = model.quote ++ "A Quote goes here!" }
            --{ recordName | property = updatedValue, property2 = updatedValue2 }


view : Model -> Html Msg
view model =
    div [class "container"][
        h2[class "text-center"][text "An Elm Quote Retriever"]
        , p [ class "text-center"][
            button[ class "btn btn-info", onClick GetQuote][ text "Grab A Quote!"]
        ]
        , blockquote[][
            p [] [text model.quote]
        ]
    ]


-- not using subscriptions yet, remember to reassign
-- this value before using this function
-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     Sub.none


init : Model
init = 
    Model ""
