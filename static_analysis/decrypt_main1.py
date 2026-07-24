#!/usr/bin/env python3

encrypted_hex = (
    "9E89846A786585866A977D797C8463807C7F6B67"
    "848BAB907B698370896B997C797C8D6C6F7E81AE"
    "866AB36D7B7F669D7E6A7F96678F9382898263B474"
)

key = b"mysecretkey"

encrypted = bytes.fromhex(encrypted_hex)
decrypted = bytearray()

for i, encrypted_byte in enumerate(encrypted):
    current_key = key[i % len(key)]
    next_key = key[(i + 1) % len(key)]

    # Annule d'abord l'addition, puis le XOR.
    original_byte = ((encrypted_byte - next_key) & 0xFF) ^ current_key
    decrypted.append(original_byte)

print(decrypted.decode())
