import board
from adafruit_bme280 import basic as adafruit_bme280
from datetime import datetime
from influxdb import InfluxDBClient

i2c = board.I2C()  # uses board.SCL and board.SDA
bme280 = adafruit_bme280.Adafruit_BME280_I2C(i2c, address=0x76)
client = InfluxDBClient('localhost', 8086, 'admin', 'admin', 'sensors')

if __name__ == "__main__":
    time = datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')
    temperature = bme280.temperature
    pressure    = bme280.pressure
    humidity    = bme280.humidity
    res = client.write_points([
      {
        "measurement": "bme280",
        "time": time,
        "fields": {
          "temperature": temperature,
          "pressure"   : pressure,
          "humidity"   : humidity
        }
      }])
    print("[{}] T: {:.1f} C  /  P: {:.0f} hPa  /  H: {:.1f} %  --> {}".format(time, temperature, pressure, humidity, res))

