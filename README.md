# 3P Compiler

A simple compiler that translates a arithmetic expression into a stack-based asm code. The compiler works in three stages:

1. **Pass 1**: Tokenizes and parses the source code into an abstract syntax tree (AST).
2. **Pass 2**: Reducer the AST using constant folding.
3. **Pass 3**: Generates stack machine code from the optimized AST.

### Project Structure
* AST.hs -- Defines the AST and token types
* Token.hs -- Splits given expression according to following tokens
* Parser.hs -- Pass 1 (tokenizing and parsing)
* Optimizer.hs -- Pass 2 (AST simplification)
* Generator.hs -- Pass 3 (code generation)
* Main.hs -- Main file


### Usage

1. Load the project in GHCi or compile it with GHC.
2. Import the main module: `import Main`
3. Call the compile function with a valid program string.

### Example

Given the input:

```haskell
compile "[x y] (x + 2) * (y - 3)"
```

It returns:

```
AR 0
PU
IM 2
PU
PO
SW
PO
AD
PU
AR 1
PU
IM 3
PU
PO
SW
PO
SU
PU
PO
SW
PO
MU
PU
```