import gleam/int
import gleam/list

pub type Allergen {
  Eggs
  Peanuts
  Shellfish
  Strawberries
  Tomatoes
  Chocolate
  Pollen
  Cats
}

const allergens = [
  Eggs,
  Peanuts,
  Shellfish,
  Strawberries,
  Tomatoes,
  Chocolate,
  Pollen,
  Cats,
]

pub fn allergic_to(allergen: Allergen, score: Int) -> Bool {
  let value = case allergen {
    Eggs -> 1
    Peanuts -> 2
    Shellfish -> 4
    Strawberries -> 8
    Tomatoes -> 16
    Chocolate -> 32
    Pollen -> 64
    Cats -> 128
  }
  int.bitwise_and(score, value) == value
}

pub fn list(score: Int) -> List(Allergen) {
  allergens
  |> list.filter(allergic_to(_, score))
}
