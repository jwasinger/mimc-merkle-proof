// import { bn128_frm_zero, bn128_fr_mul, bn128_frm_fromMontgomery, bn128_frm_toMontgomery, bn128_frm_mul, bn128_frm_add, bn128_g1m_toMontgomery, bn128_g2m_toMontgomery, bn128_g1m_neg, bn128_ftm_one, bn128_pairingEq4, bn128_g1m_timesScalar, bn128_g1m_add, bn128_g1m_affine, bn128_g1m_neg} from "./websnark_bn128";

const SIZE_F = 32;
import { mimc_init } from "./mimc.ts";

import { verify_merkle_proof } from "./merkle_tree.ts";

@external("env", "debug_printMemHex")
export declare function debug_mem(pos: i32, len: i32): void;

@external("env", "input_size")
export declare function input_size(): i32;

@external("env", "input_data_copy")
export declare function input_data_copy(outputOffset: i32, srcOffset: i32, length: i32): void;

@external("env", "save_output")
export declare function save_output(offset: i32): void;

// TODO make all numbers in the proof expected to be passed in montgomery form
export function main(): i32 {
    let input_data_len = input_size();
    let input_data_buff = new ArrayBuffer(input_data_len);
    input_data_copy(input_data_buff as usize, 0, input_data_len);

    let result = new Uint8Array(SIZE_F);

    mimc_init();

    if (verify_merkle_proof(input_data_buff as usize) != 0) {
        result[0] = 1;
    }

    save_output(result.buffer as usize);

    return 0;
}
