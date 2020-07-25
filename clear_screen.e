clear_screen    cp          vga_x1          clear_x1                            //set first x-coordinate
                cp          vga_x2          clear_x2                            //set second x-coordinate
clear_while     cp          vga_y1          clear_y                             //set first y-coordinate
                cp          vga_y2          clear_y                             //set second y-coordinate
                cp          vga_color       clear_color                         //set color
                call        vga_driver      vga_ret_addr                        //call VGA driver

                cp          clear_time      0x80000005                          //store time value
                add         clear_time      clear_time      clear_nine          //add seven to time value
clear_wait      bne         clear_wait      0x80000005      clear_time          //wait for clock to reach time value

                sub         clear_y         clear_y         clear_one           //decrement y-coordinate
                bne         clear_while     clear_y         clear_neg_one       //check if screen is clear

                cp          clear_y         clear_y_reset                       //reset y-coordinate
                ret         clear_screen_ret_addr                               //return to main



clear_nine              9
clear_one               1
clear_neg_one           -1

clear_x1                0
clear_x2                639
clear_y                 479
clear_color             0xffffff
clear_y_reset           479

clear_time              0

clear_screen_ret_addr   0
