; ======================================================================
; ★ 段权限设置循环（DEP 问题所在）
; VA 0x102a89a2 .. 0x102a8ab2   file 0x39a2 .. 0x3ab2   (272 bytes)
; ======================================================================

102a89a2  c7 45 ba 02 00 00 00     mov      dword ptr [ebp - 0x46], 2
102a89a9  83 7d ba 04              cmp      dword ptr [ebp - 0x46], 4
102a89ad  74 1a                    je       0x102a89c9
102a89af  8b 45 7e                 mov      eax, dword ptr [ebp + 0x7e]
102a89b2  8b 00                    mov      eax, dword ptr [eax]
102a89b4  3b 46 3c                 cmp      eax, dword ptr [esi + 0x3c]
102a89b7  eb 10                    jmp      0x102a89c9
102a89b9  8d 45 b6                 lea      eax, [ebp - 0x4a]
102a89bc  50                       push     eax
102a89bd  ff 75 ba                 push     dword ptr [ebp - 0x46]
102a89c0  ff 75 4e                 push     dword ptr [ebp + 0x4e]
102a89c3  ff 75 be                 push     dword ptr [ebp - 0x42]
102a89c6  ff 55 6e                 call     dword ptr [ebp + 0x6e]
102a89c9  ff 45 5e                 inc      dword ptr [ebp + 0x5e]
102a89cc  83 45 7e 10              add      dword ptr [ebp + 0x7e], 0x10
102a89d0  8b 45 5e                 mov      eax, dword ptr [ebp + 0x5e]
102a89d3  3b 45 16                 cmp      eax, dword ptr [ebp + 0x16]
102a89d6  0f 83 99 00 00 00        jae      0x102a8a75
102a89dc  8b 45 7e                 mov      eax, dword ptr [ebp + 0x7e]
102a89df  6b 00 28                 imul     eax, dword ptr [eax], 0x28
102a89e2  8b 55 1e                 mov      edx, dword ptr [ebp + 0x1e]
102a89e5  01 c2                    add      edx, eax
102a89e7  89 d0                    mov      eax, edx
102a89e9  89 55 02                 mov      dword ptr [ebp + 2], edx
102a89ec  8b 95 96 fd ff ff        mov      edx, dword ptr [ebp - 0x26a]
102a89f2  03 50 0c                 add      edx, dword ptr [eax + 0xc]
102a89f5  8b 45 7e                 mov      eax, dword ptr [ebp + 0x7e]
102a89f8  89 55 be                 mov      dword ptr [ebp - 0x42], edx
102a89fb  8b 00                    mov      eax, dword ptr [eax]
102a89fd  3b 46 3c                 cmp      eax, dword ptr [esi + 0x3c]
102a8a00  75 06                    jne      0x102a8a08
102a8a02  8b 46 40                 mov      eax, dword ptr [esi + 0x40]
102a8a05  01 45 be                 add      dword ptr [ebp - 0x42], eax
102a8a08  8b 45 7e                 mov      eax, dword ptr [ebp + 0x7e]
102a8a0b  8b 40 08                 mov      eax, dword ptr [eax + 8]
102a8a0e  89 45 4e                 mov      dword ptr [ebp + 0x4e], eax
102a8a11  8d 45 ba                 lea      eax, [ebp - 0x46]
102a8a14  50                       push     eax
102a8a15  6a 04                    push     4
102a8a17  ff 75 4e                 push     dword ptr [ebp + 0x4e]
102a8a1a  ff 75 be                 push     dword ptr [ebp - 0x42]
102a8a1d  8d 5d be                 lea      ebx, [ebp - 0x42]
102a8a20  ff 55 6e                 call     dword ptr [ebp + 0x6e]
102a8a23  ff 75 6a                 push     dword ptr [ebp + 0x6a]
102a8a26  8b 4d 7e                 mov      ecx, dword ptr [ebp + 0x7e]
102a8a29  8d 55 b2                 lea      edx, [ebp - 0x4e]
102a8a2c  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a8a32  ff 75 4e                 push     dword ptr [ebp + 0x4e]
102a8a35  8b 49 0c                 mov      ecx, dword ptr [ecx + 0xc]
102a8a38  e8 c7 03 00 00           call     0x102a8e04
102a8a3d  8b 45 7e                 mov      eax, dword ptr [ebp + 0x7e]
102a8a40  8b 55 02                 mov      edx, dword ptr [ebp + 2]
102a8a43  8b 40 04                 mov      eax, dword ptr [eax + 4]
102a8a46  8b 52 24                 mov      edx, dword ptr [edx + 0x24]
102a8a49  25 00 00 00 80           and      eax, 0x80000000
102a8a4e  81 e2 00 00 00 80        and      edx, 0x80000000
102a8a54  39 d0                    cmp      eax, edx
102a8a56  0f 84 4d ff ff ff        je       0x102a89a9
102a8a5c  8b 45 7e                 mov      eax, dword ptr [ebp + 0x7e]
102a8a5f  f6 40 04 20              test     byte ptr [eax + 4], 0x20
102a8a63  0f 84 39 ff ff ff        je       0x102a89a2
102a8a69  c7 45 ba 20 00 00 00     mov      dword ptr [ebp - 0x46], 0x20
102a8a70  e9 34 ff ff ff           jmp      0x102a89a9
102a8a75  83 7e 24 00              cmp      dword ptr [esi + 0x24], 0
102a8a79  0f 84 2d 01 00 00        je       0x102a8bac
102a8a7f  8b 46 28                 mov      eax, dword ptr [esi + 0x28]
102a8a82  03 85 96 fd ff ff        add      eax, dword ptr [ebp - 0x26a]
102a8a88  89 45 2e                 mov      dword ptr [ebp + 0x2e], eax
102a8a8b  8b 46 2c                 mov      eax, dword ptr [esi + 0x2c]
102a8a8e  89 45 32                 mov      dword ptr [ebp + 0x32], eax
102a8a91  8b 45 4a                 mov      eax, dword ptr [ebp + 0x4a]
102a8a94  8b 40 60                 mov      eax, dword ptr [eax + 0x60]
102a8a97  8b 55 4a                 mov      edx, dword ptr [ebp + 0x4a]
102a8a9a  89 45 fe                 mov      dword ptr [ebp - 2], eax
102a8a9d  03 42 64                 add      eax, dword ptr [edx + 0x64]
102a8aa0  89 45 ea                 mov      dword ptr [ebp - 0x16], eax
102a8aa3  8d 45 c2                 lea      eax, [ebp - 0x3e]
102a8aa6  50                       push     eax
102a8aa7  6a 04                    push     4
102a8aa9  ff 75 32                 push     dword ptr [ebp + 0x32]
102a8aac  ff 75 2e                 push     dword ptr [ebp + 0x2e]
102a8aaf  ff 55 6e                 call     dword ptr [ebp + 0x6e]
