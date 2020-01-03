import unittest

from merkle_tree import merkleize

class TestMerkleTree(unittest.TestCase):
    def test_basic(self):
        print(merkleize([0, 1], [1, 2]))

if __name__ == "__main__":
    unittest.main()
