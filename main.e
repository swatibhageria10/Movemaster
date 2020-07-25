//figure out how to display images on the VGA
//SD card driver (FUUUUUUUUUUUUCK yes)
//create images:
//  start screen (Move Master, press any key, team logo, names)
//  (menu screen - later?)
//  game directions screen (follow the pattern closely?)
//  input arrows screen (repeat the pattern?)
//  arrows themselves (up, right, down, left)
//  (maybe a level counter?)
//  game over
//implement displaying arrows on input
//finish game over screen

//stretch goals:
//implement menu screen?
//new modes? (speedrun, backwards, etc.)
//sound?

//bin file image order (with addresses):
//up_arrow      (0)
//right_arrow   (307200)
//down_arrow    (614400)
//left_arrow    (921600)
//title         (1228800)
//menu          (1536000)
//rules         (1843200)
//watch         (2150400)
//go3           (2457600)
//go2           (2764800)
//go1           (3072000)
//cleared       (3379200)
//game over     (3686400)
//thanks        (3993600)





//display title screen and prompt to press any key
title_screen    call    clear_screen    clear_screen_ret_addr       //clear the screen
                cp      pixel           title_address               //set correct pixel address
                call    display_image   display_image_ret_addr      //display image



//run the keyboard driver and continue if any key is pressed
title_key 	    call	ps2_driver	    ps2_ret_addr				//calls keyboard driver
		        bne	    title_key	    ps2_pressed     ps2_zero    //wait until key is pressed
		        cp      key_input       ps2_ascii                   //put an ascii value in key_input



//display menu screen and prompt to press certain key
menu_screen     call    clear_screen    clear_screen_ret_addr       //clear the screen
                cp      pixel           menu_address                //set correct pixel address
                call    display_image   display_image_ret_addr      //display image



//run the keyboard driver and continue if certain key is pressed
menu_key 	    call	ps2_driver	    ps2_ret_addr				//calls keyboard driver
		        bne	    menu_key	    ps2_pressed     ps2_zero    //wait until key is pressed
		        cp      key_input       ps2_ascii                   //put an ascii value in key_input

                be      set_normal      key_input       ascii_1
                be      set_reverse     key_input       ascii_2
                be      set_random      key_input       ascii_3
                be      show_rules      key_input       ascii_4
                be      menu_key        key_input       key_input

set_normal      cp      mode            ascii_1
                be      reset           key_input       key_input

set_reverse     cp      mode            ascii_2
                be      reset           key_input       key_input


set_random      cp      mode            ascii_3
                be      reset           key_input       key_input

show_rules      call    clear_screen    clear_screen_ret_addr       //clear the screen
                cp      pixel           rules_address               //set correct pixel address
                call    display_image   display_image_ret_addr      //display image

//run the keyboard driver and continue if any key is pressed
rules_key 	    call	ps2_driver	    ps2_ret_addr				//calls keyboard driver
		        bne	    rules_key	    ps2_pressed     ps2_zero	//wait until key is pressed
		        cp      key_input       ps2_ascii                   //put an ascii value in key_input
                be      menu_screen     key_input       key_input   //return to menu


//reset all variables
reset           cp      level           prng_one
                cp      correct_i       prng_zero


//generate array of ascii values corresponding to arrow directions using pseudorandom number generator
                cp          time            0x80000005                          //store clock value for seed
call_prng       call        prng            prng_ret_addr                       //call prng
                cpta        prng_result     correct_arr     correct_i           //copy generated value to array
                add         correct_i       correct_i       prng_one            //increment index
                bne         call_prng       correct_i       correct_l           //if array is not filled, keep filling

                cp          correct_i       ps2_zero                            //reset index of correct array


//display watch carefully screen
watch_screen    call    clear_screen    clear_screen_ret_addr       //clear the screen
                cp      pixel           watch_address               //set correct pixel address
                call    display_image   display_image_ret_addr      //display image


//display arrows to user
display_arrows      cp      time                0x80000005                  //store clock value
                    add     time                time            four_k      //add 4000 to clock value (half sec)
wait_half_sec       bne     wait_half_sec       0x80000005      time        //wait for half sec to pass
                    
                    call    clear_screen        clear_screen_ret_addr       //clear the screen
                        
                    call    get_arrow           get_arrow_ret_addr          //display correct directional arrow
                    add     correct_i           correct_i       prng_one    //increment index of correct array
                    bne     display_arrows      correct_i       level       //keep displaying until index reaches level
    
                    call    clear_screen        clear_screen_ret_addr       //clear the screen

                    cp      correct_i           ps2_zero                    //reset index of correct array



