#!/bin/bash
#defining variables
OS_type=$(hostnamectl | grep Transient\ hostname | cut -d ' ' -f 3)
OS_dep="/run"
OS_dep_2=3
if [ "$OS_type" != "fedora" ]
	then
		OS_dep=''
		OS_dep_2=4
fi
pwd > dir.txt
user=$(cut "dir.txt" -d '/' -f $OS_dep_2)
hymnpath=$OS_dep/media/$user/church/Script\ resources/hymnal/hymns/Lutheran\ Hymnal/
litpath=$OS_dep/media/$user/church/Script\ resources/hymnal/Liturgies/
datefolder=$OS_dep/media/$user/church
#creating functions
regular (){
	echo "regular"
	cp "$hymnpath"tlh"$hymn1"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"revisedPAGE5best* $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn2"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"OFFERPG5* $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn3"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"2collectbendpg14* $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn4"*.mid $OS_dep/media/$user/church/$folder_name
	}
midweek (){
	echo "midweek"
	cp  "$hymnpath"tlh"$hymn1"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"Vesperspg41best2015.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn2"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn3"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"pg44-45vespers.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn4"*.mid $OS_dep/media/$user/church/$folder_name
	}
communion (){
	echo "communion"
	cp  "$hymnpath"tlh"$hymn1"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"revisedPAGE5best.MID $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn2"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"OFFERP15.MID $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn3"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"PAGE24thru28.MID $OS_dep/media/$user/church/$folder_name
	cp "$litpath"Communion\ verses\ no.2Draw\ nigh.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"pg.29\ Nunc\ to\ end.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn4"*.mid $OS_dep/media/$user/church/$folder_name
	}
other (){
	echo "other"
	cp"$hymnpath"tlh"$hymn1"*.mid $OS_dep/media/$user/church/$folder_name
	cp"$hymnpath"tlh"$hymn2"*.mid $OS_dep/media/$user/church/$folder_name
	cp"$hymnpath"tlh"$hymn3"*.mid $OS_dep/media/$user/church/$folder_name
	cp"$hymnpath"tlh"$hymn4"*.mid $OS_dep/media/$user/church/$folder_name
	}
good_friday (){
	echo "good friday"
	cp  "$hymnpath"tlh"$hymn1"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"Vesperspg41good.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn2"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn3"*.mid $OS_dep/media/$user/church/$folder_name
	cp "$litpath"PAGE24toend.MID $OS_dep/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn4"*.mid $OS_dep/media/$user/church/$folder_name
	}

#creating the folder and asigning the hymns

run (){
date=$(zenity --calendar --date-format='%a-%m-%d-%Y')
zenity --info --title="the date" --text="$date"
folder_name=$(echo $date | cut -c 5-14)
mkdir $datefolder/$folder_name
hymn1=$(zenity --entry --text "enter hymn 1")
hymn2=$(zenity --entry --text "enter hymn 2")
hymn3=$(zenity --entry --text "enter hymn 3")
hymn4=$(zenity --entry --text "enter hymn 4")
month=$(echo $date | cut -c 5-6)
months=('31' '28' '31' '30' '31' '30' '31' '31' '30' '31' '30' '31')
month_amt=${months["$month"+1]}
day=$(echo $date | cut -c 8-9)
day_10=$(echo $((10#$day)))
echo $day_10
day_10_min=$(($day_10 - 1))
day_sub=$(($month_amt-$day_10_min))
echo $day_sub
day_name=$(echo $date | cut -c 1-3)
#auto check for communion and midweek
if [ "$day_name" == "Wed" ]
	 then
		echo $day
		midweek
	elif [ "$day_name" == "Fri" ]
		then
			echo $day
			good_friday
	elif [ "$day" -ge "23" ]
		then
			if [ "$day_name" == "Sun" ]
				then
					if  [ "$day_sub" -le "6"  ]
						then
							echo $day
							communion
						else
							regular
					fi
			fi
	elif [ "$day_name" == "Sun" ]
		then
			echo $day
			regular
fi
zen_verif=$(zenity --question --text "is every thing correct? __ $day_name $day $hymn1 $hymn2 $hymn3 $hymn4")
if [ "$?" == "1" ]
	then
		rm $datefolder/$folder_name/*
		run
fi
}
run
echo "OS_type $OS_type"
echo "OS_dep $OS_dep"
echo "OS_dep_2 $OS_dep_2"
echo "user $user"
echo "hymnpath $hymnpath"
echo "litpath $litpath"
echo "datefolder $datefolder"
echo "date $date"
echo "folder_name $folder_name"
echo "hymn1 $hymn1"
echo "hymn2 $hymn2"
echo "hymn3 $hymn3"
echo "hymn4 $hymn4"
echo "month $month"
echo "months $months"
echo "month_amt $month_amt"
echo "day $day"
echo "day_10 $day_10"
echo "day_10_min $day_10_min"
echo "day_sub $day_sub"
echo "day_name $day_name"
echo "zen_verif $zen_verif"