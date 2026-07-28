#!/usr/bin/env python3
"""
Résolution de Dy_task0 avec Z3.

Stratégie :
- les 20 premiers caractères du corps sont fixés à 'A' ;
- les 4 derniers caractères sont symboliques ;
- tous les calculs sont reproduits avec des BitVec 32 bits ;
- le résultat est vérifié avec le vrai binaire.
"""

from pathlib import Path
import subprocess
import sys

from z3 import (
    BitVec,
    BitVecVal,
    SolverFor,
    UGE,
    ULE,
    URem,
    ZeroExt,
    sat,
)


# Chemins relatifs au dépôt, sans chemin absolu codé en dur.
PROJECT_DIR = Path(__file__).resolve().parent.parent
BINARY_PATH = PROJECT_DIR / "Dy_task0"
FLAG_FILE = PROJECT_DIR / "0-flag.txt"

PREFIX = b"Holberton{"
SUFFIX = b"}"

BODY_LENGTH = 24
FIXED_LENGTH = 20
SYMBOLIC_LENGTH = BODY_LENGTH - FIXED_LENGTH

EXPECTED_RESULT = 0xAE44
FINAL_MODULUS = 987654


def bv32(value: int):
    """Crée une constante BitVec de 32 bits."""
    return BitVecVal(value & 0xFFFFFFFF, 32)


def build_solver():
    """
    Construit les contraintes correspondant à verify_flag.
    """

    solver = SolverFor("QF_BV")

    # Quatre derniers caractères inconnus.
    unknown = [
        BitVec(f"c{i}", 8)
        for i in range(SYMBOLIC_LENGTH)
    ]

    # scanf("%49s") ne peut pas lire d'espace dans le flag.
    # On limite donc les caractères inconnus à l'ASCII imprimable
    # de '!' (0x21) à '~' (0x7e).
    for character in unknown:
        solver.add(UGE(character, BitVecVal(0x21, 8)))
        solver.add(ULE(character, BitVecVal(0x7E, 8)))

    # Les 20 premiers caractères du body sont des constantes 'A'.
    body = [
        BitVecVal(ord("A"), 8)
        for _ in range(FIXED_LENGTH)
    ]

    # Puis viennent les quatre caractères symboliques.
    body.extend(unknown)

    assert len(body) == BODY_LENGTH

    # Variables initiales observées dans verify_flag.
    sum1 = bv32(0)
    product = bv32(1)
    sum2 = bv32(0)
    xor_value = bv32(1)

    for i, character8 in enumerate(body):
        # Le binaire charge chaque caractère puis travaille sur 32 bits.
        character = ZeroExt(24, character8)

        # sum1 += ((i + 1) * character * (i + 2)) % 256
        term1 = URem(
            bv32(i + 1) * character * bv32(i + 2),
            bv32(256),
        )
        sum1 = sum1 + term1

        # product *= (character + 7*i + 31) % 123
        product_term = URem(
            character + bv32(7 * i + 31),
            bv32(123),
        )
        product = product * product_term

        # sum2 += ((i + 1) * character + i*i) % 512
        term2 = URem(
            bv32(i + 1) * character + bv32(i * i),
            bv32(512),
        )
        sum2 = sum2 + term2

        # xor_value ^= ((i + 3) * character + 17) % 1024
        xor_term = URem(
            bv32(i + 3) * character + bv32(17),
            bv32(1024),
        )
        xor_value = xor_value ^ xor_term

    # temporary =
    #   ((sum1 * product + sum2 - xor_value) ^ 0xdeadbeef)
    #   & 0x00ffffff
    temporary = (
        (
            sum1 * product
            + sum2
            - xor_value
        )
        ^ bv32(0xDEADBEEF)
    ) & bv32(0x00FFFFFF)

    # mixed_value =
    #   sum1 * product
    #   + temporary
    #   - sum2 * xor_value
    #   + 0xcafebabe
    mixed_value = (
        sum1 * product
        + temporary
        - sum2 * xor_value
        + bv32(0xCAFEBABE)
    )

    # Le dernier calcul est un reste NON SIGNÉ.
    final_result = URem(
        mixed_value,
        bv32(FINAL_MODULUS),
    )

    solver.add(final_result == bv32(EXPECTED_RESULT))

    return solver, unknown, {
        "sum1": sum1,
        "product": product,
        "sum2": sum2,
        "xor_value": xor_value,
        "temporary": temporary,
        "mixed_value": mixed_value,
        "final_result": final_result,
    }


def verify_with_binary(flag: bytes) -> bool:
    """Teste directement le candidat avec Dy_task0."""

    if not BINARY_PATH.exists():
        print(f"[-] Binaire introuvable : {BINARY_PATH}")
        return False

    result = subprocess.run(
        [str(BINARY_PATH)],
        input=flag + b"\n",
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )

    print("\n--- Vérification avec le vrai binaire ---")
    print(result.stdout.decode("utf-8", errors="replace").strip())

    return b"Correct flag!" in result.stdout


def main() -> int:
    solver, unknown, expressions = build_solver()

    print("[*] Recherche de quatre caractères symboliques...")
    print("[*] Forme : Holberton{AAAAAAAAAAAAAAAAAAAA????}")

    status = solver.check()
    print(f"[*] Résultat Z3 : {status}")

    if status != sat:
        print("[-] Aucun candidat trouvé avec ce préfixe fixe.")
        return 1

    model = solver.model()

    symbolic_bytes = bytes(
        model.eval(character, model_completion=True).as_long()
        for character in unknown
    )

    body = b"A" * FIXED_LENGTH + symbolic_bytes
    flag = PREFIX + body + SUFFIX

    print("\n--- Modèle trouvé ---")
    for index, value in enumerate(symbolic_bytes):
        print(
            f"c{index} = {value:3d} "
            f"= 0x{value:02x} "
            f"= {chr(value)!r}"
        )

    print(f"\nBody : {body!r}")
    print(f"Flag : {flag.decode('ascii')}")
    print(f"Taille : {len(flag)} octets")

    print("\n--- Valeurs symboliques finales ---")
    for name, expression in expressions.items():
        value = model.eval(expression, model_completion=True).as_long()
        print(f"{name:12s} = {value:10d} / 0x{value:08x}")

    if not verify_with_binary(flag):
        print("[-] Z3 a produit un candidat rejeté par le binaire.")
        print("[-] Il existe probablement une différence de sémantique.")
        return 2

    FLAG_FILE.write_bytes(flag + b"\n")

    print(f"\n[+] Flag accepté.")
    print(f"[+] Flag enregistré dans : {FLAG_FILE.name}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
