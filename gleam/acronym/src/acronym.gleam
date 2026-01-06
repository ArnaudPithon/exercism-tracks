import gleam/list
import gleam/regexp.{check, from_string}
import gleam/result
import gleam/string

fn normalize(phrase: String) -> String {
  let assert Ok(is_alpha_or_space) = from_string("[ A-Z]")

  phrase
  |> string.uppercase()
  |> string.replace(each: "-", with: " ")
  |> string.to_graphemes()
  |> list.filter(check(with: is_alpha_or_space, content: _))
  |> string.join(with: "")
}

fn cutout(phrase: String) -> List(String) {
  phrase
  |> string.split(on: " ")
  |> list.filter(fn(x) { x != "" })
}

fn build_acronym(words: List(String)) -> Result(String, Nil) {
  words
  |> list.try_map(string.first)
  |> result.map(string.join(_, with: ""))
}

pub fn abbreviate(phrase phrase: String) -> String {
  phrase
  |> normalize()
  |> cutout()
  |> build_acronym()
  |> result.unwrap(or: "Error")
}
