import gleam/option.{type Option, None, Some}

pub fn two_fer(name: Option(String)) -> String {
  let subject = case name {
    Some(s) -> s
    None -> "you"
  }

  "One for " <> subject <> ", one for me."
}
