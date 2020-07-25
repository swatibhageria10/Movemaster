display_image   bne         outer_while     row_max         column_max      //go to nested loops

//nested while loops that set each pixel of the VGA to the desired color
outer_while     add         y               y               sd_one          //increment y-coordinate
                cp          x               sd_zero                         //set x-coordinate to 0

inner_while     cp          sd_address      pixel                           //indicate what pixel to start on
                call        sd_driver       sd_ret_addr                     //call SD card driver
                cp          color           sd_data_read                    //fetch color value of pixel
                cp          vga_x1          x                               //set first x-coordinate
                cp          vga_y1          y                               //set first y-coordinate
                cp          vga_x2          x                               //set second x-coordinate
                cp          vga_y2          y                               //set second y-coordinate
                cp          vga_color       color                           //set color
                call        vga_driver      vga_ret_addr                    //call VGA driver
                add         pixel           pixel           sd_one          //increment pixel
                add         x               x               sd_one          //increment x-coordinate
                bne         inner_while     x               column_max      //check if at end of row

                bne         outer_while     y               row_max         //check if done displaying

                cp          x               prng_zero                       //reset x-coordinate
                cp          y               prng_neg_one                    //reset y-coordinate

                ret         display_image_ret_addr                          //return to main



row_max                 479         //end of column
column_max              640         //end of row

x                       0           //x-coordinate
y                       -1          //y-coordinate
color                   0           //color value

pixel                   0           //address of first pixel


display_image_ret_addr  0