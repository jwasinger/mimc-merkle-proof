import unittest

from merkle_tree import MerkleProof, MerkleTree, MiMC

class TestMerkleTree(unittest.TestCase):
    def test_basic(self):
        hasher = MiMC()
        tree = MerkleTree([0, 1], [1, 2], 20, hasher)

        proof_0 = tree.compute_proof(0)
        self.assertTrue(proof_0.verify())

if __name__ == "__main__":
    unittest.main()
