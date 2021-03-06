(* $Id: glade_demo.ml,v 1.7 2004/01/13 05:49:52 garrigue Exp $ *)

(* An experiment on using libglade in lablgtk *)

(* labgladecc2 project1.glade > project1.ml *)
#use "project1.ml";;

class editor () =
  object (self)
    inherit window1 ()

    method open_file () =
      let fs = GWindow.file_selection ~title:"Open file" ~modal:true () in
      fs#cancel_button#connect#clicked ~callback:fs#destroy;
      fs#ok_button#connect#clicked ~callback:
        begin fun () ->
          self#textview1#buffer#set_text "";
          fs#destroy ()
        end;
      fs#show ()

    initializer
      self#bind ~name:"on_open1_activate" ~callback:self#open_file;
      self#bind ~name:"on_about1_activate" 
	~callback:
	(fun () -> prerr_endline "XXX")
  end

let main () =
  let editor = new editor () in
  (* show bindings *)
  Glade.print_bindings stdout editor#xml;
  editor#window1#connect#destroy ~callback:GMain.quit;
  GMain.main ()

let _ = main ()
