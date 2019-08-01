#!/usr/bin/env python3

# stolen from
# https://wiki.archlinux.org/index.php/Keyboard_backlight
# with modifications

import dbus
import sys
import re

def setbacklight(value, symbol):
    bus = dbus.SystemBus()
    proxy = bus.get_object('org.freedesktop.UPower',
                           '/org/freedesktop/UPower/KbdBacklight')
    interface = dbus.Interface(proxy,
                               'org.freedesktop.UPower.KbdBacklight')

    current = interface.GetBrightness()
    maximum = interface.GetMaxBrightness()

    if not symbol:
        new = value / 100 * maximum
    else:
        multiplier = 1 if symbol == '+' else -1
        delta = value / 100 * maximum * multiplier
        new = max(0, min(current + delta, maximum))

    assert(0 <= new <= maximum)

    interface.SetBrightness(new)
    return (current, maximum)

if __name__ ==  '__main__':
    if len(sys.argv) != 2:
        print('usage: {} PERCENT[+|-]'.format(sys.argv[0]))
        exit(1)

    match = re.match(r'^(\d+)(\+|-)?$', sys.argv[1])
    if not match:
        print('value should be in format PERCENT[+|-]')
        exit(1)

    value, symbol = match.groups()
    value = int(value)
    if not 0 <= value <= 100:
        print('value should be between 0 and 100 inclusively')
        exit(1)

    current, maximum = setbacklight(value, symbol)
    print('current {} ({}), maximum {}'.format(current, current / maximum, maximum))
