ps2_driver		cp	0x80000020		ps2_one					//sets ps2_command to one
ps2_bne_1		bne	ps2_bne_1		0x80000021	ps2_one		//if ps2_response is one then move on
		    	cp	ps2_pressed		0x80000022				//copy ps2_pressed into pressed
		    	cp	ps2_ascii		0x80000023				//copy ps2_ascii into ascii
		    	cp	0x80000020		ps2_zero				//sets ps2_command to zero
ps2_bne_2		bne	ps2_bne_2		0x80000021	ps2_zero	//if ps2_response is zero then return
		    	ret	ps2_ret_addr    						//return

ps2_one		    1	//one
ps2_zero		0	//zero

ps2_pressed		0	//pressed signal
ps2_ascii		0	//ascii value
ps2_ret_addr	0	//return address

