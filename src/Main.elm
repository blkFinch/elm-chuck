import Html exposing (..)
import Http
import Browser exposing(..)
import Html.Events exposing (..)
import Html.Attributes exposing(..)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { quote : String
    }


type Msg
    = GetQuote
    | FetchRandomQuoteCompleted ( Result Http.Error String )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GetQuote ->
            ( model, fetchRandomQuoteCmd )

        FetchRandomQuoteCompleted result ->
            fetchRandomQuoteCompleted model result

-- defining api urls
api : String
api =
    "http://localhost:3001/"

randomQuoteUrl : String
randomQuoteUrl =
    api ++ "api/random-quote"

-- fetch random quote
fetchRandomQuote : Http.Request String
fetchRandomQuote =
    Http.getString randomQuoteUrl

fetchRandomQuoteCmd : Cmd Msg
fetchRandomQuoteCmd =
    Http.send FetchRandomQuoteCompleted fetchRandomQuote

fetchRandomQuoteCompleted : Model -> Result Http.Error String -> (Model, Cmd Msg)
fetchRandomQuoteCompleted model result =
    case result of
        Ok newQuote ->
            ({model | quote = newQuote }, Cmd.none )

        Err _ ->
            ( model, Cmd.none )


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
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : () -> (Model, Cmd Msg)
init _ =
   ( Model "", fetchRandomQuoteCmd )
