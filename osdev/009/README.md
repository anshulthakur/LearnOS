In this leg, we start with disk access.

1. First, we look into the concept of segment and segment register that helps address memory
  greater than 0xffff (16 bits) 64kB and upto 0xfffff (1MB).

2. Then, we look to read from a disk. The tutorial has error that it tries to read 5 sectors when we have only 3, and 1 we've skipped. [Why?](http://stackoverflow.com/questions/31462701/int-13h-isnt-working-on-qemu-the-program-crashes)

