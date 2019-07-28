#!/usr/bin/env python3

# stolen from
# https://wiki.archlinux.org/index.php/Keyboard_backlight
# with modifications

import dbus
import sys

def setbacklight(delta_percent):
    bus = dbus.SystemBus()
    proxy = bus.get_object('org.freedesktop.UPower',
                           '/org/freedesktop/UPower/KbdBacklight')
    interface = dbus.Interface(proxy,
                               'org.freedesktop.UPower.KbdBacklight')

    current = interface.GetBrightness()
    maximum = interface.GetMaxBrightness()
    delta = delta_percent / 100 * maximum
    new = max(0, min(current + delta, maximum))
    assert(0 <= new <= maximum)

    interface.SetBrightness(new)
    return (current, maximum)

if __name__ ==  '__main__':
    if len(sys.argv) != 2 or (sys.argv[1] != 'up' and sys.argv[1] != 'down'):
        print('usage: {} <up|down>'.format(sys.argv[0]))
        exit(1)

    current, maximum = setbacklight(10 if sys.argv[1] == 'up' else -10)
    print('current {} ({}), maximum {}'.format(current, current / maximum, maximum))
