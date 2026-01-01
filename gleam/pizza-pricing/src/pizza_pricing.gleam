pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(pizza) -> pizza_price(pizza) + 1
    ExtraToppings(pizza) -> pizza_price(pizza) + 2
  }
}

fn order_price_loop(order: List(Pizza), total: Int, count: Int) -> Int {
  case order {
    [pizza, ..rest] ->
      order_price_loop(rest, total + pizza_price(pizza), count + 1)
    [] ->
      case count {
        1 -> total + 3
        2 -> total + 2
        _ -> total
      }
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  order_price_loop(order, 0, 0)
}
