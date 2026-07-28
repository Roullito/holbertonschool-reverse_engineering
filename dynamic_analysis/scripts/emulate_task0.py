#!/usr/bin/env python3
"""
Émulateur local de la fonction verify_flag du binaire Dy_task0.

Il reproduit :
- la structure du flag ;
- les quatre accumulateurs de la boucle ;
- les dépassements sur 32 bits ;
- le calcul final et la comparaison avec 44612.
"""

import sys


PREFIX = b"Holberton{"
FLAG_LENGTH = 35
BODY_LENGTH = 24
EXPECTED_RESULT = 0xAE44
FINAL_MODULUS = 987654


def u32(value: int) -> int:
    """Interprète une valeur comme un entier non signé sur 32 bits."""
    return value & 0xFFFFFFFF


def s32(value: int) -> int:
    """Interprète une valeur comme un entier signé sur 32 bits."""
    value &= 0xFFFFFFFF

    if value & 0x80000000:
        return value - 0x100000000

    return value


def s8(value: int) -> int:
    """Interprète un octet comme un signed char C."""
    value &= 0xFF

    if value & 0x80:
        return value - 0x100

    return value


def c_mod(dividend: int, divisor: int) -> int:
    """
    Reproduit le reste signé du langage C.

    En C, la division entière est tronquée vers zéro.
    Python utilise une division plancher pour les nombres négatifs,
    d'où cette fonction dédiée.
    """
    if divisor == 0:
        raise ZeroDivisionError("Modulo par zéro")

    quotient = abs(dividend) // abs(divisor)

    if (dividend < 0) != (divisor < 0):
        quotient = -quotient

    return dividend - quotient * divisor


def emulate(flag: str, verbose: bool = True) -> bool:
    """Reproduit la fonction verify_flag."""

    try:
        raw_flag = flag.encode("latin-1")
    except UnicodeEncodeError:
        print("[-] Le flag contient des caractères non représentables sur un octet.")
        return False

    if len(raw_flag) != FLAG_LENGTH:
        print(
            f"[-] Longueur incorrecte : {len(raw_flag)} "
            f"au lieu de {FLAG_LENGTH}."
        )
        return False

    if not raw_flag.startswith(PREFIX):
        print("[-] Préfixe incorrect.")
        return False

    if raw_flag[34] != ord("}"):
        print("[-] Le dernier caractère doit être '}'.")
        return False

    body = raw_flag[10:34]

    if len(body) != BODY_LENGTH:
        print("[-] Taille interne incorrecte.")
        return False

    sum1 = 0
    product = 1
    sum2 = 0
    xor_value = 1

    for i, byte in enumerate(body):
        character = s8(byte)

        term1 = c_mod(
            (i + 1) * character * (i + 2),
            256,
        )
        sum1 = s32(sum1 + term1)

        product_term = c_mod(
            character + 7 * i + 31,
            123,
        )
        product = s32(product * product_term)

        term2 = c_mod(
            (i + 1) * character + i * i,
            512,
        )
        sum2 = s32(sum2 + term2)

        xor_term = c_mod(
            (i + 3) * character + 17,
            1024,
        )
        xor_value = s32(u32(xor_value) ^ u32(xor_term))

        if verbose:
            print(
                f"i={i:02d} "
                f"char={character:4d} "
                f"sum1={sum1:6d} "
                f"product=0x{u32(product):08x} "
                f"sum2={sum2:6d} "
                f"xor=0x{u32(xor_value):08x}"
            )

    sum1_product = s32(sum1 * product)

    temporary = u32(
        sum1_product
        + sum2
        - xor_value
    )

    temporary = (
        temporary ^ 0xDEADBEEF
    ) & 0x00FFFFFF

    sum2_xor = s32(sum2 * xor_value)

    mixed_value = u32(
        sum1_product
        + temporary
        - sum2_xor
        + 0xCAFEBABE
    )

    final_result = mixed_value % FINAL_MODULUS
    accepted = final_result == EXPECTED_RESULT

    print("\n--- Résultats finaux ---")
    print(f"Body          : {body!r}")
    print(f"sum1          : {sum1}")
    print(
        f"product       : 0x{u32(product):08x} "
        f"(signé : {product})"
    )
    print(f"sum2          : {sum2}")
    print(f"xor_value     : 0x{u32(xor_value):x}")
    print(f"temporary     : 0x{temporary:06x}")
    print(f"mixed_value   : 0x{mixed_value:08x}")
    print(f"final_result  : {final_result} / 0x{final_result:x}")
    print(f"expected      : {EXPECTED_RESULT} / 0x{EXPECTED_RESULT:x}")
    print(f"accepted      : {accepted}")

    return accepted


def main() -> int:
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} 'Holberton{{...}}'")
        return 1

    flag = sys.argv[1]
    return 0 if emulate(flag) else 2


if __name__ == "__main__":
    raise SystemExit(main())
