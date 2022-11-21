BIN = student 
SRC = student.asm
OBJ = student.o

INC = lib.asm 
INC_OBJ = lib.o 

ASM = nasm
ASM_FLAGS = -f elf -g
LD = ld
LD_FLAGS = -m elf_i386 -o $(BIN)

all: $(BIN)

$(BIN) : $(OBJ) $(INC_OBJ)
	$(LD) $(LD_FLAGS) $(OBJ) $(INC_OBJ)

$(OBJ) : $(SRC)
	$(ASM) $(ASM_FLAGS) $(SRC)

$(INC_OBJ) : $(INC)
	$(ASM) $(ASM_FLAGS) $(INC) 

clean: 
	rm *.o $(BIN)

run: $(BIN)
	./$(BIN)

debug: $(BIN)
	gdb $(BIN)