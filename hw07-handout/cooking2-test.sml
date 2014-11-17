structure Cooking2Test =
struct
  open Cooking2

  (* the recipes *)
  val lasagna   = ((4.0, "lasagna"),  [(0.25,"pasta"), (0.5,"bechamel"),
                                       (0.4,"meat"), (0.2,"bolognese"),
                                       (0.1,"parmesan")])
  val pasta     = ((1.0, "pasta"),    [(0.5,"flour"), (3.0,"egg")])
  val bechamel  = ((0.2,"bechamel"),  [(0.1,"flour"), (0.5,"butter"),
                                       (0.5,"milk"), (0.01,"pepper")])
  val bolognese = ((2.0,"bolognese"), [(3.0,"tomato"), (1.0,"onion"),
                                       (0.01,"pepper"), (1.0, "secret")])
  val secret    = ((1.0,"secret"),    [(0.1,"balsamic"), (1.0,"parsley"),
                                       (0.5,"mozzarella")])

  (* The cookbook *)
  val italianCookbook = [lasagna, pasta, bechamel, bolognese, secret]

  (* Two different fridges *)
  val bigFridge   = [(2.3,"flour"), (6.0,"egg"), (1.2,"milk"), (2.0,"butter"),
                     (0.2,"pepper"), (4.0,"tomato"), (5.0,"onion"),
                     (0.8,"balsamic"), (1.0, "parsley"), (0.7,"meat"),
                     (0.3,"parmesan")]
  val smallFridge = [(1.5,"pasta"), (0.8,"bolognese"), (0.6,"meat"),
                     (0.2,"parmesan"), (1.1,"flour"), (1.0,"milk"),
                     (2.0,"butter"), (0.1,"pepper")]

end (* structure Cooking2Test *)

