#!/usr/bin/env python3
"""
Récupération du flag de Dy_task1 par attaque à texte clair connu.

Nous connaissons :
- une entrée claire composée de 47 caractères 'A' ;
- son résultat après custom_encrypt ;
- le résultat chiffré attendu par verify_flag.
"""

from pathlib import Path
import subprocess


PROJECT_DIR = Path(__file__).resolve().parent.parent
KNOWN_ENCRYPTED_PATH = PROJECT_DIR / "dumps" / "task1_47A_encrypted.bin"
EXPECTED_PATH = PROJECT_DIR / "dumps" / "task1_expected.bin"
BINARY_PATH = PROJECT_DIR / "Dy_task1"
FLAG_PATH = PROJECT_DIR / "1-flag.txt"

LENGTH = 47
KNOWN_BYTE = ord("A")


def ror8(value: int, count: int) -> int:
    """Rotation droite d'un octet."""
    count %= 8
    value &= 0xFF

    return (
        (value >> count)
        | ((value << (8 - count)) & 0xFF)
    )


def reverse_rotation_and_subtraction(encrypted: int) -> int:
    """
    Inverse :
        encrypted = rol8(value, 3) - 0x5b

    Donc :
        value = ror8(encrypted + 0x5b, 3)
    """
    return ror8((encrypted + 0x5B) & 0xFF, 3)


def main() -> int:
    encrypted_known = KNOWN_ENCRYPTED_PATH.read_bytes()
    expected = EXPECTED_PATH.read_bytes()

    if len(encrypted_known) != LENGTH:
        print(
            f"[-] Mauvaise taille pour {KNOWN_ENCRYPTED_PATH.name}: "
            f"{len(encrypted_known)}"
        )
        return 1

    if len(expected) != LENGTH:
        print(
            f"[-] Mauvaise taille pour {EXPECTED_PATH.name}: "
            f"{len(expected)}"
        )
        return 1

    # Récupération des 47 octets générés par le PRNG.
    keystream = bytes(
        reverse_rotation_and_subtraction(encrypted_byte)
        ^ KNOWN_BYTE
        for encrypted_byte in encrypted_known
    )

    # Déchiffrement de la référence attendue.
    plaintext = bytes(
        reverse_rotation_and_subtraction(expected_byte)
        ^ key_byte
        for expected_byte, key_byte in zip(expected, keystream)
    )

    print("--- Keystream récupéré ---")
    print(keystream.hex(" "))

    print("\n--- Texte déchiffré ---")
    print(repr(plaintext))

    try:
        flag = plaintext.decode("ascii")
    except UnicodeDecodeError:
        print("[-] Le résultat n'est pas une chaîne ASCII valide.")
        return 2

    print(f"\n[+] Candidat : {flag}")
    print(f"[+] Longueur : {len(flag)}")

    # Vérification normale sans GDB.
    result = subprocess.run(
        [str(BINARY_PATH)],
        input=plaintext + b"\n",
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )

    output = result.stdout.decode("utf-8", errors="replace")

    print("\n--- Vérification avec Dy_task1 ---")
    print(output.strip())

    if b"Correct flag!" not in result.stdout:
        print("[-] Le candidat est rejeté par le binaire.")
        return 3

    FLAG_PATH.write_bytes(plaintext + b"\n")

    print("\n[+] Flag accepté.")
    print(f"[+] Flag écrit dans {FLAG_PATH.name}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
