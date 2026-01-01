import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

fn switch_player(game: Game) {
  let switch = fn(player) {
    case player {
      Black -> White
      White -> Black
    }
  }

  case game.error {
    "" -> Game(..game, player: switch(game.player))
    _ -> game
  }
}

fn unwrap(r: Result(Game, String), game: Game) -> Game {
  case r {
    Error(message) -> Game(..game, error: message)
    Ok(game) -> game
  }
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  rule2(game)
  |> rule1()
  |> result.try(rule3)
  |> result.try(rule4)
  |> unwrap(game)
  |> switch_player()
}
