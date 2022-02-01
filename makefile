SRC= ./src
BIN= ./bin
all: $(SRC)/compile
$(SRC)/compile:
	   @mkdir -p $(BIN)
	   cp $(SRC)/def.h  $(BIN)/def.h
	   lex -o $(BIN)/lex.yy.c  $(SRC)/lex.l
	   gcc -o $(BIN)/lexer $(BIN)/lex.yy.c -lfl -w
clean: 
		rm -rf $(BIN)