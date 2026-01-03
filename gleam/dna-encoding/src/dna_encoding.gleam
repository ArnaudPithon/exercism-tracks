import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  case dna {
    [name, ..rest] -> <<
      encode_nucleotide(name):2,
      encode(rest):bits,
    >>
    [] -> <<>>
  }
}

fn chunk_dna(dna dna: BitArray, accu acc: List(Int)) -> Result(List(Int), Nil) {
  case dna {
    <<code:2, rest:bits>> -> chunk_dna(dna: rest, accu: [code, ..acc])
    <<>> -> Ok(list.reverse(acc))
    _ -> Error(Nil)
  }
}

fn decode_sequence(sequence: List(Int)) -> Result(List(Nucleotide), Nil) {
  list.map(sequence, with: decode_nucleotide)
  |> result.all()
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  chunk_dna(dna: dna, accu: []) |> result.try(decode_sequence)
}
