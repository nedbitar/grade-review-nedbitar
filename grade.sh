CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
    then
        echo "ListExamples is found"
    else
        echo "Error incorrect File"
        exit 1
fi

cp ../TestListExamples.java .
javac -cp $CPATH *.java 2>compile.txt 
if [[ $? -eq 0 ]]
    then
        echo "Code Compiles"
    else
        echo "Exit Code: " $?
        echo "Compile Error"
        exit 1
fi
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > results.txt
fails=$(egrep -o "Failures: [0-9]+" results.txt | egrep -o "[0-9]+")
total=$(egrep -o "Tests run: [0-9]+" results.txt | egrep -o "[0-9]+")
if [[ $total -ne 0 ]]
    then
        percentage=$(echo "scale=2;($total - $fails) / $total * 100" | bc)
        echo "Pass Percentage: $percentage%"
    else
        echo "All tests failed"
fi
