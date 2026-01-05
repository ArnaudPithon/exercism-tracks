import gleam/list
import gleam/result
import gleam/string

pub type Nucleotide {
  A
  C
  G
  T
  U
}

fn grapheme_to_nucleotide(grapheme: String) -> Result(Nucleotide, Nil) {
  case grapheme {
    "A" -> Ok(A)
    "C" -> Ok(C)
    "G" -> Ok(G)
    "T" -> Ok(T)
    "U" -> Ok(U)
    _ -> Error(Nil)
  }
}

fn nucleotide_to_grapheme(nucleotide: Nucleotide) -> String {
  case nucleotide {
    A -> "A"
    C -> "C"
    G -> "G"
    T -> "T"
    U -> "U"
  }
}

fn conv(nucleotide: Nucleotide) -> Result(Nucleotide, Nil) {
  case nucleotide {
    G -> Ok(C)
    C -> Ok(G)
    T -> Ok(A)
    A -> Ok(U)
    _ -> Error(Nil)
  }
}

pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna
  |> string.to_graphemes()
  |> list.try_map(grapheme_to_nucleotide)
  |> result.try(list.try_map(_, conv))
  |> result.map(list.map(_, nucleotide_to_grapheme))
  |> result.map(string.join(_, ""))
}
