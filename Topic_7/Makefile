ASM = nasm
ASM_FLAGS = -g -f elf
LD = ld
LD_FLAGS = -m elf_i386 
SRC = test_itoa.asm
BIN = test_itoa 
OBJ = test_itoa.o 
INC = lib.asm 
INC_OBJ = lib.o 

all: $(BIN)

$(BIN) : $(OBJ) $(INC_OBJ)
	$(LD) $(LDFLAGS) $(OBJ) $(INC_OBJ)

$(OBJ) : $(SRC)
	$(ASM) $(ASM_FLAGS) $(SRC)

$(INC_OBJ) $(INC)
	$(ASM) $(ASM_FLAGS) $(INC) 

clean: 
	rm *.o $(BIN) $(INC_OBJ) $(OBJ)

run: $(BIN)
	./$(BIN)