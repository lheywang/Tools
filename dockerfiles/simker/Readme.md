# Simker

This dockerfile build an electrical simulation docker, targetted to analog and digital simulation. 
The container is based on Ubuntu 24.04 image.

It bundle different tools :
- GHDL (GCC backend)
- Verilator
- GTKWave
- Gaw3
- ngspice
- xschem

To install it, run 

> make setup

It'll build the docker and install it on your system. 
The image is approx. 8 GB in size.
Then, you can run 

> make run

To open the docker, or, if you add this line into your bashrc :

> alias simker="sudo docker run -it --rm -v \"$PWD\":/project -w /project --net=host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix simker"

To make it available from anywhere.

In any cases, the command will set the docker into your actual folder, and thus can be used anywhere, as a standalone tool.

