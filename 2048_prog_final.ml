OCaml

(* 2048 Programmation *)

let decaler_gauche list =
let i = ref (Array.length list - 1) in 
while !i > 0 do 
if list.(!i) > 0 && list.(!i - 1) = 0 then (list.(!i - 1) <- list.(!i) ; list.(!i) <- 0 ; i:= (Array.length list - 1) ) else decr i 
done ;;

let fusionner_gauche list =
for i = 0 to (Array.length list - 2) do
if list.(i) = list.(i + 1) then (list.(i) <- list.(i) * 2 ; list.(i + 1) <- 0)
done ;;

let decaler_droite list =
let i = ref 0 in
while !i < (Array.length list - 1) do
if list.(!i) > 0 && list.(!i + 1) = 0 then (list.(!i + 1) <- list.(!i) ; list.(!i) <- 0 ; i:= 0) else incr i
done ;;

let fusionner_droite list =
for i = 2 to (Array.length list) do
if list.(Array.length list - i) = list.(Array.length list - i + 1) then (list.(Array.length list - i + 1) <- list.(Array.length list - i) * 2 ; list.(Array.length list - i) <- 0)
done ;;

let decaler_haut list col =
let i = ref 0 in
while !i < (Array.length list - 1) do
if list.(!i).(col) = 0 && list.(!i + 1).(col) > 0 then (list.(!i).(col) <- list.(!i + 1).(col) ; list.(!i + 1).(col) <- 0 ; i:= 0) else incr i
done ;;

let decaler_bas list col =
let i = ref (Array.length list - 1) in 
while !i > 0 do 
if list.(!i).(col) = 0 && list.(!i - 1).(col) > 0 then (list.(!i).(col) <- list.(!i - 1).(col) ; list.(!i - 1).(col) <- 0 ; i:= (Array.length list - 1) ) else decr i 
done ;;

let fusionner_bas list col =
for i = 2 to (Array.length list) do
if list.(Array.length list - i).(col) = list.(Array.length list - i + 1).(col) then (list.(Array.length list - i + 1).(col) <- list.(Array.length list - i).(col) * 2 ; list.(Array.length list - i).(col) <- 0)
done ;;

let fusionner_haut list col =
for i = 0 to (Array.length list - 2) do
if list.(i).(col) = list.(i + 1).(col) then (list.(i).(col) <- list.(i).(col) * 2 ; list.(i + 1).(col) <- 0)
done ;;


let rec reperageListe list (i,j) pos =
if i = Array.length list then pos
else if j = Array.length list.(i) then reperageListe list (i+1,0) pos
else if list.(i).(j) = 0 then reperageListe list (i,j+1) ((i,j) :: pos)
else reperageListe list (i,j+1) pos ;;

let choix_random list =
let pos = reperageListe list (0,0) [] in
if List.length pos > 1 then let rand = Random.int (List.length pos - 1) in List.nth pos rand 
else if List.length pos = 1 then List.nth pos 0
else (-5,-5) ;;


let copie_degeu_mais_geniale tab =
let tab2 = Array.init (Array.length tab) (fun i  -> Array.init (Array.length tab.(i)) (fun j -> tab.(i).(j))) in 
tab2 ;;

let rec espaces n =
if n = 0 then ""
else " " ^ (espaces (n - 1)) ;;

let print_array tab = 
print_newline () ;
print_newline () ;
for i = 0 to (Array.length tab - 1) do
let ligne = ref "         " in
print_newline () ;
print_newline () ;
    for j = 0 to (Array.length tab.(i) - 1 ) do
    ligne := String.concat (espaces (8 - String.length (string_of_int tab.(i).(j)))) [!ligne; string_of_int tab.(i).(j)]
    done ;
print_string !ligne
done ;
print_newline () ; print_newline ();;



