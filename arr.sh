arr=()
until [ new_rec == "quit" ]
do
read -p "what would you like to add to the array? " new_rec
arr+=($new_rec)
echo ${arr[@]}
done
