CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

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
javac -cp $CPATH *.java 2>quiet.txt 
if [[ $? -eq 0 ]]
    then
        echo "Software Compiles"
    else
        echo $?
        echo "Compile Error"
fi
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples 2>results.txt
grep "Tests run: " results.txt