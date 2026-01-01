import gleam/string

pub fn message(log_line: String) -> String {
  string.crop(log_line, before: " ")
  |> string.trim()
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[INFO]" <> _ -> "info"
    "[WARNING]" <> _ -> "warning"
    _ -> "error"
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
