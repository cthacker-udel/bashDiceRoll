#!/bin/bash 

echo -e "\n\nWelcome to Thacker's Dice Roll Game!\n"

echo -e "\n\nThe rules will consist of this : the user will select the range of the dice [x,y] and then, the computer will roll two dice, and the player will roll two dice, whomever scores the higher, gets a point, if either player rolls two dice of the same number, they get an additional roll\nEnter a number out of range, or not an integer, to exit the program, and display the scores\n"


read -p "Enter your player's name :   " player

read -p "Enter the computer's name :   " cpu

cpudicetotal=0
playerdicetotal=0

read -p "Enter the starting number x : [x,y]     " x
read -p "Enter the ending range y : [x,y]     " y


echo -e "\nBEGIN MATCH\n"
sleep 2

cputotalscore=0
playertotalscore=0

display_score(){

cat <<EOF

    $cpu's Score : $cputotalscore
    $player's Score : $playertotalscore

EOF



}


while true; do
    display_score
    cpuchoice=$(shuf -i $x-$y -n 1)
    echo -e "\n$cpu rolling dice"
    sleep 2
    #echo -e "\n$cpu rolled a $cpuchoice"
    cpudicetotal=$((cpudicetotal + cpuchoice))
    cpuchoice=$(shuf -i $x-$y -n 1)
    echo -e "\n$cpu rolling dice second time"
    sleep 2
    if [ "$cpuchoice" -eq "$cpudicetotal" ]; then
        #echo -e "\n$cpu rolled same die, both $cpuchoice"
        sleep 1
        echo -e "\n$cpu rolling third time"
        cpudicetotal=$((cpudicetotal + cpuchoice))
        cpuchoice=$(shuf -i $x-$y -n 1)
        cpudicetotal=$((cpudicetotal + cpuchoice))
        sleep 2
    fi
    
    echo -e "\n$player rolling dice"
    sleep 2
    playerchoice=$(shuf -i $x-$y -n 1)
    playerdicetotal=$((playerdicetotal + playerchoice))
    echo -e "\n$player rolling dice for second time"
    playerchoice=$(shuf -i $x-$y -n 1)
    sleep 2
    if [ "$playerchoice" -eq "$playerdicetotal" ]; then
        echo -e "\n$player rolled same dice, rolling for third time"
        playerdicetotal=$((playerdicetotal + playerchoice))
        playerchoice=$(shuf -i $x-$y -n 1)
        playerdicetotal=$((playerdicetotal + playerchoice))
        sleep 2
    fi

    if [ "$cpudicetotal" -gt "$playerdicetotal" ]; then
        echo -e "\n$cpu scored more than $player, \n\n~=~=DICE SCORE~=~=\n$cpu : $cpudicetotal\n$player : $playerdicetotal\n"
        ((cputotalscore++))
        echo -e "\n$cpu scores 1 point"
        playerdicetotal=0
        cpudicetotal=0
        sleep 3
    elif [ "$playerdicetotal" -gt "$cpudicetotal" ]; then
        echo -e "\n$player scored more than $cpu, \n\n~=~=~=DICE SCORE~=~=~=\n$cpu : $cpudicetotal\n$player : $playerdicetotal"
        ((playertotalscore++))
        echo -e "\n$player scores 1 point"
        sleep 3
        playerdicetotal=0
        cpudicetotal=0
    else
        echo -e "$player and $cpu dice total was equal, resetting"
        playerdicetotal=0
        cpudicetotal=0
        sleep 3
    fi
done
