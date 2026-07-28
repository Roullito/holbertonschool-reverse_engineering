set pagination off
set disassembly-flavor intel

break ptrace

commands
    silent
    printf "[+] Appel à ptrace intercepté\n"
    finish
    set $rax = 0
    printf "[+] Retour de ptrace forcé à 0\n"
    continue
end

run
