import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  simplifile.read(path)
  |> result.map(fn(contents) { string.trim(contents) |> string.split("\n") })
  |> result.replace_error(Nil)
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  case simplifile.verify_is_file(path) {
    Ok(True) -> Ok(Nil)
    Ok(False) -> simplifile.create_file(path) |> result.replace_error(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  create_log_file(path)
  |> result.try(fn(_) {
    simplifile.append(to: path, contents: email <> "\n")
    |> result.replace_error(Nil)
  })
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  create_log_file(log_path)
  |> result.try(fn(_) { read_emails(emails_path) })
  |> result.try(fn(emails_list) {
    list.map(emails_list, fn(email) {
      send_email(email)
      |> result.try(fn(_) { log_sent_email(log_path, email) })
      |> result.lazy_or(fn() { Ok(Nil) })
    })
    |> result.all()
    |> result.replace(Nil)
  })
}
