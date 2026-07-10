a=100
b=200
d=heman
c=$(($a+$b+$d))
echo "sum is $c"

leaders=("kcr" "ktr" "revanth" "modi")
echo "leaders are: ${leaders[@]}"
echo "first leaders is: ${leaders[0]}"
echo "last leaders is: ${leaders[3]}"
echo "last leaders is: ${leaders[10]}"