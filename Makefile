SHELL = /bin/bash

PROJECT_NAME = name
SOURCE_DIR = source
INCLUDE_DIR = include
BUILD_DIR = build

CC = gcc
CXX = g++
CXXFLAGS = -g -Wall -I${INCLUDE_DIR} -MMD -MP
CFLAGS = -g -Wall -I${INCLUDE_DIR} -MMD -MP

SOURCE_LIST = $(shell find ${SOURCE_DIR} -name '*.c')
SOURCE_LIST += $(shell find ${SOURCE_DIR} -name '*.cpp')
OBJECT_LIST := $(patsubst ${SOURCE_DIR}/%.c, ${BUILD_DIR}/%.o, ${SOURCE_LIST})
OBJECT_LIST := $(patsubst ${SOURCE_DIR}/%.cpp, ${BUILD_DIR}/%.o, ${OBJECT_LIST})
DEPENDECY_LIST = $(OBJECT_LIST:.o=.d)
DIRECORY_LIST = $(sort $(dir ${OBJECT_LIST}))

all: build_tree ${PROJECT_NAME}
	
${PROJECT_NAME}: ${OBJECT_LIST} 
	@$(CXX) ${OBJECT_LIST} -o ${PROJECT_NAME}

${BUILD_DIR}/%.o: ${SOURCE_DIR}/%.c 
	@printf "compling %-50s" "$<"
	@$(CC) $(CFLAGS) -c $< -o $@
	@printf "done\n"

${BUILD_DIR}/%.o: ${SOURCE_DIR}/%.cpp 
	@printf "compling %-50s" "$<"
	@$(CXX) $(CXXFLAGS) -c $< -o $@
	@printf "done\n"
-include ${DEPENDECY_LIST}

build_tree:
	@mkdir -p ${DIRECORY_LIST}

.PHONY: all build_tree
