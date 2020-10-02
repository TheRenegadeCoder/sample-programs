#include<stdio.h>
#include<process.h>
#include<stdlib.h>
#include<conio.h>
struct node{
	int info;
	struct node *next;
}*start, *newptr, *save;
void create();
void insert_begin();
void insert_end();
void insert_middle();
void delete_begin();
void delete_middle();
void delete_end();
void display();
void sort();
void search();
int main()
{
	struct node *start=NULL;
	char ans='y';
	int choice;
//	clrscr();
	while(ans=='y' || ans=='Y')
	{
		printf("Linked List Menu::\n");
		printf("-------\n");
		printf("1. Create Node::\n");
		printf("2. Insert at the beginning\n");
		printf("3. Insert at the end\n");
		printf("4. Insert at a specific position\n");
		printf("5. Delete from beginning\n");
		printf("6. Delete from end\n");
		printf("7. Delete from a specific position\n");
		printf("8. Sorting\n");
		printf("9. Searching\n");
		printf("10. Display nodes::\n");
		printf("11. Exit\n");
		printf("Enter your choice::");
		scanf("%d",&choice);
		switch(choice)
		{
			case 1: create();
				break;
			case 2: insert_begin();
				break;
			case 3: insert_end();
				break;
			case 4: insert_middle();
				break;
			case 5: delete_begin();
				break;
			case 6: delete_end();
				break;
			case 7: delete_middle();
				 break;
			case 8: sort();
				break;
			case 9: search();
				break;
			case 10: display();
				break;
			default: exit(1);
		}
		printf("\nWant to continue.....(y/n)::");
		scanf(" %c",&ans);
	}
//	getch();
}
void create()
{
	struct node  *ptr;
	newptr = (struct node *)malloc(sizeof(struct node));
	if(newptr==NULL)
	{
		printf("Memory is empty");
		exit(0);
	}
	printf("Enter the value for the new info::");
	scanf("%d",&newptr->info);
	newptr->next=NULL;
	if(start==NULL)
	{
		start=newptr;
	}
	else
	{
		ptr=start;
		while(ptr->next!=NULL)
		{
			ptr=ptr->next;
		}
		ptr->next=newptr;
	}
}
void search()
{
	int index=0,keyToSearch,key;
	printf("Enter the Element to be serached:: ");
	scanf("%d",&keyToSearch);
	struct node *curNode;
	curNode=start;
	while (curNode != NULL && curNode->info != keyToSearch)
    {
        index++;
        curNode = curNode->next;
    }
    key=(curNode != NULL) ? index : -1;
    if(index>=0)
    	printf("Element found at:: %d",key);
    else 
    	printf("No element found");
}
void sort()
{
	struct node *p, *q, *r, *s, *temp;
	s=NULL;
	while(s!=start->next)
	{
		r = p = start;
		q = p->next;
		while(p!=s)
		{
			if(p->info > q->info)
			{
				if(p==start)
				{
					temp = q->next;
					q->next = p;
					p->next = temp;
					start = q;
					r = q;
				}
				else
				{
					temp  = q->next;
					q->next = p;
					p->next = temp;
					r->next = q;
					r = q;
				}
			}
			else
			{
				r = p;
				p = p->next;
			}
			q = p->next;
			if(q==s)
				s=p;
		}
	}
}
void insert_begin()
{
	struct node *temp, *ptr;
	temp=(struct node *)malloc(sizeof(struct node));
	if(temp==NULL)
	{
		printf("Memory is empty");
		exit(0);
	}
	printf("Enter the value for the new info::");
	scanf("%d",&temp->info);
	temp->next=NULL;
	if(start==NULL)
	{
		start=temp;
	}
	else
	{
		temp->next=start;
		start=temp;
	}
}
void insert_end()
{
	struct node *temp, *ptr;
	temp=(struct node *)malloc(sizeof(struct node));
	if(temp==NULL)
	{
		printf("Memory is empty");
		exit(0);
	}
	printf("Enter the value for the new info::");
	scanf("%d",&temp->info);
	temp->next=NULL;
	if(start==NULL)
	{
		start=temp;
	}
	else
	{
		ptr=start;
		while(ptr->next!=NULL)
		{
			ptr=ptr->next;
		}
		ptr->next=temp;
	}
}
void insert_middle()
{
	int pos,i;
	struct node *temp, *ptr;
	temp=(struct node *)malloc(sizeof(struct node));
	if(temp==NULL)
	{
		printf("Memory is empty");
		exit(0);
	}
	printf("Enter the position::");
	scanf("%d",&pos);
	printf("Enter the value for the new info::");
	scanf("%d",&temp->info);
	if(pos==0)
	{
		temp->next=start;
		start=temp;
	}
	else
	{
		for(i=0, ptr=start; i<pos-1; i++)
		{
			ptr=ptr->next;
			if(ptr==NULL)
			{
				printf("Position not found");
				return;
			}
		}
		temp->next=ptr->next;
		ptr->next=temp;
	}
}
void delete_begin()
{
	struct node *temp, *ptr;
	if(ptr==NULL)
	{
		printf("List is empty");
		return;
	}
	else
	{
		ptr=start;
		start=start->next;
		printf("The delete element is:: %d",ptr->info);
		free(ptr);
	}
}
void delete_end()
{
	struct node *temp, *ptr;
	if(start==NULL)
	{
		printf("List is empty");
		exit(0);
	}
	else if(start->next==NULL)
	{
		ptr=start;
		start=NULL;
		printf("Deleted item is:: %d",ptr->info);
		free(ptr);
	}
	else
	{
		ptr=start;
		while(ptr->next!=NULL)
		{
			temp=ptr;
			ptr=ptr->next;
		}
		temp->next=NULL;
		printf("Deleted item is:: %d",ptr->info);
		free(ptr);
	}
}
void delete_middle()
{
	struct node *temp, *ptr;
	int i, pos;
	if(start==NULL)
	{
		printf("List is empty");
		exit(0);
	}
	else
	{
		printf("Enter the position of item for deletion::");
		scanf("%d",&pos);
		if(pos==0)
		{
			ptr=start;
			start=start->next;
			printf("Delete items is ::%d",ptr->info);
			free(ptr);
		}
		else
		{
			ptr=start;
			for(i=0; i<pos; i++)
			{
				temp=ptr;
				ptr=ptr->next;
				if(ptr==NULL)
				{
					printf("Position not found");
					return;
				}
				temp->next=ptr->next;
				printf("Deleted item is:: %d", ptr->info);
				free(ptr);
			}
		}
	}
}
void display()
{
	struct node *ptr;
	if(start==NULL)
	{
		printf("List is empty");
		exit(0);
	}
	else{
		ptr=start;
		while(ptr!=NULL)
		{
			printf("%d ",ptr->info);
			ptr=ptr->next;
		}
	}
	getch();
	
}
