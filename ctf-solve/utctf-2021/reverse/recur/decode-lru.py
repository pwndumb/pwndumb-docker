#! /usr/bin/python3

from functools import lru_cache
from ctypes import *


@lru_cache(maxsize=1000)
def recurrence(n):

    # check if recurrence(n) already in cache
    if n ==0:
        value = 3
    if n == 1:
        value = 5
    elif n > 1:
        value  = recurrence(n-2) * 3 + recurrence(n -1) * 2
    
    return value       

def main():
    flag_encoded = [0x76,0x71,0xc5,0xa9,0xe2,0x22,0xd8,0xb5,0x73,0xf1,0x92,0x28,0xb2,0xbf,0x90,0x5a,0x76,0x77,0xfc,0xa6,0xb3,0x21,0x90,0xda,0x6f,0xb5,0xcf,0x38]
    flag_decoded= []

    # iterate over encoded flag
    for i in range(len(flag_encoded)):

        rax = recurrence(i*i)
        ebx= c_int32(rax).value ^ flag_encoded[i]
        bx = c_int8(ebx).value
        flag_decoded.append(bx)
    
    flag=''.join(chr(i) for i in flag_decoded)
    print(f"[+] flag: {flag}")

if __name__=='__main__':
    main()

