#!/usr/bin/python3

ip = '192.168.1.60'
port = 6001


import random
import socket
import sys

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

server_address = (ip, port)

random_num = random.randint(0, 100)
msg = f'This is message {random_num}.  It will be repeated.  To Arty.'
b_msg = bytes(msg, 'utf-8')

print(f'Sending "{msg}" to: [UDP]:{ip}:{port}')

sock.sendto(b_msg, (ip, port))
