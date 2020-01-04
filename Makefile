# the compiler to use
CC = clang


PARAMETERS = -fblocks -lBlocksRuntime

TARGET = Code/main.m
PRODUCT = objectiveCBoolParser

Compiler: Code/main
	clang $(gnustep-config --objc-flags) -o $(PRODUCT) $(TARGET) $(gnustep-config --base-libs) $(PARAMETERS)