//display GO! screen
go3_screen      call    clear_screen    clear_screen_ret_addr       //clear the screen
                cp      pixel           go3_address                 //set correct pixel address
                call    display_image   display_image_ret_addr      //display image

go2_screen      cp      pixel           go2_address                 //set correct pixel address
                call    display_image   display_image_ret_addr      //display image

go1_screen      cp      pixel           go1_address                 //set correct pixel address
                call    display_image   display_image_ret_addr      //display image




//get user input (repeat pattern back)
                    call    clear_screen        clear_screen_ret_addr       //clear the screen

//This is where level must be copied into correct_i
                    be      mode2_set_i         mode           ascii_2      // Goes to set the correct_i if in gamemode 2

get_input	        call	ps2_driver	        ps2_ret_addr				//calls ps2_driver
		            bne	    get_input	        ps2_pressed    ps2_zero		//if pressed != 0 call_driver
		            cp      key_input           ps2_ascii                   //put an ascii value in key_input
                    
                    call    fill_screen         fill_screen_ret_addr

                    //If gameMode == 2, then cp level into correct_i
                    // Decrement correct_i instead of incrementing while its greater than 0
                    cpfa    key_correct         correct_arr    correct_i    //copy from correct array into key_correct
                    bne     game_over           key_input      key_correct  //check to see if input is correct
                    be      mode2_dec           mode           ascii_2
                    add     correct_i           correct_i      prng_one     //increment index of correct array
                    bne     get_input           correct_i      level        //check to see if level is completed
mode2_return        add     level               level          prng_one     //increment level
                    be      game_over           level          correct_l    //check if level is equal to size of array
                    cp      correct_i           ps2_zero                    //reset index of correct array
                    
round_cleared       call    clear_screen        clear_screen_ret_addr       //clear the screen
                    cp      pixel               cleared_address             //set correct pixel address
                    call    display_image       display_image_ret_addr      //display image
                    
                    //If gamemode == 3, go to call_prng 
                    //NOTE: the "Watch Carefully" screen must be changed to show after the array is generated
                    //It is NOT currently implented that way
                    be      call_prng           mode           ascii_3
                    be      display_arrows      prng_one       prng_one     //display directions again for next level

//minimodule for gamemode 2
mode2_set_i         cp      correct_i           level                       // put level in correct_i
                    sub     correct_i           correct_i      prng_one     // Subtract 1 to fix the indexing difference
                    be      get_input           prng_one       prng_one     // Go back to get_input

mode2_dec           sub     correct_i           correct_i      prng_one     // Decrement
                    bne     get_input           correct_i      prng_neg_one // Check to see if level is completed
                    be      mode2_return        prng_one       prng_one     // If level has been completed, then finish the regular function from mode2_return

//game over protocol
game_over       cp      pixel           game_over_address                   //set correct pixel address
                call    display_image   display_image_ret_addr              //display image
//This is where we get input for the game over menu
quit_key 	    call	ps2_driver	    ps2_ret_addr				//calls keyboard driver
		        bne	    quit_key	    ps2_pressed     ps2_zero    //wait until key is pressed
		        cp      key_input       ps2_ascii                   //put an ascii value in key_input

                be      menu_screen     key_input       ascii_1     // Go back to menu so the user can play again
                be      end             key_input       ascii_2     // End game completely
                be      quit_key        key_input       key_input

end             call    clear_screen    clear_screen_ret_addr       //clear the screen
                cp      pixel           thanks_address              //set correct pixel address
                call    display_image   display_image_ret_addr      //display image
                halt   // Game is over


//miscellaneous variables
four_k          4000        //the number 4000

time            -1          //stores clock value

key_input       0           //stores ascii input from user
key_correct     0           //stores correct ascii value from correct array

level           1           //stores current level (should start at 1)
mode            0

ascii_1         '1'
ascii_2         '2'
ascii_3         '3'
ascii_4         '4'


//addresses for images in bin file
title_address       1228800
menu_address        1536000
rules_address       1843200
watch_address       2150400
go3_address         2457600
go2_address         2764800
go1_address         3072000
cleared_address     3379200
game_over_address   3686400
thanks_address      3993600


//array of correct ascii values (will be 'w', 'd', 's', or 'a')
correct_arr     -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1
                -1


correct_i   0       //index of correct array
correct_l   100     //length of correct array


roses_are_red                   'E'
violets_are_blue                '1'
my_mental_state_is_in_shambles  '0'
and_my_motivation_too           '0'




#include ps2_driver.e
#include vga_driver.e
#include sd_driver.e
#include fill_screen.e
#include prng.e
#include clear_screen.e
#include get_arrow.e
#include display_image.e