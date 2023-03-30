echo "Name: Array.sh "
echo "Summary: A program to list and append to an array "
echo "Author: Andrew Schmidt"

ARR=()
read -p "enter a number" $num
ARR+=($num)
echo ${ARR[$num]}
