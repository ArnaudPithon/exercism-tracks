import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  let #(alpha, num) = place_location
  #(num, alpha)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  place_location_to_treasure_location(place_location) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  let there = place_location_to_treasure_location(place.1)
  list.count(treasures, fn(t) { t.1 == there })
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  case place.0 {
    "Abandoned Lighthouse" -> found_treasure.0 == "Brass Spyglass"
    "Stormy Breakwater" ->
      found_treasure.0 == "Amethyst Octopus"
      && desired_treasure.0 == "Crystal Crab"
      || desired_treasure.0 == "Glass Starfish"
    "Harbor Managers Office" ->
      found_treasure.0 == "Vintage Pirate Hat"
      && desired_treasure.0 == "Model Ship in Large Bottle"
      || desired_treasure.0 == "Antique Glass Fishnet Float"
    _ -> False
  }
}
