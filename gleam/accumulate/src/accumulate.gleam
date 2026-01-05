import gleam/list

fn loop(list: List(a), fun: fn(a) -> b, acc) -> List(b) {
  case list {
    [] -> acc
    [element, ..rest] -> loop(rest, fun, [fun(element), ..acc])
  }
}

pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  loop(list, fun, [])
  |> list.reverse()
}
