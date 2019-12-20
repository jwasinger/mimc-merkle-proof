const snarkjs = require("snarkjs")
const stringifyBigInts = require('websnark/tools/stringifybigint').stringifyBigInts
const fs = require('fs')

const circuit_hash_file = "...";
const circuit_file = "...";

// build the circuit and perform the setup
async function build_circuit() {
    const input = require("../input.json");
    const groth16 = await buildGroth16();
    const circuit = require("./circuit.circom");
}

function generate_proof() {
    const proofData = await websnarkUtils.genWitnessAndProve(groth16, input, circuit, proving_key)
}

if (fs.existsSync(file_name)) {
    build_circuit()
}

generate_proof()

verify_proof()

// let circuitHash = 
// do trusted setup if it hasn't previously been done or the hash of the circuit code changed
