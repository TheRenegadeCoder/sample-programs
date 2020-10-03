import socket

# Create a socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to a particular address and port
address = socket.gethostname()
port = 12345
s.bind((address, port))

# A close flag
flag = 1

# Continuously listen for connections
while True:

    # Decide whether to close the server
    flag = int(input("Should server stay on? 1\\0 for Yes\\No :"))
    if flag == 0:
        break

    # Listen for requests
    print("Listening for connections")
    s.listen(5)

    # Accept request from a client
    c, addr = s.accept()

    # Continuously send and receive messages
    print("Connected to the client {}".format(addr))
    while True:

        # Message to be sent
        msgtoclient = str(input("Server(you): "))

        # Encode the message into bytes using utf-8 encoding
        c.send(bytes(msgtoclient, 'utf-8'))

        # If server sends E to close connection
        if msgtoclient[0] == 'E':
            print("Closing connection to {} from server side".format(addr))
            c.close()
            break

        # Receive message from client
        msg = c.recv(1024)
        msg = msg.decode('utf-8')

        # Check for connection close request
        if msg[0] == 'E':
            print("Closing connection to {} due to client request".format(addr))
            c.close()
            break

        # Print the message
        print("Client: ", msg)
