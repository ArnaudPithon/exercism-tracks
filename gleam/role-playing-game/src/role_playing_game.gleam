import gleam/int
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

fn clamp_to_zero(value: Int) -> Int {
  int.max(value, 0)
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  let #(mana, health, damage) = case player.mana {
    Some(mana) if mana >= cost -> #(Some(mana - cost), player.health, cost * 2)
    // mana insuffisante -> 0 dégats
    Some(_) -> #(player.mana, player.health, 0)
    // pas de mana -> coût imputé à la santé
    None -> {
      let new_health = clamp_to_zero(player.health - cost)
      #(None, new_health, 0)
    }
  }

  #(Player(..player, health: health, mana: mana), damage)
}
