; ======================================================================
; 注册表读取封装
; RVA 0x1f020 .. 0x1f0b0   VA 0x1001f020 .. 0x1001f0b0   (144 bytes)
; ======================================================================

1001f020  55                       push     ebp
1001f021  8b ec                    mov      ebp, esp
1001f023  83 ec 28                 sub      esp, 0x28
1001f026  89 1c 24                 mov      dword ptr [esp], ebx
1001f029  83 c4 ec                 add      esp, -0x14
1001f02c  8d 45 f8                 lea      eax, [ebp - 8]
1001f02f  8b 55 08                 mov      edx, dword ptr [ebp + 8]
1001f032  89 44 24 10              mov      dword ptr [esp + 0x10], eax
1001f036  c7 44 24 0c 01 00 00 00  mov      dword ptr [esp + 0xc], 1
1001f03e  33 db                    xor      ebx, ebx
1001f040  c7 44 24 08 00 00 00 00  mov      dword ptr [esp + 8], 0
1001f048  89 54 24 04              mov      dword ptr [esp + 4], edx
1001f04c  c7 04 24 02 00 00 80     mov      dword ptr [esp], 0x80000002
1001f053  ff 15 0c 10 10 10        call     dword ptr [0x1010100c]
1001f059  85 c0                    test     eax, eax
1001f05b  75 46                    jne      0x1001f0a3
1001f05d  83 c4 e8                 add      esp, -0x18
1001f060  8d 45 14                 lea      eax, [ebp + 0x14]
1001f063  8b 55 10                 mov      edx, dword ptr [ebp + 0x10]
1001f066  89 44 24 14              mov      dword ptr [esp + 0x14], eax
1001f06a  89 54 24 10              mov      dword ptr [esp + 0x10], edx
1001f06e  8d 45 fc                 lea      eax, [ebp - 4]
1001f071  8b 55 0c                 mov      edx, dword ptr [ebp + 0xc]
1001f074  89 44 24 0c              mov      dword ptr [esp + 0xc], eax
1001f078  c7 44 24 08 00 00 00 00  mov      dword ptr [esp + 8], 0
1001f080  89 54 24 04              mov      dword ptr [esp + 4], edx
1001f084  8b 45 f8                 mov      eax, dword ptr [ebp - 8]
1001f087  89 04 24                 mov      dword ptr [esp], eax
1001f08a  ff 15 10 10 10 10        call     dword ptr [0x10101010]
1001f090  85 c0                    test     eax, eax
1001f092  75 05                    jne      0x1001f099
1001f094  bb 01 00 00 00           mov      ebx, 1
1001f099  8b 45 f8                 mov      eax, dword ptr [ebp - 8]
1001f09c  50                       push     eax
1001f09d  ff 15 08 10 10 10        call     dword ptr [0x10101008]
1001f0a3  8b c3                    mov      eax, ebx
1001f0a5  8b 1c 24                 mov      ebx, dword ptr [esp]
1001f0a8  8b e5                    mov      esp, ebp
1001f0aa  5d                       pop      ebp
1001f0ab  c2 10 00                 ret      0x10
1001f0ae  8b f6                    mov      esi, esi
