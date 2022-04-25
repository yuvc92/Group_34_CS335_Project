SRC= ./src
BIN= ./bin

all: $(SRC)/compile
	
	
$(SRC)/compile:
	   @mkdir -p $(BIN)
	   yacc -dvt -Wnone $(SRC)/parser.y -o $(BIN)/y.tab.c
	   lex  -o $(BIN)/lex.yy.c $(SRC)/lex.l
	   g++  -w -c $(SRC)/symtable.cpp -o $(BIN)/sym.o -I$(SRC)
	   g++  -w -c $(SRC)/3ac.cpp -o $(BIN)/3ac.o -I$(SRC)
	   g++ $(BIN)/lex.yy.c $(BIN)/y.tab.c $(BIN)/sym.o $(BIN)/type.o $(BIN)/3ac.o -I$(SRC) -lfl -w  -o $(BIN)/compiler

clean: 
		rm -rf $(BIN)
		rm -f *.dot *.png *.txt *.asm