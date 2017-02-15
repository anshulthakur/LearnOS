In this programming section, we'll look into calling functions (and hence get some handles on how to develop ISRs)

Note: An important thing to note is that routine is executed line by line (unless there is a jump statement). So, function definitions should be put somewhere which cannot be encountered in a regular flow. Example, if putting somewhere inside, have an unconditional jmp on top of it to the label below it:

```
jmp function_end

<body of function>

function_end:
```
Finally, we see how we can print out the addresses of memories for debugging purposes.
This is a slightly non-trivial problem. The underlying logic to have the ASCII representation is to add the address nibble to Character '0' or 'A' selectively based on some logic.[More info](http://stackoverflow.com/questions/3853730/printing-hexadecimal-digits-with-assembly)
