import gleam/float

const outer = 10.0

const middle = 5.0

const inner = 1.0

fn distance(x: Float, y: Float) -> Result(Float, Nil) {
  float.square_root(x *. x +. y *. y)
}

pub fn score(x: Float, y: Float) -> Int {
  case distance(x, y) {
    Ok(d) if d <=. inner -> 10
    Ok(d) if d <=. middle -> 5
    Ok(d) if d <=. outer -> 1
    _ -> 0
  }
}
