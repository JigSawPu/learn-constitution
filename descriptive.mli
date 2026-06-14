(* descriptive.mli *)
open Foundational

(** 1. Legislative Competence (Permissions) **)
(* Enforces the boundaries of federal memory addressing *)
type list_type = UnionList | StateList | ConcurrentList

type competence = {
  list : list_type;
  subject : string;
}

(** 2. The Specification (DPSP & Constitution) **)
type dpsp = {
  goal : string;
  resource_cost : int;
}

(* The root knowledge object *)
type constitution = {
  preamble : string;
  basic_structure : string list;           (* Immutable constraints *)
  invariants : fundamental_right list;     (* Absolute rights *)
  dpsp_roadmap : dpsp list;                (* Lazy-evaluated goals *)
}

(** 3. SDLC: The Law-Making Pipeline (Phantom Types) **)
(* We define the lifecycle states of a specification fragment *)
type drafted
type passed_lok_sabha
type passed_rajya_sabha
type assented

(* The Bill object. The 'stage parameter prevents a Draft from executing. *)
type 'stage bill 

(* An Act is strictly defined as a Bill that has reached the 'assented' state *)
type act = assented bill

(** 4. Materialization Functions (State Transitions) **)
(* FI1 & FI2: A Bill must be typed with Legislative Competence upon draft *)
val draft_bill : 
  content:string -> 
  competence:competence -> 
  drafted bill

(* Moving through the pipeline. Notice how the type signature forces the sequence. *)
val pass_lower_house : drafted bill -> passed_lok_sabha bill
val pass_upper_house : passed_lok_sabha bill -> passed_rajya_sabha bill

(* The final materialization step. Returns the fully compiled Act. *)
val grant_assent : passed_rajya_sabha bill -> act

(** 5. Event: Election **)
(* EI1 & EI3: Only citizens can participate. 
   Takes a list of citizens, returns the winning citizen token or an Error 
   (e.g., if quorum/validation fails). *)
val execute_election : 
  citizen participant list -> 
  (citizen participant, string) result
