fill_screen     be      blue        key_input         w_ascii
                be      green       key_input         d_ascii
                be      red         key_input         s_ascii
                be      yellow      key_input         a_ascii

                ret     fill_screen_ret_addr



blue            cp      fill_color  fill_blue
                be      fill        fill_1200    fill_1200

green           cp      fill_color  fill_green
                be      fill        fill_1200    fill_1200

red             cp      fill_color  fill_red
                be      fill        fill_1200    fill_1200

yellow          cp      fill_color  fill_yellow
                be      fill        fill_1200    fill_1200



fill            cp      vga_x1        fill_screen_x1
                cp      vga_y1        fill_screen_y1
                cp      vga_x2        fill_screen_x2
                cp      vga_y2        fill_screen_y2
                cp      vga_color     fill_color
                call    vga_driver    vga_ret_addr

                cp      fill_time     0x80000005                           //store time value
                add     fill_time     fill_time         fill_1200          //add 1200 to time value
fill_wait       bne     fill_wait     0x80000005        fill_time          //wait for clock to reach time value

fill_clear      cp      vga_x1        fill_screen_x1
                cp      vga_y1        fill_screen_y1
                cp      vga_x2        fill_screen_x2
                cp      vga_y2        fill_screen_y2
                cp      vga_color     fill_white
                call    vga_driver    vga_ret_addr

                ret     fill_screen_ret_addr


//dimensions of VGA
fill_screen_x1      50
fill_screen_y1      50
fill_screen_x2      589
fill_screen_y2      429

//colors to fill
fill_color          -111
fill_white          0xffffff
fill_blue           0x4ccfff
fill_green          0x4bf262
fill_red            0xff2630
fill_yellow         0xfff844

fill_time           0       //stored clock value
fill_1200           1200    //1200



fill_screen_ret_addr    0
