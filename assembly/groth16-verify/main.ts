import { bn128_int_zero/*, bn128_int_add*/, bn128_g1m_toMontgomery, bn128_g2m_toMontgomery, bn128_g1m_neg, bn128_ftm_one, bn128_pairingEq4, bn128_g1m_timesScalar, bn128_g1m_add, bn128_g1m_affine, bn128_g1m_neg} from "./websnark_bn128";

@external("env", "debug_printMemHex")
export declare function debug_mem(pos: i32, len: i32): void;

@external("env", "input_size")
export declare function input_size(): i32;

@external("env", "input_data_copy")
export declare function input_data_copy(outputOffset: i32, srcOffset: i32, length: i32): void;

@external("env", "save_output")
export declare function save_output(offset: i32): void;

// bn128 scalar field size 256 bits
const SIZE_F = 32;

const round_constants: Array<u64> = [
    0x04af9e46dbc42b94, 0x137981fece56e977, 0x5d00fc101129f08f, 0xd6b781f439c20c0b
];

function mimc_cipher(/*constants*/): void {
    //constants = [...];
    //num_rounds = len(constants) + 1;
    let num_rounds = 1;

    let xL = new ArrayBuffer(SIZE_F) as usize;
    let xR = new ArrayBuffer(SIZE_F) as usize;
    bn128_int_zero(xL);
    bn128_int_zero(xR);

    let c = new ArrayBuffer(SIZE_F) as usize;
    let t = new ArrayBuffer(SIZE_F) as usize;

    debug_mem(round_constants.buffer as usize, SIZE_F);

    for (let i = 0; i < num_rounds; i++) {
        bn128_int_zero(xL);
        bn128_int_zero(xR);

        debug_mem(xL, SIZE_F);

        /*
        if (i == 0 || i = num_rounds) {
          t = k + k_in;
        } else {
          c = constants[i];
          t = k + k[i-1] + c;
        }

        t2 = t * t;
        t4 = t2 * t2;

        if (i < num_rounds - 1) {
          tmp = xL
          xL = ((i==0) ? xR_in : xR) + t4*t;
          xR = (i==0) ? xL_in : tmp;
        } else {
          tmp = xL;
          xR_out = xR + t4 * t; 
          xL_out = xL;
        }
        */
    }
}

export function main(): i32 {
    mimc_cipher();
    return 0;
}

export function groth16Verify(): i32 {
  const SIZE_F = 32;
  let pFq12One = new ArrayBuffer(SIZE_F*12);
  bn128_ftm_one(pFq12One as usize);

  let input_data_len = input_size();
  let input_data_buff = new ArrayBuffer(input_data_len);
  input_data_copy(input_data_buff as usize, 0, input_data_len);

  let pAlfa1 = ( input_data_buff as usize ); // vk_a1.buffer as usize;
  let pBeta2 = ( input_data_buff as usize ) + 96;
  let pGamma2 = (input_data_buff as usize) + 288;
  let pDelta2 = ( input_data_buff as usize ) + 480; 

  let pA = ( input_data_buff as usize ) + 672;
  let pB = ( input_data_buff as usize ) + 768;
  let pC = ( input_data_buff as usize ) + 960;

  bn128_g1m_toMontgomery(pAlfa1, pAlfa1);
  bn128_g2m_toMontgomery(pBeta2, pBeta2);
  bn128_g2m_toMontgomery(pDelta2, pDelta2);
  bn128_g2m_toMontgomery(pGamma2, pGamma2);

  bn128_g1m_toMontgomery(pA, pA);
  bn128_g2m_toMontgomery(pB, pB);
  bn128_g1m_toMontgomery(pC, pC);

  let num_ic = Uint32Array.wrap(input_data_buff, 1056, 1)[0] as u32;
  let ic_start = ( input_data_buff as usize ) + 1060;
  let num_input = Uint32Array.wrap(input_data_buff, 1060 + num_ic * SIZE_F * 3, 2)[0] as u32;
  let input_start = ( input_data_buff as usize ) + 1060 + num_ic * SIZE_F * 3 + 4;

  // TODO assert input count == input constraint count - 1

  let pIC = ic_start;
  bn128_g1m_toMontgomery(pIC, pIC);

  for (let i = 0 as usize; i < num_input; i++ ) {
    // ICAux <== IC[i+1]
    let pICAux = pIC + ((i + 1) * SIZE_F * 3);

    // ICAux <== g1m_toMontgomery(ICAux)
    bn128_g1m_toMontgomery(pICAux, pICAux);

    // ICr <== input[i]
    let pICr = input_start + (i * SIZE_F);

    /* TODO add this back in after asc compiler bug is fixed
    if (int_gte(pICr, pr)) {
      return 1;
    }
    */

    bn128_g1m_timesScalar(pICAux, pICr, SIZE_F, pICAux);
    bn128_g1m_add(pICAux, pIC, pIC);
  }
  
  bn128_g1m_affine(pIC, pIC);
  bn128_g1m_neg(pIC, pIC);
  bn128_g1m_neg(pC, pC);
  bn128_g1m_neg(pAlfa1, pAlfa1);

  let return_buf = new Array<u32>(2);

  if (!bn128_pairingEq4(pA, pB, pIC, pGamma2, pC, pDelta2, pAlfa1, pBeta2, pFq12One as usize)) {
      return_buf[0] = 1;
  } else {
      return_buf[0] = 0;
  }

  save_output(return_buf.buffer as usize);

  return 0;
}
