CC=gcc
CBL = cobc

CBL_FLAGS = -Wall -Werror

UNAME = $(shell uname)
OS_CC_FLAGS = 

ifeq ($(UNAME), Darwin)
	OS_CC_FLAGS = -L/opt/homebrew/lib
endif

BUILD_DIR = ./build
O_DIR = $(BUILD_DIR)/out
SRC_DIR = src
TARGET = gbx

OUTFILES = $(O_DIR)/main.o

CFILES = 
CBLFILES = main.cbl

final: $(OUTFILES) $(BUILD_DIR) $(O_DIR)
	gcc -o $(BUILD_DIR)/$(TARGET) $(OUTFILES) $(OS_CC_FLAGS) -lcob 

$(O_DIR)/main.o: $(O_DIR)
	$(CBL) $(CBL_FLAGS) -c -x $(SRC_DIR)/main.cbl -o $(O_DIR)/main.o

$(BUILD_DIR): 
	@mkdir $(BUILD_DIR)

$(O_DIR): $(BUILD_DIR)
	@mkdir $(O_DIR)
