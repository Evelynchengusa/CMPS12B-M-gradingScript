#!/bin/bash
# cmps012b-pt.s19 grading
# usage: pa2.sh
# (run within your pa2 directory to test your code)

SRCDIR=https://raw.githubusercontent.com/Evelynchengusa/CMPS12B-M-gradingScript/master/pa2/

if [ ! -e backup ]; then
  echo "WARNING: a backup has been created for you in the \"backup\" folder"
  mkdir backup
fi

cp *.c Makefile backup   # copy all files of importance into backup

for num in 1 2 3 4 5 6 7 8 9 10
do
   curl $SRCDIR/model-out$num.txt > model-out$num.txt
done

curl $SRCDIR/ModelQueensTest.c > ModelQueensTest.c
curl $SRCDIR/Makefile1 > Makefile1
curl $SRCDIR/modelunit-out1.txt > modelunit-out1.txt
curl $SRCDIR/modelunit-out2-1.txt > modelunit-out2-1.txt
curl $SRCDIR/modelunit-out2-2.txt > modelunit-out2-2.txt
curl $SRCDIR/modelunit-out3.txt > modelunit-out3.txt
curl $SRCDIR/modelunit-out4.txt > modelunit-out4.txt
curl $SRCDIR/modelunit-out5.txt > modelunit-out5.txt

echo ""
echo ""

make

if [ ! -e Queens ] || [ ! -x Queens ]; then # exist and executable
  echo ""
  echo "Makefile doesn't correctly create Queens!!!"
  echo ""
  rm -f *.o
  gcc -std=c99 -Wall -g Queens.c -o Queens > garbage &>> garbage

fi


TEST1=""
TEST2="x"
TEST3="-v"
TEST4="-v x"
TEST5="5"
TEST6="-v 5"
TEST7="8"
TEST8="9"
TEST9="10"
# Fix n = 15 because they were a pain to grade (~1:30 mins wait)
# we will see how 5 seconds fair
TEST10="12"

# Run tests
NUMTESTS=10
PNTSPERTEST=5
let MAXPTS=$NUMTESTS*$PNTSPERTEST
testspassed=$(expr 0)
echo "Please be warned that the following tests discard all output to stdout/stderr"
echo "Subset tests: If nothing between '=' signs, then test is passed"
echo "Press enter to continue"
read verbose

echo "Test 1:"
echo "=========="
timeout 0.5 Queens $TEST1 >& out1.txt
diff -ywBZbi --suppress-common-lines out1.txt model-out1.txt > diff1.txt
cat diff1.txt
echo "=========="

if [ -e diff1.txt ] && [[ ! -s diff1.txt ]]; then
    let testspassed+=1
fi

echo "Test 2:"
echo "=========="
timeout 0.5 Queens $TEST2 >& out2.txt
diff -ywBZbi --suppress-common-lines out2.txt model-out2.txt > diff2.txt
cat diff2.txt
echo "=========="

if [ -e diff2.txt ] && [[ ! -s diff2.txt ]]; then
    let testspassed+=1
fi

echo "Test 3:"
echo "=========="
timeout 0.5 Queens $TEST3 >& out3.txt
diff -ywBZbi --suppress-common-lines out3.txt model-out3.txt > diff3.txt
cat diff3.txt
echo "=========="

if [ -e diff3.txt ] && [[ ! -s diff3.txt ]]; then
    let testspassed+=1
fi

echo "Test 4:"
echo "=========="
timeout 0.5 Queens $TEST4 >& out4.txt
diff -ywBZbi --suppress-common-lines out4.txt model-out4.txt > diff4.txt
cat diff4.txt
echo "=========="

if [ -e diff4.txt ] && [[ ! -s diff4.txt ]]; then
    let testspassed+=1
fi

echo "Test 5:"
echo "=========="
timeout 0.5 Queens $TEST5 > out5.txt
diff -ywBZbi --suppress-common-lines out5.txt model-out5.txt > diff5.txt
cat diff5.txt
echo "=========="

if [ -e diff5.txt ] && [[ ! -s diff5.txt ]]; then
    let testspassed+=1
fi

echo "Test 6:"
echo "=========="
timeout 0.5 Queens $TEST6 > out6.txt
diff -ywBZbi --suppress-common-lines out6.txt model-out6.txt > diff6.txt
cat diff6.txt
echo "=========="

if [ -e diff6.txt ] && [[ ! -s diff6.txt ]]; then
    let testspassed+=1
fi

echo "Test 7:"
echo "=========="
timeout 0.5 Queens $TEST7 > out7.txt
diff -ywBZbi --suppress-common-lines out7.txt model-out7.txt > diff7.txt
cat diff7.txt
echo "=========="

if [ -e diff7.txt ] && [[ ! -s diff7.txt ]]; then
    let testspassed+=1
fi

echo "Test 8:"
echo "=========="
timeout 0.5 Queens $TEST8 > out8.txt
diff -ywBZbi --suppress-common-lines out8.txt model-out8.txt > diff8.txt
cat diff8.txt
echo "=========="

if [ -e diff8.txt ] && [[ ! -s diff8.txt ]]; then
    let testspassed+=1
fi

echo "Test 9:"
echo "=========="
timeout 2 Queens $TEST9 > out9.txt
diff -ywBZbi --suppress-common-lines out9.txt model-out9.txt > diff9.txt
cat diff9.txt
echo "=========="

if [ -e diff9.txt ] && [[ ! -s diff9.txt ]]; then
    let testspassed+=1
fi

echo "Test 10:"
echo "=========="
# Let's try 5 for now
timeout 5 Queens $TEST10 > out10.txt
diff -ywBZbi --suppress-common-lines out10.txt model-out10.txt > diff10.txt
cat diff10.txt
echo "=========="

if [ -e diff10.txt ] && [[ ! -s diff10.txt ]]; then
    let testspassed+=1
fi

echo ""
echo ""

let testpoints=$PNTSPERTEST*$testspassed

echo "Passed $testspassed / $NUMTESTS Subset tests"
echo "This gives a total of $testpoints / $MAXPTS points"

echo ""
echo ""

make clean

if [ -e Queens ] || [ -e *.o ]; then
   echo "WARNING: Makefile didn't successfully clean all files"
   rm -f Queens *.o
fi

echo ""
echo ""

echo "Press Enter To Continue with QueensTest Results"
read verbose



make -f Makefile1 ModelQueensTest 
#cat garbage

timeout 6 ./ModelQueensTest -v 
#> QueensTest-out.txt &>> QueensTest-out.txt
#cat QueensTest-out.txt

#rm -f *out[0-9].txt


rm -f *.o ModelQueensTest* garbage*
