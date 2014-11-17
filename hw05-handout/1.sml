signature MODOPS =
sig
  type t
  val modulus: t
  val plus:  t * t -> t
  val minus: t * t -> t
  val times: t * t -> t
end

structure NUM:MODOPS = 
    struct
        type t= int
        val modulus = 5
        (* Body *)
    end    

functor MOD (N:NUM):MODOPS =
struct
	(* Body *)
end

;