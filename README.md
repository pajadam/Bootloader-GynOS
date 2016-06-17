# What is it?

This is 512 bytes size bootloader that draws cool graphics on screen and loading operating system made by [Gynvael Coldwind](http://gynvael.coldwind.pl/).

![screenshot1](https://pajadam.github.io/img/boot/boot_0.png "Screenshot #1")

# How to use?

Simply run `python build.py && ./run.sh` in project directory. It will generate *.bin file and open it using Bochs with attached config. 

You can run it on Windows too using `run` in project directory. But you need to build it on 64 bit Linux

# What I need to build this one?

You need these software, available from console ( in PATH variables ):
- NASM
- BOCHS

And that's all :D

# What is in project's directories?

- /src     - Code
- /conf    - Bochs config
- /bin     - Binaries
- /tmp     - Bochs working dir
