#setting up an exercise selection menu
$workout = import-csv .\Elist.txt -Delimiter ','
write-host "Welcome! Are you ready for today's workout? Or do you want to review past workouts"
$answer = read-host "Select (1) - new workout `nSelect (2) - review last 5 workouts"


switch ($answer) {
    {$_ -eq 1} {$rando = Get-Random -max 5 -Min 1; write-host $rando}
    {$_ -eq 2} {write-host "2 has been selected"}
    default {
        "not 1 or 2 selected"
    }
}


switch ($rando){
    {$_ -eq 1} {write-host "you're running";
    $newrando = get-random -min 1 -max 3;
    write-host "TODAY'S WORKOUT:" $workout."1"[$newrando]
    }
    {$_ -eq 2} {write-host "you're working out";
    $newrando = get-random -min 1 -max 3;
    write-host "TODAY'S WORKOUT:" $workout."2"[$newrando]}
    {$_ -eq 3} {write-host "you're swimming";
    $newrando = get-random -min 1 -max 3;
    write-host "TODAY'S WORKOUT:" $workout."3"[$newrando]}
    {$_ -eq 4} {write-host "you're biking";
    $newrando = get-random -min 1 -max 3;
    write-host "TODAY'S WORKOUT:" $workout."4"[$newrando]}
    {$_ -eq 5} {write-host "you're doing yoga"
    $newrando = get-random -min 1 -max 3;
    write-host "TODAY'S WORKOUT:" $workout."5"[$newrando]}
}

