In this programming section, we'll look into calling functions (and hence get some handles on how to develop ISRs)

Note: An important thing to note is that routine is executed line by line (unless there is a jump statement). So, function definitions should be put somewhere which cannot be encountered in a regular flow. Example, if putting somewhere inside, have an unconditional jmp on top of it to the label below it:

```
jmp function_end

<body of function>

function_end:
```
