(* foundational.mli *)

(** 1. Territory: The physical memory space **)
type territory = 
  | State of string 
  | UnionTerritory of string

(** 2. Fundamental Rights: Hardcoded System Invariants **)
(* Modeled as a strict sum type for exhaustiveness checking in the compiler *)
type fundamental_right =
  | Article14_Equality
  | Article19_FreedomOfSpeech
  | Article20_ProtectionFromRetroactiveLaw
  | Article21_LifeAndLiberty

(** 3. Phantom Types for Participant Access Levels **)
(* These empty types exist strictly at compile-time to track identity state *)
type base_person
type citizen

(** 4. The Participant Record (Opaque Type) **)
(* The 'a is the phantom type. You cannot construct this record directly.
   You must use the provided initialization functions. *)
type 'a participant

(** 5. Axiomatic Constructors & Accessors **)
(* PI1: Every Person possesses a distinct identity. *)
val instantiate_person : 
  id:string -> 
  age:int -> 
  domicile:territory -> 
  base_person participant

(* C1 & CI1: Deriving a Citizen from a Person based on strict parameters.
   Returns an Option monad because citizenship can be rejected if parameters fail. *)
val evaluate_citizenship : 
  base_person participant -> 
  citizen participant option

(* Accessor functions - safely reading the memory of a participant *)
val get_id : 'a participant -> string
val get_age : 'a participant -> int
val get_domicile : 'a participant -> territory

(** 6. The State Environment **)
module TheState : sig
  (* The aggregate execution environment *)
  type t
  
  (* STI1: The State is perpetually bound by the Constitution.
     Any State execution that breaches a Fundamental Right returns an Error. *)
  val enforce_action : 
    target:('a participant) -> 
    action:string -> 
    (unit, fundamental_right) result
end
