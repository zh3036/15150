structure CookingTest =
struct
  open Cooking

  (* the recipes *)
  val lasagna   = ("lasagna",  ["pasta", "bechamel", "meat",
                                 "bolognese", "parmesan"])
  val pasta     = ("pasta",     ["flour", "egg"])
  val bechamel  = ("bechamel",  ["flour", "butter", "milk", "pepper"])
  val bolognese = ("bolognese", ["tomato", "onion", "pepper", "secret"])
  val secret    = ("secret",    ["balsamic", "parsley", "mozzarella"])

  (* The cookbook *)
  val italianCookbook = [lasagna, pasta, bechamel, bolognese, secret]

  (* Two different fridges *)
  val bigFridge   = ["flour", "egg", "milk", "butter", "pepper", "tomato",
                     "onion", "balsamic", "parsley", "meat", "parmesan"]
  val smallFridge = ["pasta", "bolognese", "meat", "parmesan", "flour",
                     "milk", "butter", "pepper"]
end (* structure CookingTest *)
