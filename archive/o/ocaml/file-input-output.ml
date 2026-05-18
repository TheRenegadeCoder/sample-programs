let filename = "output.txt"

let sample_text =
  {|Some mundane sample text
Some sample text that is mundane
Another line of mundane sample text
|}

let () =
  (try
     Out_channel.with_open_text filename (fun oc ->
         Out_channel.output_string oc sample_text)
   with Sys_error msg ->
     Printf.eprintf "Failed to write to '%s': %s\n" filename msg;
     exit 1);

  (try In_channel.with_open_text filename (fun ic -> In_channel.input_lines ic)
   with Sys_error msg ->
     Printf.eprintf "Failed to read from '%s': %s\n" filename msg;
     exit 1)
  |> List.iter print_endline
