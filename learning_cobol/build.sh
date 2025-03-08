cobc -c hello_world.cbl
cobc -c second_test.cbl
gcc -dynamiclib -o both.dylib second_test.o hello_world.o -L/opt/homebrew/lib -lcob