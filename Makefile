#################################################################
#                                                               #
#                                                               #
#	Author:Chandrasekhar Atina                              #
#	email:chandu.atina@gmail.com                            #
#	Description:Lexical Analyzer                            #	
#                                                               #
#                                                               #
#################################################################


CC       = gcc -g
LEX      = lex 


install : lexanalysis.lex
	$(LEX) lexanalysis.lex
	$(CC) lex.yy.c -o cpp -ll

clean :
	rm -f *.c *.out *.am cpp
