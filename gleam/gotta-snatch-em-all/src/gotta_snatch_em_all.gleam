import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  let owned = set.contains(collection, card)
  let new_collection = set.insert(collection, card)
  #(owned, new_collection)
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let doable =
    set.contains(collection, my_card) && !set.contains(collection, their_card)
  let new_collection =
    collection
    |> set.delete(my_card)
    |> set.insert(their_card)

  #(doable, new_collection)
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case
    collections
    |> list.reduce(set.intersection)
  {
    Ok(c) -> set.to_list(c) |> list.sort(string.compare)
    Error(_) -> []
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  case
    collections
    |> list.reduce(set.union)
  {
    Ok(c) -> set.size(c)
    Error(_) -> 0
  }
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  collection
  |> set.filter(fn(card) { string.starts_with(card, "Shiny ") })
}
