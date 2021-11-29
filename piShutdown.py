# $Revision: 27 $
from gpiozero import Button
from time import sleep
import time
import os
from signal import pause

aBtn = Button(21)

def buTest(but):
    sleep(3) #adjust to your liking
    act = but.is_active
    if act:
        # long press action here
        #print('Button {} long press'.format(str(but.pin)))
        print('Restarting Server')
        sleep(1)
        os.system("sudo reboot")
        
    else:
        #print('Button {} short press'.format(str(but.pin)))
        print('Stopping MLSC Service')
        
        os.system("echo 0 >/sys/class/gpio/gpio17/value ")
        os.system("sudo systemctl stop mlsc.service")
        sleep(.5)
        os.system("echo 1 >/sys/class/gpio/gpio17/value ")
        
        sleep(1)
        
        print('Starting MLSC Service')
        os.system("echo 0 >/sys/class/gpio/gpio17/value ")
        os.system("sudo systemctl start mlsc.service")
        sleep(.5)
        os.system("echo 1 >/sys/class/gpio/gpio17/value ")


#while True: #infinite loop
aBtn.when_pressed = buTest

#    time.sleep(1)

pause()
