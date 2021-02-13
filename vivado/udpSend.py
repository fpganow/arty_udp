#!/usr/bin/python3

ip = '192.168.1.60'
#ip = '192.168.1.140'
port = 6001

print(f'Sending a UDP Packet to: {ip}:{port}')

import socket
import sys

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

server_address = (ip, port)

random_num = random.randint(0, 100)
msg = f'This is message {random_num}.  It will be repeated.  To Arty.'
b_msg = bytes(msg, 'utf-8')
sock.senddo(b_msg, (ip, port))


#try:
#    sock.connect(server_address)
#    amount_received = 0
#    amount_expected = len(message)
#    while amount_received < amount_expected:
#        data = sock.recv(16)
#        amount_received += len(data)
#        print(f'Received {data}')
#finally:
#    sock.close()
