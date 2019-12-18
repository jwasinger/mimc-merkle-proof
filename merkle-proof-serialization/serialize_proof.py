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
    proof = None
    with open("input.json") as f:
      proof = json.load(f)

    root = num_to_hex(int(proof['root']))

    num_witnesses = count_to_8_bytes(len(proof['pathElements']))
    witnesses = []
    indices = []

    for witness in proof['pathElements']:
        witnesses.append(num_to_hex(int(witness)))

    for pathIndex in proof['pathIndices']:
        indices.append(count_to_8_bytes(pathIndex))

    witnesses = ''.join(witnesses)

    # TODO replace selector list with the actual index in the tree
    selectors = ''.join(indices)

    import pdb; pdb.set_trace()
    print("serialized input:")
    print("0x"+root+num_witnesses+witnesses+selectors)
