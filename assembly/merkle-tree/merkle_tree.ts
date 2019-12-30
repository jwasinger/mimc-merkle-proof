import { mimc_compress2 } from "./mimc.ts";

import { bn128_frm_zero, bn128_fr_mul, bn128_frm_fromMontgomery, bn128_frm_toMontgomery, bn128_frm_mul, bn128_frm_add, bn128_g1m_toMontgomery, bn128_g2m_toMontgomery, bn128_g1m_neg, bn128_ftm_one, bn128_pairingEq4, bn128_g1m_timesScalar, bn128_g1m_add, bn128_g1m_affine, bn128_g1m_neg} from "./websnark_bn128";

import { SIZE_F, memcmp } from "./util.ts";

// bn128 point size
export const ROOT_OFFSET = 0;

export function verify_merkle_proof(p_proof: usize): u32 {
    let p_computed_root = (new Uint8Array(SIZE_F)).buffer as usize;
    let p_proof_root = p_proof + ROOT_OFFSET;

    compute_root(p_proof, p_computed_root);

    return memcmp(p_computed_root, p_proof_root);
}

export function get_proof_size(p_proof: usize): usize {
    // TODO
}

// computes the merkle root and modifies the proof root
export function compute_proof(p_proof: usize): void {
    let p_proof_root = p_proof + ROOT_OFFSET;
    compute_root(p_proof, p_proof_root);
}

export function compute_root(p_proof: usize, p_out_root: usize): void {
    let root = ( p_proof as usize ); 
    bn128_frm_toMontgomery(root, p_out_root);

    // TODO: index/num_witnesses are serialized as u64 and casted to usize which could cause overflow.
    let index = load<u64>(p_proof + 32) as u64;
    let num_witnesses = load<u64>(p_proof + 40) as u64;

    let witnesses: usize = root + 48;

    for (let i: usize = 0; i < num_witnesses; i++) {
        bn128_frm_toMontgomery(witnesses + i * SIZE_F, witnesses + i * SIZE_F);
    }

    let leaf: usize = witnesses + ( num_witnesses as usize * SIZE_F );

    bn128_frm_toMontgomery(leaf, leaf);

    mimc_compress2(leaf, witnesses, p_out_root);

    for (let i: usize = 1; i < num_witnesses; i++) {
        if (index % 2 == 0) {
            mimc_compress2(p_out_root, witnesses + i * SIZE_F, p_out_root);
        } else {
            mimc_compress2(witnesses + i * SIZE_F, p_out_root, p_out_root);
        }

        index /= 2;
    }

    bn128_frm_fromMontgomery(p_out_root, p_out_root);
}
