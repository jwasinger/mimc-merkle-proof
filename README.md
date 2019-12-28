# MiMC Merkle Tree

Implementation of merkle proof verification in a Webassembly environment.  MiMC (citation) is chosen as the hash function and the tree format is binary.  The implementation is compatible with MiMC-Sponge implementation in the Circom library (citation).

## Usage

Generate and verify a snark proof of a MiMC merkle proof for a depth 20 tree, Build the wasm verifier code and verify the merkle proof (not ZK proof) to ensure implementation compatibility with snarkjs:
```
> npm run test
```

## Why?

MiMC is amenable to use inside SNARK circuits.  Verification of a merkle proof for a tree of depth 20 results in a circuit with (x) constraints.  For reference, verifying a single call to Keccak256 is (y) constraints.

## Benchmarks (TODO)
