#getting list of last exercise offered
$donelist = ".\done_list.csv"
$tpast = get-content $donelist | Select-Object -Last 1
$gotlist = get-content $donelist

#talking to me
if($tpast -notlike "*done"){
    write-host "Welcome! The last workout offered was - $tpast - did you complete?";
    $workoutanswer = read-host "Did you complete the workout? y/n"  
    if($workoutanswer.ToUpper() -eq "Y"){
        write-host "Great job! The workout has been marked as completed. Let's get at it!"
        #set newlast as the last workout plus done
        $newlast = $tpast + ",done"
        #different and more direct way to replace the last line - we just delete it and add another
        $gotlist = $gotlist[0..($gotlist.count -2)]
        $gotlist += $newlast
        $gotlist | Set-Content  $donelist
    } elseif ($workoutanswer.ToUpper() -eq "N") {
        Write-Host "That's OK - do you want to repeat the workout ?"
        $repeat = read-host "y/n"
        if($repeat.ToUpper() -eq "Y"){
            write-host "Today's workout is $tpast - enjoy!"
            $todai = $tpast
        }elseif($repeat.ToUpper() -eq "N"){
            write-host "OK - new workout being served"
        } else {write-host "you did not enter y or n and I have no way of dealing with that right now so start over"}
    }else{
        write-host "did not enter y or n and I have no way of dealing with that right now so start over"
    }
    }
else{
    write-host "Welcome! "
}

#setting up an exercise selection menu
$workout = import-csv .\Elist.txt -Delimiter ',' 
write-host "Let's get it, ready for a new workout? Or do you want to review past workouts"
$answer = read-host "Select (1) - new workout `nSelect (2) - review last 5 workouts"


switch ($answer) {
    #random number for switch that selects the workouts
    {$_ -eq 1} {$rando = Get-Random -max 5 -Min 1; write-host $rando}
    {$_ -eq 2} {write-host "2 has been selected"}
    default {
        "not 1 or 2 selected"
    }
}

#selector for the workout in the column
$selector = Get-Random -min 1 -max 3

#adding gym day since it's a lot
$gym1 = @"
   flat db press 1x4-6,1x8-10
   db rom dead 2x8-10
   2 grip lat pulldown
    1x10-12 med overhand grip
    1x10-12 underhand close grip
    <then maybe some overhead curls with same grip, lower weight>
   db step up 1x8-10 reps per leg
   overhead cable tricep ext 1x12-15
    <cable just behind head, lock elbows>
   lateral raise 1x12-15
   leg press toe press 1x12-15 (straight leg calf raise)
"@

$gym2 = @"
    hack squat or bb squat 1x4-6, 1x8-10
   a. high incline smith press 2x10-12 like 45 or 60 degree angle
   b. t-bar row or incline rows 2x10-12 wide and middle grip
   seated leg curl 1x10-12 - failure, dropset - failure again, lean       over machine
   ez bar bicep curl 1x12-15, 
    then 4 reps (rest 3 secs) 4 reps, continue until fail
   cable crunch 1x12-15
    then double dropset
"@

#checking what random number was selected
switch ($rando){
    {$_ -eq 1} {write-host "you're running";
    $todai = $workout."1"[$selector];
    $value = "run"
    write-host "TODAY'S WORKOUT:" $todai
    }
    {$_ -eq 2} {write-host "you're working out";
    $value = "gymming"
    $todai = $workout."2"[$selector];
    #adding in the actual workout
    if($todai = 1){$todai = $gym1}
    elseif($todai = 2){$todai = $gym2}
    else{$todai = $todai}
    write-host "TODAY'S WORKOUT:" $todai
    }
   {$_ -eq 3} {write-host "you're swimming";  
   $value =  "swim"
   $todai = $workout."3"[$selector];
    write-host "TODAY'S WORKOUT:" $todai 
    }
    {$_ -eq 4} {write-host "you're biking"; 
    $value = "bike"
    $todai = $workout."4"[$selector];
    write-host "TODAY'S WORKOUT:" $todai
    }

    {$_ -eq 5} {write-host "you're doing yoga"
    $value = "yoga"
    $todai = $workout."5"[$selector];
    write-host "TODAY'S WORKOUT:" $todai
    }
    }

$daydate = get-date -Format "ddd MM/dd/yyyy"


add-content -Path $donelist.trimend() -Value "$daydate, $value, $todai"

<## it works! - some scenarios - skip workout if it already says done.
check date on last workout, if last workout is more than 5 days ask to repeat
figure out why there's a space
https://www.partitionwizard.com/partitionmanager/powershell-replace.html
##>