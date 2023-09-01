from sys import argv
from time import sleep
from datetime import datetime
import Adafruit_DHT

if __name__ == "__main__":
    if len(argv) < 2:
        print("Missing output file argument")
        exit(1)
    Adafruit_DHT.read_retry(11, 4)
    sleep(5)
    humidity, temperature = Adafruit_DHT.read_retry(11, 4)
    now = int( datetime.now().timestamp() )
        if humidity is not None and temperature is not None:
            with open(argv[1], "a") as outfile:
                outfile.write( "{},{},{}\n".format(now, humidity, temperature) )
