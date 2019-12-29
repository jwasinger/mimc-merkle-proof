import { bn128_frm_zero, bn128_fr_mul, bn128_frm_fromMontgomery, bn128_frm_toMontgomery, bn128_frm_mul, bn128_frm_add, bn128_g1m_toMontgomery, bn128_g2m_toMontgomery, bn128_g1m_neg, bn128_ftm_one, bn128_pairingEq4, bn128_g1m_timesScalar, bn128_g1m_add, bn128_g1m_affine, bn128_g1m_neg} from "./websnark_bn128";

import { mimc_init, mimc_compress2 } from "./mimc.ts";

@external("env", "debug_printMemHex")
export declare function debug_mem(pos: i32, len: i32): void;

@external("env", "input_size")
export declare function input_size(): i32;

@external("env", "input_data_copy")
export declare function input_data_copy(outputOffset: i32, srcOffset: i32, length: i32): void;

@external("env", "save_output")
export declare function save_output(offset: i32): void;

// bn128 point size
const SIZE_F = 32;

// TODO make all numbers in the proof expected to be passed in montgomery form
export function main(): i32 {
    let input_data_len = input_size();
    let input_data_buff = new ArrayBuffer(input_data_len);
    input_data_copy(input_data_buff as usize, 0, input_data_len);

    mimc_init();

    let root = ( input_data_buff as usize ); 
    bn128_frm_toMontgomery(root, root);

    let selector = Uint64Array.wrap(input_data_buff, 32, 1)[0] as usize;

    let num_witnesses = Uint64Array.wrap(input_data_buff, 40, 1)[0] as usize;

    let witnesses = root + 48;

    for (let i: usize = 0; i < num_witnesses; i++) {
        bn128_frm_toMontgomery(witnesses + i * SIZE_F, witnesses + i * SIZE_F);
    }

    let leaf = witnesses + ( num_witnesses * SIZE_F );

    bn128_frm_toMontgomery(leaf, leaf);

    let output = (new Uint8Array(SIZE_F)).buffer as usize;

    mimc_compress2(leaf, witnesses, output);

    for (let i: usize = 1; i < num_witnesses; i++) {
        if (selector % 2 == 0) {
            mimc_compress2(output, witnesses + i * SIZE_F, output);
        } else {
            mimc_compress2(witnesses + i * SIZE_F, output, output);
        }

        // selector = selector / 2;
        selector /= 2;
    }

    bn128_frm_fromMontgomery(output, output);

    // TODO check root == output and save result

    save_output(output);

    return 0;
}
