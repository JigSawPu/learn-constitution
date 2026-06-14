(* architecture.mli *)
open Foundational
open Descriptive
open Authority
open Evidentiary

(** 1. SDLC: Version Control & Revisions (Article 368) **)
type revision_graph
type amendment_payload

(* VCI1: The Ultimate Bounds Check. 
   Validates an amendment payload against the Basic Structure Meta-Model.
   If it touches the root constraints, it returns an Error. *)
val evaluate_basic_structure : 
  payload:amendment_payload -> 
  meta_model:(string list) -> 
  (unit, string) result

(* VCI2: Merges a validated revision into the root OS specification.
   Returns the mutated Constitution and appends the delta to the Revision Graph. *)
val merge_revision : 
  current_os:constitution -> 
  patch:amendment_payload -> 
  consensus_proof:proof -> 
  constitution * revision_graph

(** 2. SDLC: Compiler-Derived Delta (Doctrine of Severability) **)
(* CDI1 & CDI2: If an Act partially violates invariants, the compiler doesn't 
   discard the whole file. It filters out the invalid variables and returns a valid subset. *)
val apply_severability : 
  corrupted_act:act -> 
  invariants:(fundamental_right list) -> 
  act option

(** 3. Distributed Cloud: Federalism & Concurrency (Article 254) **)
(* Defines the strict mutex locks available when multiple threads 
   attempt to write to the Concurrent List memory array. *)
type thread_lock = 
  | UnionLock
  | StateLock_with_PresidentialAssent

(* RI2 & BMI2: Resolves concurrent memory collisions. 
   The Union thread automatically overwrites the State thread UNLESS 
   the State thread acquired the explicit Presidential lock prior to compilation. *)
val resolve_repugnancy : 
  union_logic:act -> 
  state_logic:act -> 
  lock_status:thread_lock -> 
  act (* Returns the dominant, surviving execution logic *)

(** 4. Cloud Architecture: Disaster Recovery (Article 352) **)
(* The operational mode of the system. Notice the parameterized TTL (Time-To-Live). *)
type system_mode = 
  | StandardFederal
  | DisasterRecovery of { reason: string; ttl: int }

(* DRI2 & DRI3: Suspends decentralized multi-tenant isolation (States) 
   and centralizes all compute to the Union core.
   CRITICAL: Articles 20/21 are explicitly shielded and passed through. *)
val trigger_disaster_recovery : 
  current_state:system_mode -> 
  threat_level:string -> 
  shielded_invariants:(fundamental_right list) -> 
  system_mode

(** 5. Meta-Model: OS Architecture Functors **)
(* This defines the required signature for ANY Constitutional OS *)
module type CONSTITUTIONAL_OS = sig
  type state_type
  val compile_law : string -> act
  val evaluate_law : claim -> constitution -> proof
end

(* The Indian / UK Model: Monolithic Closures (Parliamentary)
   Notice how the Executive module strictly requires that its type 't' 
   is derived from the Legislature. They share lexical scope. *)
module Make_Parliamentary_OS 
  (Core : CONSTITUTIONAL_OS) 
  (Legislature : sig type t end) 
  (Executive : sig type t val derived_from : Legislature.t end) : CONSTITUTIONAL_OS

(* The US Model: Microservices (Presidential)
   Notice the strict structural separation. Executive and Legislature 
   have no shared dependencies or lexical derivation. *)
module Make_Presidential_OS 
  (Core : CONSTITUTIONAL_OS) 
  (Legislature : sig type t end) 
  (Executive : sig type t end) : CONSTITUTIONAL_OS

(** 6. Atomic State Transitions (German Constructive Vote of No Confidence) **)
(* ASTI1 & ASTI2: A strict transactional block. You cannot drop the current 
   Executive without successfully initializing a new one. *)
val execute_atomic_transition :
  drop_target:([`PrimeMinister] authorized_node) ->
  init_target:(citizen participant) ->
  ([`PrimeMinister] authorized_node, string) result
