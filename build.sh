#! /bin/bash
asc assembly/groth16-verify/main.ts -b assembly/groth16-verify/out/main.wasm -t assembly/groth16-verify/out/main.wat --validate
(cd assembly/groth16-verify && gulp)
