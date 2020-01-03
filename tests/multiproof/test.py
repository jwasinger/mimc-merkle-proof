import unittest

from merkle_tree import merkleize, verify_proof, compute_proof

class TestMerkleTree(unittest.TestCase):
    def test_basic(self):
        tree = merkleize([0, 1], [1, 2])

        proof_0 = compute_proof(tree, 0)
        # proof_1 = compute_proof(tree, 1)

        verify_proof(proof_0)
        # verify_proof(proof_1)

if __name__ == "__main__":
    unittest.main()
