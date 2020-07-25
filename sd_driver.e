sd_driver       cp      0x80000082      sd_write                    //indicate whether to read (sd_write = 0) or write (sd_write = 1)
                cp      0x80000083      sd_address                  //specify what address to read/write
                cp      0x80000084      sd_data_write               //indicate value to write
                cp      0x80000080      sd_one                      //set sd_command to one
sd_bne_1        bne     sd_bne_1        0x80000081        sd_one    //wait for sd_response to be one
                cp      sd_data_read    0x80000085                  //read from specified address
                cp      0x80000080      sd_zero                     //set sd_command to zero
sd_bne_2        bne     sd_bne_2        0x80000081        sd_zero   //wait for sd_response to be zero
                ret     sd_ret_addr                                 //return


sd_one          1   //one
sd_zero         0   //zero

sd_write        0   //write (1) or read (0) indicator

sd_address      0   //address to read/write
sd_data_write   0   //value to write
sd_data_read    0   //value that is read

sd_ret_addr     0   //return address

