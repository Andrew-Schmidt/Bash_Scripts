echo "   _____  .__   ____ .__     __           
  /     \ |__| / ___\|  |___/  |_ ___.__. 
 /  \ /  \|  |/ /_/  >  |  \   __<   |  | 
/    Y    \  |\___  /|   Y  \  |  \___  | 
\____|__  /__/_____/ |___|  /__|  / ____| 
        \/                \/      \/      
                                          "
echo "___________            __                                
\_   _____/___________/  |________  ____   ______ ______ 
 |    __)/  _ \_  __ \   __\_  __ \/ __ \ /  ___//  ___/ 
 |     \(  <_> )  | \/|  |  |  | \|  ___/ \___ \ \___ \  
 \___  / \____/|__|   |__|  |__|   \___  >____  >____  > 
     \/                                \/     \/     \/  
                                                         "
echo "exit code legend:"
echo "0: communion"
echo "1: wednesday service"
echo "2: friday service"
echo "3: regular service"

#defining variables
pwd > dir.txt
user=$(cut "dir.txt" -d '/' -f 3)
hymnpath=/run/media/$user/church/Script\ resources/hymnal/hymns/Lutheran\ Hymnal/
litpath=/run/media/$user/church/Script\ resources/hymnal/Liturgies/
datefolder=/run/media/$user/church
#creating functions
regular (){
	echo "regular"
	cp "$hymnpath"tlh"$hymn1"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"revisedPAGE5best* /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn2"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"OFFERPG5* /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn3"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"2collectbendpg14* /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn4"*.mid /run/media/$user/church/$folder_name
	}
midweek (){
	echo "midweek"
	cp  "$hymnpath"tlh"$hymn1"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"Vesperspg41best2015.mid /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn2"*.mid /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn3"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"pg44-45vespers.mid /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn4"*.mid /run/media/$user/church/$folder_name
	}
communion (){
	echo "communion"
	cp  "$hymnpath"tlh"$hymn1"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"revisedPAGE5best.MID /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn2"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"OFFERP15.MID /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn3"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"PAGE24thru28.MID /run/media/$user/church/$folder_name
	cp "$litpath"Communion\ verses\ no.2Draw\ nigh.mid /run/media/$user/church/$folder_name
	cp "$litpath"pg.29\ Nunc\ to\ end.mid /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn4"*.mid /run/media/$user/church/$folder_name
	}
other (){
	echo "other"
	cp"$hymnpath"tlh"$hymn1"*.mid /run/media/$user/church/$folder_name
	cp"$hymnpath"tlh"$hymn2"*.mid /run/media/$user/church/$folder_name
	cp"$hymnpath"tlh"$hymn3"*.mid /run/media/$user/church/$folder_name
	cp"$hymnpath"tlh"$hymn4"*.mid /run/media/$user/church/$folder_name
	}
good_friday (){
	echo "good friday"
	cp  "$hymnpath"tlh"$hymn1"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"Vesperspg41good.mid /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn2"*.mid /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn3"*.mid /run/media/$user/church/$folder_name
	cp "$litpath"PAGE24toend.MID /run/media/$user/church/$folder_name
	cp "$hymnpath"tlh"$hymn4"*.mid /run/media/$user/church/$folder_name
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
if [[ $day == '08' ]]
	then day=$((10#8))
fi
day_sub=$(($month_amt-$day))
echo $day
echo $day_sub
day_name=$(echo $date | cut -c 1-3)
#auto check for communion and midweek
echo $day_name
if [ "$day" -ge "24" ]
	then
		echo "day is greater then or equal to 23"
		if [ "$day_name" == "Sun" ]
			then
				if  [ "$day_sub" -le "6"  ]
					then
						echo $day
						communion
						exit 0
				fi
		fi
	elif [ "$day_name" == "Wed" ]
		 then
			echo "day is equal to wednesday"
			echo $day
			midweek
			exit 1
	elif [ "$day_name" == "Fri" ]
		then
			echo "day is equal to friday"
			echo $day
			good_friday
			exit 2
	elif [ "$day_name" == "Sun" ]
		then
			echo "day is sunday"
			echo $day
			regular
			exit 3
fi
zen_verif=$(zenity --question --text "is every thing correct? __$date $hymn1 $hymn2 $hymn3 $hymn4")
if [ "$?" == "1" ]
	then
		rm $datefolder/$folder_name/*
		run
fi
}
run
rm dir.txt
