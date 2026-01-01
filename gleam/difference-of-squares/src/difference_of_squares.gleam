pub fn square_of_sum(n: Int) -> Int {
  sum_loop(n, 0)
  |> square()
}

pub fn sum_of_squares(n: Int) -> Int {
  sum_of_squares_loop(n, 0)
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}

fn square(n: Int) -> Int {
  n * n
}

fn sum_of_squares_loop(n: Int, accu: Int) -> Int {
  case n {
    0 -> accu
    _ -> sum_of_squares_loop(n - 1, accu + square(n))
  }
}

fn sum_loop(n: Int, accu: Int) -> Int {
  case n {
    0 -> accu
    _ -> sum_loop(n - 1, accu + n)
  }
}
