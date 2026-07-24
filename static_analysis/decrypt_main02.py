#!/usr/bin/env python3

encrypted_blocks_hex = [
    "8e82d972b66c836f",
    "a896da60a7779a69",
    "bc84db77a0729877",
    "a582d1758c778461",
    "a883da69ba70905f",
    "a498c14fba6da861",
    "9980c063a763f700",
]

exponent = 0x0000FFFFFFFFFFFF
modulus = 0x0FFFFFFFFFFFFFFB

key = pow(2, exponent, modulus)

print(f"Calculated key: {key}")
print(f"Calculated key in hexadecimal: 0x{key:016x}")

decrypted_flag = bytearray()

for index, block_hex in enumerate(encrypted_blocks_hex):
    encrypted_block = int.from_bytes(
        bytes.fromhex(block_hex),
        byteorder="little"
    )

    decrypted_block = encrypted_block ^ key

    block_bytes = decrypted_block.to_bytes(
        8,
        byteorder="little"
    )

    print(f"Block {index}: {block_bytes!r}")

    # Reproduit le comportement du binaire : les octets nuls ne sont
    # pas affichés par slow_decrypt_flag.
    decrypted_flag.extend(byte for byte in block_bytes if byte != 0)

print(f"\nDecrypted flag: {decrypted_flag.decode('ascii')}")
