; ======================================================================
; 导出跳转 thunk
; RVA 0x1b8a0 .. 0x1b900   VA 0x1001b8a0 .. 0x1001b900   (96 bytes)
; ======================================================================

1001b8a0  55                       push     ebp
1001b8a1  8b ec                    mov      ebp, esp
1001b8a3  83 ec 18                 sub      esp, 0x18
1001b8a6  89 1c 24                 mov      dword ptr [esp], ebx
1001b8a9  8b d9                    mov      ebx, ecx
1001b8ab  8b cb                    mov      ecx, ebx
1001b8ad  e8 8e fd ff ff           call     0x1001b640
1001b8b2  8b 45 08                 mov      eax, dword ptr [ebp + 8]
1001b8b5  a8 01                    test     al, 1
1001b8b7  75 09                    jne      0x1001b8c2
1001b8b9  8b 1c 24                 mov      ebx, dword ptr [esp]
1001b8bc  8b e5                    mov      esp, ebp
1001b8be  5d                       pop      ebp
1001b8bf  c2 04 00                 ret      4
1001b8c2  83 c4 f8                 add      esp, -8
1001b8c5  89 1c 24                 mov      dword ptr [esp], ebx
1001b8c8  e8 63 e7 02 00           call     0x1004a030
1001b8cd  83 c4 08                 add      esp, 8
1001b8d0  eb e7                    jmp      0x1001b8b9
1001b8d2  8d b4 26 00 00 00 00     lea      esi, [esi]
1001b8d9  8d bc 27 00 00 00 00     lea      edi, [edi]
1001b8e0  55                       push     ebp
1001b8e1  8b ec                    mov      ebp, esp
1001b8e3  6a ff                    push     -1
1001b8e5  68 80 bb 01 10           push     0x1001bb80
1001b8ea  64 a1 00 00 00 00        mov      eax, dword ptr fs:[0]
1001b8f0  50                       push     eax
1001b8f1  64 89 25 00 00 00 00     mov      dword ptr fs:[0], esp
1001b8f8  83 ec 54                 sub      esp, 0x54
1001b8fb  89 7c 24 08              mov      dword ptr [esp + 8], edi
