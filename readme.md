# mbpoll

> Copyright © 2015-2019 epsilonRT, All rights reserved.  
> Fork by balonc 2021-2021

## Abstract

mbpoll is a command line utility to communicate with ModBus slave (RTU or TCP).  
It uses [libmodbus](http://libmodbus.org/).  
This is a multiplatform project, the compilation was tested on GNU Linux
x86 and x86_64, Microsoft Windows 7 x86 and GNU Linux ARM 6 (Raspbian).  
Although the syntax of these options is very close modpoll proconX program,
it is a completely independent project.

mbpoll can:

- read discrete inputs
- read and write binary outputs (*coil*)
- read input registers
- read and write output registers (*holding register*)

The reading and writing registers may be in decimal, hexadecimal or 
floating single precision.

## Build from source

For example, for a debian system:

* Install [libmodbus](https://github.com/stephane/libmodbus.git) (Version >= 3.1.4) :

        $ git clone https://github.com/stephane/libmodbus.git
        $ cd libmodbus
        $ ./autogen.sh
        $ ./configure
        $ make
        $ sudo make install

* Compile and install mbpoll:

        $ make
        $ sudo make install

## Examples

The following command is used to read the input registers 1 and 2 of the
slave at address 33 connected through RTU /dev/ttyUSB2 (38400 Bd)

---

        $ mbpoll -a 33 -b 38400 -t 3 -r 1 -c 2 /dev/ttyUSB2
        
        mbpoll 0.1-10 - FieldTalk(tm) Modbus(R) Master Simulator
        Copyright (c) 2015 epsilonRT, All rights reserved.
        This software is governed by the CeCILL license <http://www.cecill.info>

        Protocol configuration: Modbus RTU
        Slave configuration...: address = [33]
                                start reference = 1, count = 2
        Communication.........: /dev/ttyUSB2, 38400-8E1 
                                t/o 1.00 s, poll rate 1000 ms
        Data type.............: 16-bit register, input register table

        -- Polling slave 33... Ctrl-C to stop)
        [1]: 	9997
        [2]: 	10034
        -- Polling slave 33... Ctrl-C to stop)
        [1]: 	10007
        [2]: 	10034
        -- Polling slave 33... Ctrl-C to stop)
        [1]: 	10007
        [2]: 	10034
        -- Polling slave 33... Ctrl-C to stop)
        [1]: 	10007
        [2]: 	10034
        ^C--- /dev/ttyUSB2 poll statistics ---
        4 frames transmitted, 4 received, 0 errors, 0.0% frame loss

        everything was closed.
        Have a nice day !

## Help

A complete help is available with the -h option:

    usage : mbpoll [ options ] device|host [ writevalues... ] [ options ]

    ModBus Master Simulator. It allows to read and write in ModBus slave registers
                             connected by serial (RTU only) or TCP.

    Arguments :
      device        Serial port when using ModBus RTU protocol
                      COM1, COM2 ...              on Windows
                      /dev/ttyS0, /dev/ttyS1 ...  on Linux
                      /dev/ser1, /dev/ser2 ...    on QNX
      host          Host name or dotted IP address when using ModBus/TCP protocol
      writevalues   List of values to be written.
                    If none specified (default) mbpoll reads data.
                    If negative numbers are provided, it will precede the list of
                    data to be written by two dashes ('--'). for example :
                    mbpoll -t4:int /dev/ttyUSB0 -- 123 -1568 8974 -12
    General options : 
      -m #          mode (rtu or tcp, TCP is default)
      -a #          Slave address (1-255 for rtu, 0-255 for tcp, 1 is default)
                    for reading, it is possible to give an address list
                    separated by commas or colons, for example :
                    -a 32,33,34,36:40 read [32,33,34,36,37,38,39,40]
      -r #          Start reference (1 is default)
                    for reading, it is possible to give an address list
                    separated by commas or colons
      -c #          Number of values to read (1-125, 1 is default)
      -u            Read the description of the type, the current status, and other
                    information specific to a remote device (RTU only)
      -t 0          Discrete output (coil) data type (binary 0 or 1)
      -t 1          Discrete input data type (binary 0 or 1)
      -t 3          16-bit input register data type
      -t 3:int16    16-bit input register data type with signed int display
      -t 3:hex      16-bit input register data type with hex display
      -t 3:string   16-bit input register data type with string (char) display
      -t 3:int      32-bit integer data type in input register table
      -t 3:float    32-bit float data type in input register table
      -t 4          16-bit output (holding) register data type (default)
      -t 4:int16    16-bit output (holding) register data type with signed int display
      -t 4:hex      16-bit output (holding) register data type with hex display
      -t 4:string   16-bit output (holding) register data type with string (char) display
      -t 4:int      32-bit integer data type in output (holding) register table
      -t 4:float    32-bit float data type in output (holding) register table
      -0            First reference is 0 (PDU addressing) instead 1
      -B            Big endian word order for 32-bit integer and float
      -1            Poll only once only, otherwise every poll rate interval
      -l #          Poll rate in ms, ( > 100, 1000 is default)
      -o #          Time-out in seconds (0.01 - 10.00, 1.00 s is default)
      -q            Quiet mode.  Minimum output only
    Options for ModBus / TCP : 
      -p #          TCP port number (502 is default)
    Options for ModBus RTU : 
      -b #          Baudrate (1200-921600, 19200 is default)
      -d #          Databits (7 or 8, 8 for RTU)
      -s #          Stopbits (1 or 2, 1 is default)
      -P #          Parity (none, even, odd, even is default)
      -R [#]        RS-485 mode (/RTS on (0) after sending)
                     Optional parameter for the GPIO RTS pin number
      -F [#]        RS-485 mode (/RTS on (0) when sending)
                     Optional parameter for the GPIO RTS pin number

      -h            Print this help summary page
      -V            Print version and exit
      -v            Verbose mode.  Causes mbpoll to print debugging messages about
                    its progress.  This is helpful in debugging connection...
