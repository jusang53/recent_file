from time import sleep
from opcua import Client
import sys


def get_val():
    client = Client("opc.tcp://127.0.0.1:12345")
    client.connect()
    temp = client.get_node('ns=2; s="TS1_Temperature"')

    T = temp.get_value()
    sys.stdout.write(str(T))
    client.disconnect()
    
    return(T)
    


# while True:
#     T = temp.get_value()
#     print(T)
#     sleep(2)
