# pong-x86

#### A simple 16 bits Pong game in x86 assembly

The purpose of this project is to write a simple pong game to run in 8086 machines.

# Requirements

All you need to build the source code is the FASM assembler installed and available on your system path.
To run and test the binaries, we'll use DosBox.
You can find both on the following links:

 - [FASM - Flat Assember](https://flatassembler.net/)
 - [DosBox](https://www.dosbox.com/)
 

# Building
The FASM syntax to build/assemble programs is fairly simple:

>   `fasm <source_file> <output_file>`

So, to mannualy build the hello world program inside the bin folder, for instace, you could do it with `fasm hello.asm bin\hello.com`.

You can find two simple batch scripts to automate the assmbly and execution of any .asm file of the the project:

 script   | usage | description |
--------- |-------|-------------|
build.bat |build <filename> | builds `filename.asm` program inside ./bin folder
run.bat   |run <filename>   | runs `filename.com` in a new instance of dosbox

Is important to note that this only will work if both `fasm` and `dosbox` is somewhere in your `path` environment variable.

# Running
We cannot run any program of this project directly on a modern operating system. They're all 16 bits programs so the easiest way is to use a virtual machine or an emulator. 

You can run DosBox and manually mount the drivers pointing to the bin directory or, if dosbox is in your environtment path variable, you can simply run: `dosbox -noautoexec -c "mount c ./bin" -c "c:"`.