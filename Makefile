TOOLCHAIN = ./toolchain/bin
FILES = ./build/kernel.asm.o ./build/kernel.o ./build/idt/idt.asm.o ./build/idt/idt.o ./build/memory/memory.o ./build/memory/heap/heap.o ./build/memory/heap/kheap.o ./build/io/io.o
INCLUDES = -I./src
FLAGS = -g -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-cpp -Wno-unused-parameter -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc

DIRS = ./bin ./build ./build/idt ./build/memory ./build/memory/heap ./build/io

.PHONY: all dirs run run-debug run-term clean

all: ./bin/os.bin

dirs: $(DIRS)

$(DIRS):
	mkdir -p $@

./bin/os.bin: dirs ./bin/boot.bin ./bin/kernel.bin
	rm -f ./bin/os.bin
	dd if=./bin/boot.bin >> ./bin/os.bin
	dd if=./bin/kernel.bin >> ./bin/os.bin
	dd if=/dev/zero bs=512 count=100 >> ./bin/os.bin

run-debug: 
	qemu-system-i386 -s -S -drive format=raw,file=./bin/os.bin

run:
	qemu-system-i386 -drive format=raw,file=./bin/os.bin

run-term:
	qemu-system-i386 -drive format=raw,file=./bin/os.bin -nographic -serial stdio

./bin/kernel.bin: dirs $(FILES)

	$(TOOLCHAIN)/i686-elf-ld -g -relocatable $(FILES) -o ./build/kernelfull.o
	$(TOOLCHAIN)/i686-elf-gcc $(FLAGS) -T ./src/linker.ld -o ./bin/kernel.bin -ffreestanding -O0 -nostdlib ./build/kernelfull.o

./bin/boot.bin: dirs ./src/boot/boot.asm
	nasm -f bin ./src/boot/boot.asm -o ./bin/boot.bin

./build/kernel.asm.o: dirs ./src/kernel.asm
	nasm -f elf -g ./src/kernel.asm -o ./build/kernel.asm.o

./build/kernel.o: dirs ./src/kernel.c
	$(TOOLCHAIN)/i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c ./src/kernel.c -o ./build/kernel.o

./build/idt/idt.asm.o: dirs ./src/idt/idt.asm
	nasm -f elf -g ./src/idt/idt.asm -o ./build/idt/idt.asm.o

./build/idt/idt.o: dirs ./src/idt/idt.c
	$(TOOLCHAIN)/i686-elf-gcc $(INCLUDES) -I./src/idt $(FLAGS) -std=gnu99 -c ./src/idt/idt.c -o ./build/idt/idt.o

./build/memory/memory.o: dirs ./src/memory/memory.c
	$(TOOLCHAIN)/i686-elf-gcc $(INCLUDES) -I./src/memory $(FLAGS) -std=gnu99 -c ./src/memory/memory.c -o ./build/memory/memory.o

./build/memory/heap/heap.o: dirs ./src/memory/heap/heap.c
	$(TOOLCHAIN)/i686-elf-gcc $(INCLUDES) -I./src/memory $(FLAGS) -std=gnu99 -c ./src/memory/heap/heap.c -o ./build/memory/heap/heap.o

./build/memory/heap/kheap.o: dirs ./src/memory/heap/kheap.c
	$(TOOLCHAIN)/i686-elf-gcc $(INCLUDES) -I./src/memory $(FLAGS) -std=gnu99 -c ./src/memory/heap/kheap.c -o ./build/memory/heap/kheap.o

./build/io/io.o: dirs ./src/io/io.asm
	nasm -f elf -g ./src/io/io.asm -o ./build/io/io.o

clean:
	rm -rf ./bin/boot.bin
	rm -rf ./bin/kernel.bin
	rm -rf ./bin/os.bin
	rm -rf ${FILES}
	rm -rf ./build/kernelfull.o
	rm -rf ./build/memory/memory.o
	rm -rf ./build/memory/heap/heap.o
	rm -rf ./build/memory/heap/kheap.o
	rm -rf ./build/io/io.o