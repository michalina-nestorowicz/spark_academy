import requests
import socket
import time
import json

TOKEN = "<YOUR_TOKEN>"
# Host and port to listen on
HOST = "127.0.0.1"
PORT = 65432

# Frequency between new data
PERIOD_IN_S = 5

def get_spotify_data(access_token: str):
    header = {"Authorization": f"Bearer {access_token}"}
    response = requests.get("https://api.spotify.com/v1/me/player/currently-playing", headers=header)
    return response.json()



def send_to_socket(access_token: str, host: str, port: int) -> None:
    # Create a socket object
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((host, port))
        s.listen()
        print("Server listening on", host, port)
        conn, addr = s.accept()
        with conn:
            print("Connected by", addr)
            while True:
                # data = mock_data()
                data_json = get_spotify_data(access_token)
                data = json.dumps(data_json) + '\n'
                print(data)
                conn.sendall(data.encode())
                time.sleep(4)


if __name__ == "__main__":
    send_to_socket(TOKEN, HOST, PORT)

