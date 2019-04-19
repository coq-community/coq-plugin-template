external get_n : unit -> int = "get_n"

let callC () : int = get_n ()

module PV = Proofview

let printHello : unit PV.tactic =
  let open PV.Notations in
  PV.(tclLIFT (NonLogical.make (fun () ->
      Feedback.msg_warning (Pp.str "hello")))) >>= fun () ->
  Tacticals.New.tclIDTAC
