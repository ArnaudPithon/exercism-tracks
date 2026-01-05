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
  |> list.map(fn(n) { grapheme_to_nucleotide(n) })
  |> result.all()
  |> result.try(fn(a) { list.try_map(a, fn(b) { conv(b) }) })
  |> result.map(fn(x) { list.map(x, fn(x) { nucleotide_to_grapheme(x) }) })
  |> result.map(fn(x) { string.join(x, "") })
}
