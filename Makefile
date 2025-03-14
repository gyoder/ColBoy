CC=gcc
CBL = cobc

CBL_FLAGS = -Wall -Werror -Wno-others
CC_FLAGS = -Wall -Werror -Wno-unused-value

UNAME = $(shell uname)
OS_CC_FLAGS = 

ifeq ($(UNAME), Darwin)
	OS_CC_FLAGS = -L/opt/homebrew/lib
endif

BUILD_DIR = ./build
O_DIR = $(BUILD_DIR)/out
SRC_DIR = src
TARGET = cbx

OUTFILES = $(O_DIR)/main.o $(O_DIR)/reset.o $(O_DIR)/get_register.o $(O_DIR)/state_tests.o $(O_DIR)/linkage_tests.o $(O_DIR)/test_runner.o

cbx: $(BUILD_DIR) $(O_DIR) $(OUTFILES)  
	$(CC) -o $(BUILD_DIR)/$(TARGET) $(OUTFILES) $(OS_CC_FLAGS) -lcob 


$(O_DIR)/main.o: $(SRC_DIR)/main.cbl
	$(CBL) $(CBL_FLAGS) -c -x $(SRC_DIR)/main.cbl -o $(O_DIR)/main.o


# CPU

$(O_DIR)/reset.o: $(SRC_DIR)/cpu/reset.cbl
	$(CBL) $(CBL_FLAGS) -c $(SRC_DIR)/cpu/reset.cbl -o $(O_DIR)/reset.o


# Interfaces

$(O_DIR)/get_register.o: $(SRC_DIR)/interfaces/get_register.cbl
	$(CBL) $(CBL_FLAGS) -c $(SRC_DIR)/interfaces/get_register.cbl -o $(O_DIR)/get_register.o


# Tests

$(O_DIR)/test_runner.o: $(SRC_DIR)/tests/test_runner.cbl
	$(CBL) $(CBL_FLAGS) -c $(SRC_DIR)/tests/test_runner.cbl -o $(O_DIR)/test_runner.o

$(O_DIR)/linkage_tests.o: $(SRC_DIR)/tests/linkage_tests.c $(SRC_DIR)/tests/state_tests.h
	$(CC) $(CC_FLAGS) -c $(SRC_DIR)/tests/linkage_tests.c -o $(O_DIR)/linkage_tests.o

$(O_DIR)/state_tests.o: $(SRC_DIR)/tests/state_tests.c $(SRC_DIR)/tests/state_tests.h $(SRC_DIR)/interfaces/interfaces.h
	$(CC) $(CC_FLAGS) -c $(SRC_DIR)/tests/state_tests.c -o $(O_DIR)/state_tests.o

$(BUILD_DIR): 
	@mkdir -p $(BUILD_DIR)

$(O_DIR): $(BUILD_DIR)
	@mkdir -p $(O_DIR)




clean:
	rm -rf build
