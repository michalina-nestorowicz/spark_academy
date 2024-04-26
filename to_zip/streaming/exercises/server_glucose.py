import socket
import time
from datetime import datetime
import random

host, port = ('127.0.0.1', 65432)

print("GLUCOSPARK: Starting glucose level measurements")
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((host, port))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print('Connected by', addr)
        while True:
            glucose_reading = random.randint(100, 125)
            conn.sendall((str(datetime.now()) + f",{glucose_reading},mg\\dL,GS001").encode())
            conn.sendall((str(datetime.now()) + ",-3,mg\\dL,GS001").encode()) 
            time.sleep(4)
