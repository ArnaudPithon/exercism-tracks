import gleam/list
import gleam/result
import gleam/string

fn conv(nucleotide: String) -> Result(String, Nil) {
  case nucleotide {
    "G" -> Ok("C")
    "C" -> Ok("G")
    "T" -> Ok("A")
    "A" -> Ok("U")
    _ -> Error(Nil)
  }
}

pub fn to_rna(dna: String) -> Result(String, Nil) {
  string.to_graphemes(dna)
  |> list.try_map(conv)
  |> result.map(string.join(_, with: ""))
}
