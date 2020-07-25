//this pseudorandom number generator is based on the 
//Linear Congruential generator as follows:
//  X_n = (a * X_0 + c) % m where:
//  X_n is a pseudorandom integer between [0, m),
//  a is a commonly used multiplier,
//  X_0 is a seed or start value,
//  c is a commonly used increment,
//  m is a modulus

//for our purposes:
//  X_n will be our pseudorandom result (either 0, 1, 2, or 3) converted to 
//  ASCII values (w, d, s, a, respectively) to represent the cardinal directions (N, E, S, W) on a keyboard,
//  a will be 8121,
//  X_0 will be the value of the seed given by the time at which the user starts the game,
//  c will be 28411,
//  m will be 4 to create an output of 0, 1, 2, or 3

//the modulus operator will be defined according to the following example:
//  simulate 25 % 4 :
//  25 / 4 = 6
//  6 * 4 = 24
//  25 - 24 = 1



prng        div     time            time            denom               //divide seed for more random result
            mult    prng_result     a               time                //store a * X_0 in prng_result
            add     prng_result     prng_result     c                   //store (a * X_0) + c in prng_result
            cp      time            prng_result                         //return a different seed
            div     mod_temp        prng_result     m                   //store ((a * X_0) + c) / m in mod_temp
            mult    mod_temp        mod_temp        m                   //store (((a * X_0) + c) / m) * m in mod_temp
            sub     prng_result     prng_result     mod_temp            //store prng_result - ((((a * X_0) + c) / m) * m) in prng_result
            
            be      return_w        prng_result     prng_zero           //if pseudorandom number is 0, return w
            be      return_d        prng_result     prng_one            //if pseudorandom number is 1, return d
            be      return_d        prng_result     prng_neg_one        //if pseudorandom number is -1, return d
            be      return_s        prng_result     prng_two            //if pseudorandom number is 2, return s
            be      return_s        prng_result     prng_neg_two        //if pseudorandom number is -2, return s
            be      return_a        prng_result     prng_three          //if pseudorandom number is 3, return a
            be      return_a        prng_result     prng_neg_three      //if pseudorandom number is -3, return a
            halt                                                        //if pseudorandom number is anything else, program is broken (for debugging)


return_w    cp      prng_result     w_ascii             //set prng_result to w_ascii
            ret     prng_ret_addr                       //return
return_d    cp      prng_result     d_ascii             //set prng_result to d_ascii
            ret     prng_ret_addr                       //return
return_s    cp      prng_result     s_ascii             //set prng_result to s_ascii
            ret     prng_ret_addr                       //return
return_a    cp      prng_result     a_ascii             //set prng_result to a_ascii
            ret     prng_ret_addr                       //return
            


a                   8121        //value of "a" in equation
c                   28411       //value of "c" in equation
m                   4           //value of "m" in equation
mod_temp            0           //temporary storage to calculate modulus
prng_result         -11111      //final result

//hardcoded integers [-3,3]
prng_neg_three      -3
prng_neg_two        -2
prng_neg_one        -1
prng_zero            0
prng_one             1
prng_two             2
prng_three           3

denom                11          //prime number to divide seed for more randomization

//ascii values for w,d,s,a
w_ascii              119
d_ascii              100
s_ascii              115
a_ascii              97

prng_ret_addr        0           //return address