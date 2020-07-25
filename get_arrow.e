//determine what arrow to display based on the ascii value
get_arrow       cpfa    arr_val         correct_arr     correct_i
                be      make_north      arr_val         w_ascii
                be      make_east       arr_val         d_ascii
                be      make_south      arr_val         s_ascii
                be      make_west       arr_val         a_ascii
                halt


//modules that set the address of the desired arrow from the concatenated bin file
make_north      cp      pixel           north_addr
                call    display_image   display_image_ret_addr
                ret     get_arrow_ret_addr

make_east       cp      pixel           east_addr
                call    display_image   display_image_ret_addr
                ret     get_arrow_ret_addr

make_south      cp      pixel           south_addr
                call    display_image   display_image_ret_addr
                ret     get_arrow_ret_addr

make_west       cp      pixel           west_addr
                call    display_image   display_image_ret_addr
                ret     get_arrow_ret_addr



arr_val                 0           //ascii value from array

north_addr              0           //address of first pixel of north arrow
east_addr               307200      //address of first pixel of east arrow
south_addr              614400      //address of first pixel of south arrow
west_addr               921600      //address of first pixel of west arrow


get_arrow_ret_addr      0           //return address

//#include sd_driver.e
//#include vga_driver.e

// make_north      cp      vga_x1        Nx1
//                 cp      vga_y1        Ny1
//                 cp      vga_x2        Nx2
//                 cp      vga_y2        Ny2
//                 cp      vga_color     Ncolor
//                 call    vga_driver    vga_ret_addr

//                 ret     return_symbols


// make_east       cp      vga_x1        Ex1
//                 cp      vga_y1        Ey1
//                 cp      vga_x2        Ex2
//                 cp      vga_y2        Ey2
//                 cp      vga_color     Ecolor
//                 call    vga_driver    vga_ret_addr

//                 ret     return_symbols


// make_south      cp      vga_x1        Sx1
//                 cp      vga_y1        Sy1
//                 cp      vga_x2        Sx2
//                 cp      vga_y2        Sy2
//                 cp      vga_color     Scolor
//                 call    vga_driver    vga_ret_addr

//                 ret     return_symbols


// make_west       cp      vga_x1        Wx1
//                 cp      vga_y1        Wy1
//                 cp      vga_x2        Wx2
//                 cp      vga_y2        Wy2
//                 cp      vga_color     Wcolor
//                 call    vga_driver    vga_ret_addr

//                 ret     return_symbols



// arr_val             -11111
// arrow_ret_addr      0

// Nx1        270
// Ny1        0
// Nx2        370
// Ny2        100
// Ncolor     3381759  //blue

// Ex1        539
// Ey1        190
// Ex2        639
// Ey2        290
// Ecolor     16711680 //red

// Sx1        270
// Sy1        379
// Sx2        370
// Sy2        479
// Scolor     32768    //green

// Wx1        0
// Wy1        190
// Wx2        100
// Wy2        290
// Wcolor     8421376  //yellow

//#include vgaDriver.e
