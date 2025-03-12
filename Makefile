CC=gcc
CBL = cobc

CBL_FLAGS = -Wall

UNAME = $(shell uname)
OS_CC_FLAGS = 

ifeq ($(UNAME), Darwin)
	OS_CC_FLAGS = -L/opt/homebrew/lib
endif

BUILD_DIR = ./build
O_DIR = $(BUILD_DIR)/out
SRC_DIR = src
TARGET = cbx

OUTFILES = $(O_DIR)/main.o $(O_DIR)/reset.o $(O_DIR)/get_register.o


cbx: $(OUTFILES) $(BUILD_DIR) $(O_DIR)
	gcc -o $(BUILD_DIR)/$(TARGET) $(OUTFILES) $(OS_CC_FLAGS) -lcob 


$(O_DIR)/main.o: $(O_DIR) $(SRC_DIR)/main.cbl
	$(CBL) $(CBL_FLAGS) -c -x $(SRC_DIR)/main.cbl -o $(O_DIR)/main.o


# CPU

$(O_DIR)/reset.o: $(O_DIR) $(SRC_DIR)/cpu/reset.cbl
	$(CBL) $(CBL_FLAGS) -c $(SRC_DIR)/cpu/reset.cbl -o $(O_DIR)/reset.o


# Interfaces

$(O_DIR)/get_register.o: $(O_DIR) $(SRC_DIR)/interfaces/get_register.cbl
	$(CBL) $(CBL_FLAGS) -c $(SRC_DIR)/interfaces/get_register.cbl -o $(O_DIR)/get_register.o





$(BUILD_DIR): 
	@mkdir -p $(BUILD_DIR)

$(O_DIR): $(BUILD_DIR)
	@mkdir -p $(O_DIR)
