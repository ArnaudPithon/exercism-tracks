pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [n, ..] -> n
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [n, ..rest] -> [n + 1, ..rest]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [] -> False
    [d, ..] if d == 0 -> True
    [_, ..rest] -> has_day_without_birds(rest)
  }
}

pub fn total(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [d, ..rest] -> d + total(rest)
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [d, ..rest] if d >= 5 -> 1 + busy_days(rest)
    [_, ..rest] -> busy_days(rest)
  }
}
