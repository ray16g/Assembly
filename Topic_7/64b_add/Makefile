

test_64badd: test_64badd.o lib.o 
	ld -m elf_i386 test_64badd.o -o test_64badd 

test_64badd.o: test_64badd.asm 
	nasm -f elf -g test_64badd.asm

clean:
	rm *.o test_64badd

run: test_64badd
	./test_64badd

debug: test_64badd
	gdb test_64badd