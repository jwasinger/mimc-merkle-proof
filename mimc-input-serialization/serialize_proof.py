import json
import binascii

public_input = None
vk = None
proof = None

def count_to_8_bytes(count):
  return binascii.hexlify(count.to_bytes(8, 'little')).decode()

def num_to_hex(g1):
  result = bytearray.fromhex(hex(int(g1))[2:].zfill(64))
  result.reverse()
  return binascii.hexlify(result).decode()

if __name__ == "__main__":
    mimc_input = None
    with open("input.json") as f:
      mimc_input = json.load(f)

    k = mimc_input['k'][2:]
    num_inputs = count_to_8_bytes(len(mimc_input['inputs']))
    inputs = ''

    for inp in mimc_input['inputs']:
        # print(mimc_input['inputs'][i])
        inputs += inp[2:]

    print("serialized input:")
    print('0x'+k+num_inputs+inputs)
