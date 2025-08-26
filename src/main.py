from machine import Pin
import time

blinky = Pin(25, Pin.OUT)

while True:
    blinky.toggle()
    time.sleep(1)
