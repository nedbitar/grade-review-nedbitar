CPATH='.;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar'

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
egrep -w "Tests" results.txt > failsPasses.txt
if [[ -s failsPasses.txt ]]
    then
        echo "You failure! Here: "
        cat failsPasses.txt
    else
        echo "All tests passed! 100%"
fi 