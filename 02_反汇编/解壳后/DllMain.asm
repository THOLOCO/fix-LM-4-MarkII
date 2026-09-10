; ======================================================================
; DllMain
; RVA 0xf8480 .. 0xf8580   VA 0x100f8480 .. 0x100f8580   (256 bytes)
; ======================================================================

100f8480  8b 44 24 08              mov      eax, dword ptr [esp + 8]
100f8484  83 f8 01                 cmp      eax, 1
100f8487  0f 85 88 00 00 00        jne      0x100f8515
100f848d  ff 15 b4 11 10 10        call     dword ptr [0x101011b4]
100f8493  6a 01                    push     1
100f8495  a3 30 3d 18 10           mov      dword ptr [0x10183d30], eax
100f849a  e8 85 39 00 00           call     0x100fbe24
100f849f  85 c0                    test     eax, eax
100f84a1  59                       pop      ecx
100f84a2  74 3c                    je       0x100f84e0
100f84a4  a1 30 3d 18 10           mov      eax, dword ptr [0x10183d30]
100f84a9  33 c9                    xor      ecx, ecx
100f84ab  8a 0d 31 3d 18 10        mov      cl, byte ptr [0x10183d31]
100f84b1  25 ff 00 00 00           and      eax, 0xff
100f84b6  c1 2d 30 3d 18 10 10     shr      dword ptr [0x10183d30], 0x10
100f84bd  a3 38 3d 18 10           mov      dword ptr [0x10183d38], eax
100f84c2  89 0d 3c 3d 18 10        mov      dword ptr [0x10183d3c], ecx
100f84c8  c1 e0 08                 shl      eax, 8
100f84cb  03 c1                    add      eax, ecx
100f84cd  a3 34 3d 18 10           mov      dword ptr [0x10183d34], eax
100f84d2  e8 25 0a 00 00           call     0x100f8efc
100f84d7  85 c0                    test     eax, eax
100f84d9  75 09                    jne      0x100f84e4
100f84db  e8 80 39 00 00           call     0x100fbe60
100f84e0  33 c0                    xor      eax, eax
100f84e2  eb 72                    jmp      0x100f8556
100f84e4  ff 15 b8 11 10 10        call     dword ptr [0x101011b8]
100f84ea  a3 6c 43 18 10           mov      dword ptr [0x1018436c], eax
100f84ef  e8 65 4d 00 00           call     0x100fd259
100f84f4  a3 90 3c 18 10           mov      dword ptr [0x10183c90], eax
100f84f9  e8 1d 30 00 00           call     0x100fb51b
100f84fe  e8 09 4b 00 00           call     0x100fd00c
100f8503  e8 4b 4a 00 00           call     0x100fcf53
100f8508  e8 2c 33 00 00           call     0x100fb839
100f850d  ff 05 8c 3c 18 10        inc      dword ptr [0x10183c8c]
100f8513  eb 3e                    jmp      0x100f8553
100f8515  33 c9                    xor      ecx, ecx
100f8517  3b c1                    cmp      eax, ecx
100f8519  75 2c                    jne      0x100f8547
100f851b  39 0d 8c 3c 18 10        cmp      dword ptr [0x10183c8c], ecx
100f8521  7e bd                    jle      0x100f84e0
100f8523  ff 0d 8c 3c 18 10        dec      dword ptr [0x10183c8c]
100f8529  39 0d 68 3d 18 10        cmp      dword ptr [0x10183d68], ecx
100f852f  75 05                    jne      0x100f8536
100f8531  e8 41 33 00 00           call     0x100fb877
100f8536  e8 9c 31 00 00           call     0x100fb6d7
100f853b  e8 10 0a 00 00           call     0x100f8f50
100f8540  e8 1b 39 00 00           call     0x100fbe60
100f8545  eb 0c                    jmp      0x100f8553
100f8547  83 f8 03                 cmp      eax, 3
100f854a  75 07                    jne      0x100f8553
100f854c  51                       push     ecx
100f854d  e8 96 0a 00 00           call     0x100f8fe8
100f8552  59                       pop      ecx
100f8553  6a 01                    push     1
100f8555  58                       pop      eax
100f8556  c2 0c 00                 ret      0xc
100f8559  55                       push     ebp
100f855a  8b ec                    mov      ebp, esp
100f855c  53                       push     ebx
100f855d  8b 5d 08                 mov      ebx, dword ptr [ebp + 8]
100f8560  56                       push     esi
100f8561  8b 75 0c                 mov      esi, dword ptr [ebp + 0xc]
100f8564  57                       push     edi
100f8565  8b 7d 10                 mov      edi, dword ptr [ebp + 0x10]
100f8568  85 f6                    test     esi, esi
100f856a  75 09                    jne      0x100f8575
100f856c  83 3d 8c 3c 18 10 00     cmp      dword ptr [0x10183c8c], 0
100f8573  eb 26                    jmp      0x100f859b
100f8575  83 fe 01                 cmp      esi, 1
100f8578  74 05                    je       0x100f857f
100f857a  83 fe 02                 cmp      esi, 2
100f857d  75 22                    jne      0x100f85a1
