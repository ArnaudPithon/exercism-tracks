import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(name) -> name
    None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health {
    health if health > 0 -> None
    _ ->
      case player.level {
        level if level < 10 -> Some(Player(..player, health: 100))
        _ -> Some(Player(..player, health: 100, mana: Some(100)))
      }
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  let damage = case player.mana {
    Some(mana) if mana >= cost -> cost * 2
    _ -> 0
  }

  let mana = case player.mana {
    Some(mana) if mana >= cost -> Some(mana - cost)
    Some(mana) -> Some(mana)
    None -> None
  }

  let health = case player.mana {
    Some(_) -> player.health
    None ->
      case player.health {
        health if health > cost -> player.health - cost
        _ -> 0
      }
  }

  let wizard = Player(..player, health: health, mana: mana)
  #(wizard, damage)
}
