#!/bin/bash
#defining variables

OS_type=$(hostnamectl | grep Transient\ hostname | cut -d ' ' -f 3)
OS_dep="/run"
OS_dep_2=3
if [ "$OS_type" != "fedora" ]
	then
		OS_dep=''
		OS_dep_2=3
fi
pwd > dir.txt
user=$(cut "dir.txt" -d '/' -f $OS_dep_2)
echo $user
hymnpath=$OS_dep/media/$user/church/Script\ resources/hymnal/hymns/Lutheran\ Hymnal/
litpath=$OS_dep/media/$user/church/Script\ resources/hymnal/Liturgies/
datefolder=$OS_dep/media/$user/church
#creating functions

regular (){
	echo "regular"
	cp "$hymnpath"tlh"${hymns[0]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"revisedPAGE5best $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[1]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"OFFERPG5 $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[2]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"2collectbendpg14 $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[3]}".mid $OS_dep/media/$user/church/$folder_name
	}
midweek (){
	echo "midweek"
	cp  "$hymnpath"tlh"${hymns[0]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"Vesperspg41best2015.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[1]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[2]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"pg44-45vespers.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[3]}".mid $OS_dep/media/$user/church/$folder_name
	}
communion (){
	echo "communion"
	cp  "$hymnpath"tlh"${hymns[0]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"revisedPAGE5best.MID $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[1]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"OFFERP15.MID $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[2]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"PAGE24thru28.MID $OS_dep/media/$user/church/$folder_name
	cp "$litpath"Communion\ verses\ no.2Draw\ nigh.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"pg.29\ Nunc\ to\ end.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[3]}".mid $OS_dep/media/$user/church/$folder_name
	}
other (){
	echo "other"
	cp"$hymnpath"tlh"${hymns[0]}".mid $OS_dep/media/$user/church/$folder_name
	cp"$hymnpath"tlh"${hymns[1]}".mid $OS_dep/media/$user/church/$folder_name
	cp"$hymnpath"tlh"${hymns[2]}".mid $OS_dep/media/$user/church/$folder_name
	cp"$hymnpath"tlh"${hymns[3]}".mid $OS_dep/media/$user/church/$folder_name
	}
good_friday (){
	echo "good friday"
	cp  "$hymnpath"tlh"${hymns[0]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"Vesperspg41good.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[1]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[2]}".mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"PAGE24toend.MID $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"${hymns[3]}".mid $OS_dep/media/$user/church/$folder_name
	}

#creating the folder and asigning the hymns

run (){
read -p "enter the date 00-00-0000: " date 
folder_name=$(echo $date | cut -c 1-10)
echo $folder_name
mkdir $datefolder/$folder_name
declare -a hymns
hymns=()

for (( i = 1; i < 5; i++ )); do
        read -p "enter hymn "$i": " hymn
        hymns+=($hymn)
        echo ${hymns[@]}
done
echo "Enter service type:"
read -p "mw = midweek(page 41) s=standard(page 5) c=communion(page 15) gf=good friday(page 41 w/ communion)" serv_type
if [ "$serv_type" == "s" ]
	then
	regular
fi
if [ "$serv_type" == "mw" ]
	then
	midweek
fi
if [ "$serv_type" == "c" ]
	then
	communion
fi
if [ "$serv_type" == "gf" ]
	then
	good_friday
fi
read -p "is every thing correct? __ ${hymns[@]}" 
if [ "$?" == "1" ]
	then
		rm $datefolder/$folder_name/*
		run
fi
nmcli general status | grep disconnected
if [ "$?" == "1" ]
	then
		tar -czf ~/Hymns_archive/$date $datefolder/$folder_name/
		mutt -s "$date" 21schmidt.02@gmail.com -a ~/Hymns_archive/$date <<< "$date"
		mutt -s "$date" eschmidt_1975@yahoo.com -a ~/Hymns_archive/$date <<< "$date"
		echo "email sent"
fi
}
run
