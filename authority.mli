(* authority.mli *)
open Foundational
open Descriptive

(** 1. Roles & Singletons **)
(* Polymorphic variants representing unique system interfaces *)
type system_role = [ `PrimeMinister | `Speaker | `ChiefJustice | `Governor ]

(* Phantom type representing a Participant who has been bound to a Role *)
type 'role authorized_node

(** 2. Access Control (Disqualifications / Article 102) **)
type disqualification =
  | OfficeOfProfit
  | UnsoundMind
  | AntiDefectionViolation
  | CriminalConviction of int (* months of sentence *)

(* AC1 & ACI1: Evaluates a citizen's state. Returns Ok if clean, Error if disqualified. *)
val check_eligibility : 
  citizen participant -> 
  (unit, disqualification) result

(** 3. Attestation (Third Schedule Oaths) **)
(* ASI1: A constructor function. A citizen cannot become an authorized_node 
   without passing this strict initialization payload. *)
val execute_oath : 
  citizen participant -> 
  role:system_role -> 
  ('role authorized_node, string) result

(** 4. Delegation & Governance **)
(* DGI1: The Legislature delegates rulemaking to the Executive, 
   but strictly bounds it within the parent Act's scope. *)
type delegated_rule

val delegate_rulemaking : 
  parent_act:act -> 
  executor:([`PrimeMinister] authorized_node) -> 
  delegated_rule

(** 5. Ownership & Root Override (Article 300A) **)
type 'a property
type compensation

(* OWI2: The State can override private ownership (Eminent Domain) 
   ONLY if backed by a validly compiled Act. *)
val execute_eminent_domain : 
  target:('a property) -> 
  authority:act -> 
  (compensation, string) result

(** 6. Confidentiality / Privacy (Puttaswamy Doctrine) **)
(* CFI2: State telemetry requires passing the 3-pronged Proportionality test *)
val request_telemetry : 
  target:('a participant) -> 
  legality_flag:bool -> 
  necessity_flag:bool -> 
  proportionality_flag:bool -> 
  (string, string) result
