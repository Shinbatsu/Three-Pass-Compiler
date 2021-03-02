# Compiler

A simple compiler written in Haskell that translates a arithmetic language into a stack-based asm code. The compiler works in three stages:

1. **Pass 1**: Tokenizes and parses the source code into an abstract syntax tree (AST).
2. **Pass 2**: Reducer the AST using constant folding.
3. **Pass 3**: Generates stack machine code from the optimized AST.

### Project Structure
├── AST.hs -- Defines the AST and token types
├── Token.hs -- Splits given expression according to following tokens
├── Parser.hs -- Pass 1 (tokenizing and parsing)
├── Optimizer.hs -- Pass 2 (AST simplification)
├── Generator.hs -- Pass 3 (code generation)
├── Main.hs -- Main file
