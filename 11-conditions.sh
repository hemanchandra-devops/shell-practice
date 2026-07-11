echo "Enter a number: "
read Number

if [ $(($Number/2)) -ne 0 ];then
    echo "Given $Number is Odd Number"
else
    echo "Given $Number is Even Number"
fi