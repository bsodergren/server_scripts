#!/usr/bin/env python

import gpiozero
import time
import os


class cmdbutton(object):

    def __init__(self, pin, press, hold):
        self.__button = gpiozero.Button(pin,
                                        pull_up=True,
                                        bounce_time=0.050,
                                        hold_time=2.0)
        self.__press = press
        self.__hold = hold
        self.__press_time = None

        self.__button.when_held = self.__on_hold
        self.__button.when_pressed = self.__on_press
        self.__button.when_released = self.__on_release

    def __on_press(self):
        # button pressed
        self.__press_time = time.time() - self.__button.active_time

    def __on_release(self):
        # short press
        if time.time() - self.__press_time < 0.5:
            print('Restarting scoreboard')
            os.system(self.__press)

    def __on_hold(self):
        # button held
        print('Restarting Server')
        time.sleep(5)
        os.system(self.__hold)

    def close(self):
        self.__button.close()


if __name__ == '__main__':
    btn = cmdbutton(pin=24,
                    press='systemctl restart nfl-led-scoreboard',
                    hold='reboot')
    # btn = cmdbutton(pin=24,
    #                 press='echo "systemctl restart nfl-led-scoreboard"',
    #                 hold='echo "reboot"')
    try:
        while True:
            time.sleep(1)
    finally:
        btn.close()
