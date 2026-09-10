; ======================================================================
; ★ MIDI 程序名查询 (崩溃点 0x16144)
; RVA 0x16120 .. 0x16160   VA 0x10016120 .. 0x10016160   (64 bytes)
; ======================================================================

10016120  55                       push     ebp
10016121  8b ec                    mov      ebp, esp
10016123  83 ec 0c                 sub      esp, 0xc
10016126  8b 45 08                 mov      eax, dword ptr [ebp + 8]
10016129  85 c0                    test     eax, eax
1001612b  7c 05                    jl       0x10016132
1001612d  83 f8 12                 cmp      eax, 0x12
10016130  7e 08                    jle      0x1001613a
10016132  33 c0                    xor      eax, eax
10016134  8b e5                    mov      esp, ebp
10016136  5d                       pop      ebp
10016137  c2 04 00                 ret      4
1001613a  57                       push     edi
1001613b  89 04 24                 mov      dword ptr [esp], eax
1001613e  8b 89 84 01 00 00        mov      ecx, dword ptr [ecx + 0x184]
10016144  8b 11                    mov      edx, dword ptr [ecx]
10016146  8b 82 8c 00 00 00        mov      eax, dword ptr [edx + 0x8c]
1001614c  ff d0                    call     eax
1001614e  8b e5                    mov      esp, ebp
10016150  5d                       pop      ebp
10016151  c2 04 00                 ret      4
10016154  8d b6 00 00 00 00        lea      esi, [esi]
1001615a  8d bf 00 00 00 00        lea      edi, [edi]
