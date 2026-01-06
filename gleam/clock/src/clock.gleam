import gleam/int
import gleam/string

// Afin de s'épargner des calcurs laborieux, il faut ne manipuler que
// des minutes (la plus petite unité).
// - conversion heures + minutes -> minutes
// - ajout ou soustraction des minutes
// - si le total est négatif -> ajouter des minutes par tranches de 24h
//   jusqu'à repasser en positif
// - conversion finale minutes -> heures + minutes

pub type Clock {
  Clock(hour: Int, minute: Int)
}

fn loop(m: Int) -> Int {
  case m < 0 {
    True -> loop(m + 24 * 60)
    False -> m
  }
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  let total = loop(hour * 60 + minute)
  let hour = { total / 60 } % 24
  let minute = total % 60

  Clock(hour, minute)
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  create(hour: clock.hour, minute: clock.minute + minutes)
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  create(hour: clock.hour, minute: clock.minute - minutes)
}

fn format(number: Int) -> String {
  number
  |> int.to_string
  |> string.pad_start(to: 2, with: "0")
}

pub fn display(clock: Clock) -> String {
  let hour = format(clock.hour)
  let minute = format(clock.minute)

  hour <> ":" <> minute
}
