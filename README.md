# Groth16 WASM Verifer

## Setup

Have assemblyscript compiler and gulp installed

run `build.sh` which compiles groth16 assemblyscript to wasm and merges it with Websnark.

## Usage

Run the verifier against an example proof: `npm run test`

## Generating Proofs

Examples of a proof and verification key can be found under the `proof` folder.  In the same folder exists a python script `serialize_proof.py` which loads the proof, verification key and serializes them into the input format that the verifier expects.

### Proof/Verification Key Serialization Format (Components listed in the order they are serialized)

```
Verification Key:
    A - 96 bytes
    B - 192 bytes
    C - 192 Bytes

Proof:
    A - 96 bytes
    B - 192 bytes
    G - 192 bytes
    D - 192 bytes

Input Constraints:
    Number of input constraints - 8 bytes
    Input Constraints - number of input constraints * 96 bytes

Public Inputs:
    Number of public inputs - 8 bytes (TODO - this can be removed and deduced from the number of input constraints)
    Public Inputs - number of public inputs * 32 bytes
```
