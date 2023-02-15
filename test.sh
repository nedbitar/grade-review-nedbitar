javac hello.java 2>test.txt
if [[ $? -eq 0 ]]
    then
        echo "0"
    else
        echo $?
fi
