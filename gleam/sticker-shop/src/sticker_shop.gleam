import gleam/list.{fold}

/// phantom types whithout constructors
pub type Usd

pub type Eur

pub type Jpy

/// opaque type with currency phantom parameter
pub opaque type Money(currency) {
  Money(amount: Int)
}

pub fn dollar(amount: Int) -> Money(Usd) {
  let _: Money(Usd) = Money(amount)
}

pub fn euro(amount: Int) -> Money(Eur) {
  let _: Money(Eur) = Money(amount)
}

pub fn yen(amount: Int) -> Money(Jpy) {
  let _: Money(Jpy) = Money(amount)
}

pub fn total(prices: List(Money(currency))) -> Money(currency) {
  prices
  |> fold(Money(0), fn(a, b) { Money(a.amount + b.amount) })
}
