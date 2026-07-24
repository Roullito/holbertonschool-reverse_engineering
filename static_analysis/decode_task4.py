#!/usr/bin/env python3

obfuscated_flag = [
    0x8A, 0x101, 0x11E, 0x178, 0x163, 0x108, 0x136,
    0x101, 0x104, 0x12D, 0x178, 0x17F, 0x165, 0x11D,
    0x171, 0x136, 0x101, 0x171, 0x17F, 0x135, 0x135,
    0x163, 0x11B, 0x178, 0x11E, 0x127, 0x3F, 0x12B
]

decoded = []

for index, value in enumerate(obfuscated_flag):
    transformed = (value ^ 0x55) - 7
    quotient, remainder = divmod(transformed, 3)

    character = chr(quotient)
    decoded.append(character)

    print(
        f"{index:02d}: "
        f"value=0x{value:X} "
        f"transformed={transformed} "
        f"quotient={quotient} "
        f"remainder={remainder} "
        f"character={character!r}"
    )

print("\nDecoded flag:", "".join(decoded))
