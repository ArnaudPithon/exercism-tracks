import gleam/list

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
    [nucleotide] -> <<encode_nucleotide(nucleotide):2>>
    [nucleotide, ..rest] -> <<
      encode_nucleotide(nucleotide):2,
      encode(rest):bits,
    >>
    [] -> <<>>
  }
}

fn decode_loop(dna: BitArray) -> List(Nucleotide) {
  case dna {
    <<value:2>> ->
      case decode_nucleotide(value) {
        Ok(name) -> [name]
        Error(Nil) -> []
      }
    <<value:2, rest:bits>> ->
      list.append(
        case decode_nucleotide(value) {
          Ok(name) -> [name]
          Error(Nil) -> []
        },
        decode_loop(rest),
      )
    _ -> []
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  let result = decode_loop(dna)
  case result {
    [_, ..] -> Ok(result)
    [] -> Error(Nil)
  }
}