let rec game plat =
let again = ref false in
let test = ref (copie_degeu_mais_geniale plat) in
print_array plat ; print_string " Choisissez un mouvement : " ;
let dir = read_line () in
    if dir = "bas" || dir = "\027[B" || dir = "b" then (for i = 0 to (Array.length plat - 1) do decaler_bas plat i ; fusionner_bas plat i ; decaler_bas plat i done)
      else if dir = "haut" || dir = "\027[A" || dir = "h" then (for i = 0 to (Array.length plat - 1) do decaler_haut plat i ; fusionner_haut plat i ; decaler_haut plat i done)
    else if dir = "droite"   || dir = "\027[C" || dir = "d" then (for i = 0 to (Array.length plat - 1) do decaler_droite plat.(i) ; fusionner_droite plat.(i) ; decaler_droite plat.(i) done)
    else if dir = "gauche" || dir = "\027[D" || dir = "g" then (for i = 0 to (Array.length plat - 1) do decaler_gauche plat.(i) ; fusionner_gauche plat.(i) ; decaler_gauche plat.(i) done)
      else again := true ;
let zew = ref (choix_random plat) in
    if !zew <> (-5,-5) then (if !again then print_string " Je n'ai pas compris " 
          else (if plat = !test then print_string " Ce mouvement n'est pas possible "
            else plat.(fst !zew).(snd !zew) <- List.nth [2;2;4;2;2;2;2] (Random.int 6)) ;
        game plat)
    else print_string "  -- Game over --  " ;;


let launch_2048 () =
let tab = [|[|0;0;0;0|];[|0;0;0;0|];[|0;0;0;0|];[|0;0;0;0|]|] in
tab.(Random.int 3).(Random.int 3) <- 2 ;
tab.(Random.int 3).(Random.int 3) <- 2 ;
game tab ;;


(* Rentrer ceci pour débuter une partie *)
launch_2048 () ;;


(* Fonction des test *)

let tes list func col = 
print_array list ;
func list col ;
print_array list ;;

let ses list func = 
print_array list ;
func list ;
print_array list ;;

let test tab =
let tab2 = Array.copy tab in 
print_array tab ; print_array tab2 ;
tab.(0) <- decaler_gauche tab.(0) ;
print_array tab ; print_array tab2 ;
if tab2 = tab then print_string " Aucun Changement " else print_string " Changement " ;;

let test tab =
let tab2 = ref(Array.copy tab) in
print_array tab ; print_array !tab2 ;
tab.(0).(0) <- 100 ;
print_array tab ; print_array !tab2 ;;




(* Versions antérieures *)

let game x =
let plat = ref [|[|0;0;0;0|];[|0;0;0;0|];[|0;0;0;0|];[|0;0;0;0|]|] and
let zew = ref (choix_random !plat) in
!plat.(fst !zew).(snd !zew) <- 2 ;
zew := choix_random !plat ;
while !zew <> (-5,5) do
    (!plat).(fst !zew).(snd !zew) <- 2 ;
    print_array !plat ;
    let dir = get_string_from_user ("Veuillez entrer une direction") in
        if dir = "bas" then (for i = 0 to (Array.length !plat - 1) do decaler_bas !plat i ; fusionner_bas !plat i ; decaler_bas !plat i done)
        else if dir = "haut" then (for i = 0 to (Array.length !plat - 1) do decaler_haut !plat i ; fusionner_haut !plat i ; decaler_haut !plat i done)
        else if dir = "droite" then (for i = 0 to (Array.length !plat - 1) do decaler_droite !plat.(i) ; fusionner_droite !plat.(i) ; decaler_droite !plat.(i) done)
        else if dir = "gauche" then (for i = 0 to (Array.length !plat - 1) do decaler_gauche !plat.(i) ; fusionner_gauche !plat.(i) ; decaler_gauche !plat.(i) done)
        else print_string "Je n'ai pas compris"
    zew := choix_random !plat ;
done ;;

(* Fin de fonction antérieure *)

if !zew = (-5,-5) then print_string " -- Game over -"
else if !zew = (-10,-10) then print_string "Je n'ai pas compris" 
    else plat.(fst !zew).(snd !zew) <- List.nth [2;2;4;2;2] (Random.int 4) ;
game plat 
;;