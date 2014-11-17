signature REGEX =
sig
  datatype regex = One
                 | Char of char
                 | Times of regex * regex
                 | Plus of regex * regex
                 | Star of regex
                 | Wild
                 | Both of regex * regex

  val match: regex -> char list -> (char list -> bool) -> bool
  val accept: regex -> string -> bool
end
