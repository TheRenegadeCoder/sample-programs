let filename = "output.txt"

(* Some arbitrary interesting text for demo file reading and writing.
   These are the 10 thunderwords from Joyce's Finnegans Wake.
   See here for a great literary explanation if you're interested:
   https://hatterscabinet.com/pages-fw/fwtheme-thunderwords.html *)
let sample_text =
  {|bababadalgharaghtakamminarronnkonnbronntonnerronntuonnthunntrovarrhounawnskawntoohoohoordenenthurnuk
Perkodhuskurunbarggruauyagokgorlayorgromgremmitghundhurthrumathunaradidillifaititillibumullunukkunun
klikkaklakkaklaskaklopatzklatschabattacreppycrottygraddaghsemmihsammihnouithappluddyappladdypkonpkot
Bladyughfoulmoecklenburgwhurawhorascortastrumpapornanennykocksapastippatappatupperstrippuckputtanach
Thingcrooklyexineverypasturesixdixlikencehimaroundhersthemaggerbykinkinkankanwithdownmindlookingated
Lukkedoerendunandurraskewdylooshoofermoyportertooryzooysphalnabortansporthaokansakroidverjkapakkapuk
Bothallchoractorschumminaroundgansumuminarumdrumstrumtruminahumptadumpwaultopoofoolooderamaunsturnup
Pappappapparrassannuaragheallachnatullaghmonganmacmacmacwhackfalltherdebblenonthedubblandaddydoodled
husstenhasstencaffincoffintussemtossemdamandamnacosaghcusaghhobixhatouxpeswchbechoscashlcarcarcaract
Ullhodturdenweirmudgaardgringnirurdrmolnirfenrirlukkilokkibaugimandodrrerinsurtkrinmgernrackinarockar
|}

let () =
  (try
     Out_channel.with_open_text filename (fun oc ->
         Out_channel.output_string oc sample_text)
   with Sys_error msg ->
     Printf.eprintf "Failed to write to '%s': %s\n" filename msg;
     exit 1);

  try
    In_channel.with_open_text filename (fun ic -> In_channel.input_lines ic)
    |> List.iter print_endline
  with Sys_error msg ->
    Printf.eprintf "Failed to read from '%s': %s\n" filename msg;
    exit 1
