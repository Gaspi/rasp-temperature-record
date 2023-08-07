from sys import argv
from datetime import datetime
import Adafruit_DHT

if __name__ == "__main__":
    if len(argv) == 0:
        print("Missing argument")
        exit 1
    with open(argv[0], "a") as outfile:
        humidity, temperature = Adafruit_DHT.read_retry(11, 4)
        now = datetime.now().strftime("%Y-%m-%d,%H:%M:%S")
        outfile.write("{},{},{},{}\n".format(now, temperature, humidity) )
