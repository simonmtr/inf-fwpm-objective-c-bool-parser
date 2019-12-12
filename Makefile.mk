# the compiler to use
CC = clang

PARAMETERS = -fblocks -lBlocksRuntime

TARGET = new/main.m
PRODUCT = objectiveCBoolParser

Compiler: new/main
	clang $(gnustep-config --objc-flags) -o $(PRODUCT) $(TARGET) $(gnustep-config --base-libs) $(PARAMETERS)