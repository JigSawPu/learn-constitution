(* ========================================================================== *)
(* MODULE 1: MOCKING THE OS INTERFACES                                        *)
(* ========================================================================== *)

(* 1. Foundational Types *)
type list_type = UnionList | StateList | ConcurrentList
type competence = { list: list_type; subject: string }

type fundamental_right = 
  | Article14_Equality 
  | Article19_FreedomOfSpeech 
  | Article20_ProtectionFromRetroactiveLaw 
  | Article21_LifeAndLiberty

(* 2. Phantom Types for the SDLC Pipeline *)
type drafted
type passed_lok_sabha
type passed_rajya_sabha
type assented

type 'stage bill = { id: int; content: string; competence: competence }
type act = assented bill

(* 3. Evidentiary Types (Judicial Proof) *)
type proof_state = 
  | Validated 
  | UltraVires of fundamental_right 
  | Contempt

type proof = { state: proof_state; reasoning: string }

(* ========================================================================== *)
(* MODULE 2: SYSTEM FUNCTIONS (THE COMPILERS)                                 *)
(* ========================================================================== *)

(* Legislative Pipeline Functions *)
let draft_bill ~id ~content ~competence : drafted bill = 
  { id; content; competence }

let pass_lower_house (b : drafted bill) : passed_lok_sabha bill = 
  { id = b.id; content = b.content; competence = b.competence }

let pass_upper_house (b : passed_lok_sabha bill) : passed_rajya_sabha bill = 
  { id = b.id; content = b.content; competence = b.competence }

let grant_assent (b : passed_rajya_sabha bill) : act = 
  { id = b.id; content = b.content; competence = b.competence }

(* Judicial Compiler Engine *)
let evaluate_act (target_act : act) : proof =
  (* Simulating Semantic Analysis: The Compiler reads the code block *)
  if String.contains target_act.content "without trial" then
    { state = UltraVires Article21_LifeAndLiberty; 
      reasoning = "Violation of Procedure Established by Law." }
  else if String.contains target_act.content "retroactive" then
    { state = UltraVires Article20_ProtectionFromRetroactiveLaw;
      reasoning = "Ex Post Facto criminal mutation detected." }
  else
    { state = Validated; 
      reasoning = "Code complies with all system invariants." }

(* ========================================================================== *)
(* MODULE 3: THE RUNTIME SIMULATION                                           *)
(* ========================================================================== *)

let () =
  print_endline "\n[SYSTEM] Booting Constitutional OS...";
  print_endline "[SYSTEM] Loading Part III Invariants...\n";

  (* --- STEP 1: DRAFTING THE MALICIOUS CODE --- *)
  let union_competence = { list = UnionList; subject = "Preventive Detention" } in
  let malicious_bill = draft_bill 
    ~id:101 
    ~content:"National Security Act: Allows arbitrary detention of a Person for 2 years without trial." 
    ~competence:union_competence 
  in

  print_endline ">> Legislature initialized a Draft Bill: National Security Act.";

  (* --- STEP 2: COMPILE-TIME PROTECTION DEMONSTRATION --- *)
  
  (* UNCOMMENTING THE LINE BELOW WOULD CRASH THE OCAML COMPILER ITSELF *)
  (* let bypassed_act = grant_assent malicious_bill in *)
  
  (* Compiler Error: 
     This expression has type `drafted bill` 
     but an expression was expected of type `passed_rajya_sabha bill`.
     
     Architectural Result: The Executive cannot bypass the Parliament. 
     The type-checker physically prevents the dictatorship shortcut.
  *)

  (* --- STEP 3: EXECUTING THE LEGAL PIPELINE --- *)
  print_endline ">> Processing through strict SDLC consensus pipeline...";
  let ls_passed = pass_lower_house malicious_bill in
  let rs_passed = pass_upper_house ls_passed in
  let materialized_act = grant_assent rs_passed in
  
  print_endline ">> Assent Granted. Bill Materialized into Act 101.\n";

  (* --- STEP 4: RUNTIME PROTECTION & MONADIC EVALUATION --- *)
  print_endline "[EVENT] Executive attempts to execute Act 101 on a Citizen.";
  print_endline "[EVENT] Global Listener triggered: Habeas Corpus Claim filed.";
  print_endline "[SYSTEM] Routing execution thread to Judicial Compiler...\n";

  (* The Judicial Review Monad evaluates the materialized Act *)
  let judicial_output = evaluate_act materialized_act in

  match judicial_output.state with
  | Validated -> 
      print_endline "[SUCCESS] Valid Execution. State mutated."
      
  | Contempt -> 
      print_endline "[EXCEPTION] System Interference."
      
  | UltraVires breached_invariant ->
      print_endline "==========================================================";
      print_endline "           [FATAL SYSTEM EXCEPTION CAUGHT]                ";
      print_endline "==========================================================";
      print_endline "Error Type      : ULTRA VIRES (Null Pointer Exception)";
      
      let invariant_name = match breached_invariant with
        | Article14_Equality -> "Article 14 (Equality)"
        | Article19_FreedomOfSpeech -> "Article 19 (Freedoms)"
        | Article20_ProtectionFromRetroactiveLaw -> "Article 20 (Ex Post Facto)"
        | Article21_LifeAndLiberty -> "Article 21 (Life & Personal Liberty)"
      in
      
      Printf.printf "Invariant Broken: %s\n" invariant_name;
      Printf.printf "Compiler Trace  : %s\n" judicial_output.reasoning;
      print_endline "----------------------------------------------------------";
      print_endline "[ACTION] Act 101 is Void Ab Initio. Executing Garbage Collection.";
      print_endline "[ACTION] State Rollback Complete. Target Person is released.\n";
