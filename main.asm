;bootloader x86 develop by emmanuel.d.breyaue
;hello[at]emmanuelbreyaue.com

bits 16
org 0x7c00

;move label 
mov si, blbanner ;bootloaderbanner
mov ah, 0x0e
loop:
lodsb
test al, al
jz end
int 0x10
jmp loop

end:
hlt
blbanner: db "             ____       ,6P",13,10,"            6MMMMb    6MM'",13,10,"           6M'  `Mb  6M'",13,10,"____   ___ MM    M9 6M ____",13,10,"`MM(   )P' YM.  ,9  MMMMMMMb",13,10," `MM` ,P    YMMMMb  MM'   `Mb",13,10,"  `MM,P     6'  `Mb MM     MM",13,10,"   `MM.    6M    MM MM     MM",13,10,"   d`MM.   MM    MM MM     MM",13,10,"  d' `MM.  YM.  ,M9 YM.   ,M9",13,10,"_d_  _)MM_  YMMMM9   YMMMMM9",13,10,"   ",13,10,"   Bootloader Assembly Language",13,10,"   Develop by @nerdemma at emmanuelbreyaue.com",0 

times 510-($-$$) db 0
dw 0xAA55
