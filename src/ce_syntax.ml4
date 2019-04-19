DECLARE PLUGIN "example_plugin"

(* This should not be needed, fix in Coq! *)
open Ltac_plugin

TACTIC EXTEND Hello
| [ "hello" ] -> [ Ce_api.printHello ]
END

VERNAC COMMAND EXTEND CallToC CLASSIFIED AS QUERY
| [ "CallC" ] -> [ let i = Ce_api.callC () in Feedback.msg_warning Pp.(int i) ]
END
