module TicketPlease exposing (..)

import List
import TicketPleaseSupport exposing (Status(..), Ticket(..), User(..))


emptyComment : ( User, String ) -> Bool
emptyComment ( _, comment ) =
    comment == ""


numberOfCreatorComments : Ticket -> Int
numberOfCreatorComments (Ticket { createdBy, comments }) =
    let
        ( creator, _ ) =
            createdBy

        count pattern list =
            List.filter pattern list |> List.length
    in
    count (\( user, _ ) -> user == creator) comments


assignedToDevTeam : Ticket -> Bool
assignedToDevTeam (Ticket { assignedTo }) =
    case assignedTo of
        Just (User name) ->
            List.member name [ "Alice", "Bob", "Charlie" ]

        Nothing ->
            False


assignTicketTo : User -> Ticket -> Ticket
assignTicketTo user (Ticket ({ status } as ticket)) =
    case status of
        Archived ->
            Ticket ticket

        New ->
            Ticket { ticket | assignedTo = Just user, status = InProgress }

        _ ->
            Ticket { ticket | assignedTo = Just user }
