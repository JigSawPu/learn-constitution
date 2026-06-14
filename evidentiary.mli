(* evidentiary.mli *)
open Foundational
open Descriptive
open Authority

(** 1. Claims (Writ Petitions) **)
(* The 5 Prerogative Writs modeled as specific operational payloads *)
type claim_payload =
  | HabeasCorpus of base_person participant    (* Reachability Evidence *)
  | Mandamus of string                         (* Force execution *)
  | Certiorari of string                       (* Strip lower-node output *)
  | Prohibition of string                      (* Halt lower-node execution *)
  | QuoWarranto of system_role                 (* Access Control verification *)

(* The opaque Claim object submitted to the compiler *)
type claim

(* CL3: Global Event Listener (PIL). Anyone can file a claim on behalf of another. *)
val file_claim : 
  petitioner:('a participant) -> 
  payload:claim_payload -> 
  claim

(** 2. Proof & Deviations **)
(* The ultimate output of the Judicial Compiler *)
type proof_state = 
  | Validated
  | UltraVires of fundamental_right  (* DVI1: Code is nullified *)
  | Contempt                         (* DVI2: Malicious interference caught *)

(* Proof is fully opaque. Once generated, it cannot be mutated. *)
type proof

val get_proof_state : proof -> proof_state

(** 3. The Judicial Compiler (Supreme Court) **)
module JudicialCompiler : sig
  
  (* PF1: The core pure evaluation function. 
     Takes a Claim and the OS Spec, outputs absolute Proof. *)
  val evaluate : claim -> constitution -> proof

  (* RPI1: Replayability (Curative Petition). 
     The ultimate backdoor. Takes an existing 'final' proof and bypasses 
     the cache IF severe bias is demonstrated. *)
  val curative_petition : 
    cached_proof:proof -> 
    evidence_of_bias:string -> 
    proof

end

(** 4. The Tracing Logger (CAG / Article 148) **)
module AuditTrail : sig
  
  type transaction = {
    amount: float;
    authorized_by: act;
    executed_by: [`PrimeMinister] authorized_node;
  }

  type audit_log

  (* AT3: The CAG observes and generates a read-only log. 
     It has no 'halt' or 'mutate' privileges here. *)
  val trace_execution : transaction list -> audit_log

end

(** 5. Capability Verification (Floor Test) **)
(* CVI1 & CVI2: A strict boolean runtime check. If the Prime Minister 
   cannot mathematically prove >50% consensus, the node is terminated. *)
val execute_floor_test : 
  executive:[`PrimeMinister] authorized_node -> 
  legislative_array:(citizen participant list) -> 
  (unit, string) result
