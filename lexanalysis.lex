%{
#include<stdio.h>
#include<math.h>
#include<string.h>
int initial_node=0;
int first_time=0;
int key=1;
int flag=0;
int space_count=2;
int display_check=0;
int value=1;
int line_count=0;
char *new_str,*new_str2;

typedef enum { INT_CONST, STR_CONST, ID } VAL_TYPE;


typedef struct dr
{
	struct dr *next;
	char *key;
	VAL_TYPE tag;
	int traversed;
	union
	{
		long int intconstval;
		char *strconstval;
		char *idval;
	}u;
}DICT_REC,*DR;

typedef struct hr
{
	struct dr *next;
	struct hr *down;
}HEADER_PTR,*HR;

HEADER_PTR *head_ptr;
DICT_REC *node_check;
HEADER_PTR *header_check;
HEADER_PTR *new_header;
DICT_REC *new_node;


DR first,last;
//first=NULL;
//last=NULL;


//DICT_REC *rec_ptr;
//rec_ptr = (DR) malloc(sizeof(DICT_REC));
//first=rec_ptr;
//last=rec_ptr;



%}

strngconstval "\""[#defineA-Za-z0-9 \\]*"\""
directive "#define"|" #define"
key1 [A-Za-z_0-9]+
digit [0-9+-]+
%%

{directive} {
		if(first_time==0)
		{
			
			head_ptr=(HR) malloc(sizeof(HEADER_PTR));
			if(head_ptr==NULL)
				printf("memory not allocated");
			head_ptr->next=NULL;
			head_ptr->down=NULL;
			first_time=1;
			first=NULL;
			last=NULL;
		}

	    
	    new_node=(DR) malloc(sizeof(DICT_REC));
	    key=0;
	    value=0;
	    space_count=0;
	    new_node->next=NULL;
	    new_node->traversed=0;
	    if(first==NULL)
	    {
		head_ptr->next=new_node;
		first=new_node;
	    }
		if(head_ptr==NULL)
				printf("memory not allocated");
		
	    }	

{key1}|{strngconstval}|{digit}	    {
	
				int l1,l2;
		if(initial_node==0&&key==0)
		{
			new_str=(char*)malloc(strlen(yytext)+1);
			strcpy(new_str,yytext);
			head_ptr->next->key=new_str;
			key=1;
			initial_node=1;		
		}
	    else if(value==0)
	    {

				new_str=(char*)malloc(strlen(yytext)+1);
				strcpy(new_str,yytext);
				if(head_ptr->next==NULL)
					printf("memory not allocated");
		
			if(key==0)
			{
			for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
			{
				display_check=0;
for(node_check=header_check->next;node_check!=NULL && node_check->traversed==0;node_check=node_check->next)
				{
					node_check->traversed=10;		
					if(strcmp(new_str,node_check->key)== 0)
					{
						value=0;
						last=node_check;
				printf("Warning: Redefinition of directive %s at line no:%d",new_str,line_count);
						DICT_REC *temp;
						temp=node_check->next;
						node_check->u.idval=node_check->key;
						node_check->next=NULL;	
						new_header=(HEADER_PTR*) malloc(sizeof(HEADER_PTR));
						while(header_check->down!=NULL)
						{
							header_check=header_check->down;
						}
						header_check->down=new_header;
						new_header->next=temp;
					}
				
			}
			
			}
			for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
			{
	for(node_check=header_check->next;node_check!=NULL && node_check->traversed==10;node_check=node_check->next)
				{
					node_check->traversed=0;				
				}
			}
			
		}

		 if(key==0)
	    	{
				if(last==NULL)
				{
				new_node->key=new_str;
				key=1;
				}
				else
				{
					new_node->key=new_str;
					key=1;
					if(strcmp(last->u.idval,new_str)==0)
					{
						last->next=new_node;
						DICT_REC *pre_caught;
				for(node_check=head_ptr->next;node_check->next!=NULL;node_check=node_check->next)
					{
						pre_caught=node_check;
					}
						if(last==pre_caught)
						{
						}
						else if(strcmp(node_check->u.idval,new_str)==0)
						{
							node_check->next=new_node;
						}  
					}	
					else
					{
						DICT_REC *caught;
						int caught_flag=0;
						
				for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
				{
    for(node_check=header_check->next;node_check!=NULL && node_check->traversed==0;node_check=node_check->next)
				    {
					node_check->traversed=10;
					caught=node_check;	
				    }
				    if(strcmp(caught->u.idval,new_str)==0)
				    {
					last=caught;
					last->next=new_node;
					caught_flag=1;
				    }
				}
			for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
			{
	for(node_check=header_check->next;node_check!=NULL && node_check->traversed==10;node_check=node_check->next)
				{
					node_check->traversed=0;				
				}
			}

						
						if(caught_flag==0)
						{ 
							new_header=(HEADER_PTR*) malloc(sizeof(HEADER_PTR));
							for(header_check=head_ptr;header_check->down!=NULL;)
							{
								header_check=header_check->down;
							}
							header_check->down=new_header;
							new_header->next=new_node;
						}
					}				
				}
			
	    	}
		 else if(key==1)
	    	{
			if(last==NULL)
			{
				new_node->tag=ID;
				new_node->u.idval=new_str;
				value=1;
				last=first;
			}
			else 
			{
				new_node->tag=ID;
				new_node->u.idval=new_str;	
				value=1;
				last=new_node;
				last->next=NULL;
				
				for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
				{
          for(node_check=header_check->next;node_check!=NULL && node_check->traversed==0;node_check=node_check->next)
				    {
					node_check->traversed=10;
					if(strcmp(new_str,node_check->key)==0)
					{
						last->next=node_check;
						flag=1;
						break;
					}
  				    }
				    if(flag==1)
					break;
				}  		
			for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
			{
	for(node_check=header_check->next;node_check!=NULL && node_check->traversed==10;node_check=node_check->next)
				{
					node_check->traversed=0;				
				}
			}
				
				flag=0;	
			}		
	    	}

	   


	    }
	    else
	    {
		DICT_REC *save_node;
		display_check=0;		
		new_str=(char*)malloc(strlen(yytext)+1);
		strcpy(new_str,yytext);
		for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
		{
	for(node_check=header_check->next;node_check!=NULL && node_check->traversed==0;node_check=node_check->next)
			{
				
				node_check->traversed=20;				
				if(strcmp(node_check->key,new_str)==0)
				{
						
					save_node=node_check;					
					node_check->traversed=10;
					while(node_check->next!=NULL && node_check->next->traversed!=10)
					{
						
						node_check=node_check->next;
						node_check->traversed=10;
					}		
					while(header_check->down!=NULL)
						header_check=header_check->down;
					printf("%s",node_check->u.idval);
					display_check=1;
				}	
			}
		}
		if(display_check==0)
		{
			printf("%s",yytext);
		}
				
		for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
		{
for(node_check=header_check->next;node_check!=NULL && (node_check->traversed==10 || node_check->traversed==20);node_check=node_check->next)
			{
				node_check->traversed=0;	
			}
		}

	    }
	    }


[$]	{
		
		for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
		{
			printf("\n");
			display_check=0;
  	  for(node_check=header_check->next;node_check!=NULL && node_check->traversed==0;node_check=node_check->next)
		    {
		    	printf("%s,%s,%d---",node_check->key,node_check->u.idval,node_check->traversed);
			node_check->traversed=10;
		    }
		}
		
		for (header_check=head_ptr;header_check!=NULL;header_check=header_check->down)
		{
	for(node_check=header_check->next;node_check!=NULL && node_check->traversed==10;node_check=node_check->next)
			{
				node_check->traversed=0;	
			}
		}
	}



[ ]	    {
       	    if(space_count>=2)
	    {
		printf(" ");
	    }	
	    else
	    {
		space_count++;
	    }
	    }

[\n]	    {
		printf("\n");		
		line_count++;
	    }


.		printf("%s",yytext);		

%%


main( int argc, char **argv )
{
    ++argv, --argc;     /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;

    yylex();
}
