# objetive-c-bool-parser

### Run:
`clang $(gnustep-config --objc-flags) -o main main.m $(gnustep-config --base-libs) -fblocks -lBlocksRuntime`
- needed:
  - gnustep
  - clang compiler
  - Objective C 2.0
  - BlocksRuntime

## Limitations
- variables can be one char long
- variables a with value 0, b with value 1 and c with value 0 per default