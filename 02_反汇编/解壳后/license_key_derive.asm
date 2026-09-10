; ======================================================================
; 密钥派生
; RVA 0x1ef10 .. 0x1f010   VA 0x1001ef10 .. 0x1001f010   (256 bytes)
; ======================================================================

1001ef10  83 ec 0c                 sub      esp, 0xc
1001ef13  80 05 80 96 10 10 55     add      byte ptr [0x10109680], 0x55
1001ef1a  a0 81 96 10 10           mov      al, byte ptr [0x10109681]
1001ef1f  8a 25 82 96 10 10        mov      ah, byte ptr [0x10109682]
1001ef25  04 55                    add      al, 0x55
1001ef27  80 c4 55                 add      ah, 0x55
1001ef2a  a2 81 96 10 10           mov      byte ptr [0x10109681], al
1001ef2f  a0 83 96 10 10           mov      al, byte ptr [0x10109683]
1001ef34  04 55                    add      al, 0x55
1001ef36  88 25 82 96 10 10        mov      byte ptr [0x10109682], ah
1001ef3c  8a 25 84 96 10 10        mov      ah, byte ptr [0x10109684]
1001ef42  a2 83 96 10 10           mov      byte ptr [0x10109683], al
1001ef47  80 c4 55                 add      ah, 0x55
1001ef4a  a0 85 96 10 10           mov      al, byte ptr [0x10109685]
1001ef4f  04 55                    add      al, 0x55
1001ef51  88 25 84 96 10 10        mov      byte ptr [0x10109684], ah
1001ef57  8a 25 86 96 10 10        mov      ah, byte ptr [0x10109686]
1001ef5d  a2 85 96 10 10           mov      byte ptr [0x10109685], al
1001ef62  80 c4 55                 add      ah, 0x55
1001ef65  a0 87 96 10 10           mov      al, byte ptr [0x10109687]
1001ef6a  04 55                    add      al, 0x55
1001ef6c  88 25 86 96 10 10        mov      byte ptr [0x10109686], ah
1001ef72  8a 25 88 96 10 10        mov      ah, byte ptr [0x10109688]
1001ef78  a2 87 96 10 10           mov      byte ptr [0x10109687], al
1001ef7d  80 c4 55                 add      ah, 0x55
1001ef80  a0 89 96 10 10           mov      al, byte ptr [0x10109689]
1001ef85  04 55                    add      al, 0x55
1001ef87  88 25 88 96 10 10        mov      byte ptr [0x10109688], ah
1001ef8d  8a 25 8a 96 10 10        mov      ah, byte ptr [0x1010968a]
1001ef93  a2 89 96 10 10           mov      byte ptr [0x10109689], al
1001ef98  80 c4 55                 add      ah, 0x55
1001ef9b  a0 8b 96 10 10           mov      al, byte ptr [0x1010968b]
1001efa0  04 55                    add      al, 0x55
1001efa2  88 25 8a 96 10 10        mov      byte ptr [0x1010968a], ah
1001efa8  8a 25 8c 96 10 10        mov      ah, byte ptr [0x1010968c]
1001efae  a2 8b 96 10 10           mov      byte ptr [0x1010968b], al
1001efb3  80 c4 55                 add      ah, 0x55
1001efb6  a0 8d 96 10 10           mov      al, byte ptr [0x1010968d]
1001efbb  04 55                    add      al, 0x55
1001efbd  88 25 8c 96 10 10        mov      byte ptr [0x1010968c], ah
1001efc3  8a 25 8e 96 10 10        mov      ah, byte ptr [0x1010968e]
1001efc9  a2 8d 96 10 10           mov      byte ptr [0x1010968d], al
1001efce  80 c4 55                 add      ah, 0x55
1001efd1  a0 8f 96 10 10           mov      al, byte ptr [0x1010968f]
1001efd6  04 55                    add      al, 0x55
1001efd8  88 25 8e 96 10 10        mov      byte ptr [0x1010968e], ah
1001efde  83 c4 0c                 add      esp, 0xc
1001efe1  a2 8f 96 10 10           mov      byte ptr [0x1010968f], al
1001efe6  c3                       ret      
1001efe7  8b f6                    mov      esi, esi
1001efe9  8d bc 27 00 00 00 00     lea      edi, [edi]
1001eff0  8b 44 24 04              mov      eax, dword ptr [esp + 4]
1001eff4  56                       push     esi
1001eff5  0f b6 10                 movzx    edx, byte ptr [eax]
1001eff8  85 d2                    test     edx, edx
1001effa  74 15                    je       0x1001f011
1001effc  0f b7 4c 24 0e           movzx    ecx, word ptr [esp + 0xe]
1001f001  83 c2 f8                 add      edx, -8
1001f004  33 d1                    xor      edx, ecx
1001f006  88 10                    mov      byte ptr [eax], dl
1001f008  0f b6 50 01              movzx    edx, byte ptr [eax + 1]
1001f00c  40                       inc      eax
1001f00d  85 d2                    test     edx, edx
