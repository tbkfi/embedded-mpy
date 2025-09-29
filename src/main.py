from machine import Pin
import time

blinky = Pin("LED", Pin.OUT)

while True:
    blinky.toggle()
    time.sleep(1)
