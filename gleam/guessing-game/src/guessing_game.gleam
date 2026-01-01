pub fn reply(guess: Int) -> String {
  case guess {
    i if i < 41 -> "Too low"
    i if i > 43 -> "Too high"
    41 | 43 -> "So close"
    _ -> "Correct"
  }
}
