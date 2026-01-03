import gleam/string

pub opaque type TreasureChest(content) {
  TreasureChest(password: String, treasure: content)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  case string.length(password) >= 8 {
    True -> Ok(TreasureChest(password: password, treasure: contents))
    False -> Error("Password must be at least 8 characters long")
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  case password == chest.password {
    True -> Ok(chest.treasure)
    False -> Error("Incorrect password")
  }
}
