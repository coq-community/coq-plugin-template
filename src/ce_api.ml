(** Example: calling a C function *)
external get_n : unit -> int = "get_n"

let callC () : int = get_n ()

(** Example: simple, no-op tactic + print *)
module PV = Proofview

let msg_in_tactic str : unit PV.tactic =
  PV.tclLIFT (PV.NonLogical.make (fun () ->
      Feedback.msg_warning (Pp.str str)))

let printHello : unit PV.tactic =
  let open PV.Notations in
  msg_in_tactic "hello" >>= fun () ->
  Tacticals.tclIDTAC
