vga_driver      cp      0x80000063      vga_x1
                cp      0x80000064      vga_y1
                cp      0x80000065      vga_x2
                cp      0x80000066      vga_y2
                cp      0x80000062      vga_write
                cp      0x80000067      vga_color
                cp      0x80000060      vga_one	
vga_bne_1       bne     vga_bne_1       0x80000061     vga_one
                cp      0x80000060      vga_zero
vga_bne_2       bne     vga_bne_2       0x80000061     vga_zero
                ret     vga_ret_addr

vga_one         1     //one
vga_zero        0     //zero

vga_write       1     //write signal

vga_x1          0     //first x-coordinate
vga_y1          0     //first y-coordinate
vga_x2          0     //second x-coordinate
vga_y2          0     //second y-coordinate
vga_color       0     //color value

vga_ret_addr    0     //return address
