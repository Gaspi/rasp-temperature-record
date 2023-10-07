from sys import argv
from time import sleep
from datetime import datetime
import Adafruit_DHT

if __name__ == "__main__":
    if len(argv) < 2:
        print("Missing output file argument")
        exit(1)
    data = []
    start = datetime.now()
    data.append( start.strftime("%Y-%m-%d") )
    data.append( start.strftime("%H:%M:%S") )
    for i in range(6):
        humidity, temperature = Adafruit_DHT.read_retry(11, 4)
        data.append(str(humidity))
        data.append(str(temperature))
        sleep(5)
    data.append( datetime.now().strftime("%H:%M:%S") )
    with open(argv[1], "a") as outfile:
        outfile.write(",".join(data)+"\n")
