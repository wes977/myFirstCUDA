#include <iostream>
#include <ctime>
#include <cstdlib>

#include <stdio.h>

#define SIZE	1024
void crackPassword(int *a, int *b, int *c, int *d);
int main()
{
	int *a, *b, *c, *d;
	int *d_a, *d_b, *d_c, *d_d;

	char password[] = "West";

	double secondsPassed;

	double durationCPU;
	durationCPU = 0;

	double durationGPU;
	durationGPU = 0;

	clock_t startTime = clock(); //Start timer
	clock_t endTime = clock(); //Start timer
	a = (int *)malloc(SIZE * sizeof(int));
	b = (int *)malloc(SIZE * sizeof(int));
	c = (int *)malloc(SIZE * sizeof(int));
	d = (int *)malloc(SIZE * sizeof(int));

	//Numbers and all that input them and all that fun stuff 
	for (int i = 0; i <= 9; ++i)
	{
		a[i] = i + 48;
		b[i] = i + 48;
		c[i] = i + 48;
		d[i] = i + 48;
	}

	//upper case and all that  
	for (int i = 10; i <= 35; ++i)
	{
		a[i] = i + 55;
		b[i] = i + 55;
		c[i] = i + 55;
		d[i] = i + 55;
	}

	//Lower case  
	for (int i = 36; i <= 62; ++i)
	{
		a[i] = i + 61;
		b[i] = i + 61;
		c[i] = i + 61;
		d[i] = i + 61;
	}
	crackPassword(a, b, c, d);
	free(a);
	free(b);
	free(c);
	free(d);
	getchar();
}




void crackPassword(int *a, int *b, int *c, int *d)
{
	char testPassword[4] = "";
	char Password[4] = "";
	Password[0] = 'W';
	Password[1] = 'E';
	Password[2] = 'S';
	Password[3] = 'T';

	bool passwordFound = false;

	for (int i = 0; i < 72; i++)
	{
		for (int j = 0; j < 72; j++)
		{
			for (int k = 0; k < 72; k++)
			{
				for (int l = 0; l < 72; l++)
				{
					testPassword[3] = a[i];
					testPassword[2] = b[j];
					testPassword[1] = c[k];
					testPassword[0] = d[l];
					// Because some reason strcmp doesnt want to work for idk reasons fuck that MEOW

					if (testPassword[0] == Password[0] && testPassword[1] == Password[1] && testPassword[2] == Password[2] && testPassword[3] == Password[3] )
					{
						printf("PASSWORD FOUND!!!!!");
						passwordFound = true;
						break;
					}
				}

				if (passwordFound == true)
				{
					break;
				}
			}
			if (passwordFound == true)
			{
				break;
			}
		}
		if (passwordFound == true)
		{
			break;
		}
	}
}