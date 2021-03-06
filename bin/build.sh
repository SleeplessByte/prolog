declare -i TEST_RESULT=0
FAILED_EXERCISES=''

for example_file in exercises/**/*.example
do
    exercise_dir=$(dirname $example_file)
    exercise=$(basename $example_file .example)
    echo '-------------------------------------------------------'
    echo "Testing $exercise"
    swipl -f  "$exercise_dir/$exercise.example" -s "$exercise_dir/${exercise}_tests.plt" -g run_tests,halt -t 'halt(1)' -- --all
    if [ $? -ne 0 ]; then
        TEST_RESULT=1
        FAILED_EXERCISES+="$exercise\n"
    fi
done

if [ $TEST_RESULT -ne 0 ]; then
    echo "The following exercises failed"
    printf $FAILED_EXERCISES
    exit $TEST_RESULT
fi
