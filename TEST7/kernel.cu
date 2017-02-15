#include <iostream>
#include <ctime>
#include <cstdlib>

#include <stdio.h>


#define SIZE	1024
#define passwordSize 4


char testPassword[] = "";

__global__ void VectorAdd(int *a, int *b, int *c, int n)
{
	int i = threadIdx.x;

	if (i < n)
		c[i] = a[i] + b[i];
}



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

	cudaMalloc(&d_a, SIZE * sizeof(int));
	cudaMalloc(&d_b, SIZE * sizeof(int));
	cudaMalloc(&d_c, SIZE * sizeof(int));
	cudaMalloc(&d_d, SIZE * sizeof(int));
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

startTime = clock(); //  Resetting the clock 

	cudaMemcpy(d_a, a, SIZE * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, SIZE * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(d_c, c, SIZE * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(d_d, d, SIZE * sizeof(int), cudaMemcpyHostToDevice);
	VectorAdd << < 1, SIZE >> >(d_a, d_b, d_c, SIZE);

	//cudaMemcpy(c, d_c, SIZE * sizeof(int), cudaMemcpyDeviceToHost);

	endTime = clock();			// Getting the end time 
	printf("StartTime \t: %d Milliseconds \n", startTime);
	printf("endTime \t: %d Milliseconds \n", endTime);
	printf("Time taken \t: %d Milliseconds \n", (endTime - startTime));


	for (int i = 0; i < 62; ++i)
	{
		printf("c[%d] = %d\n", i, c[i]);
	}

	free(a);
	free(b);
	free(c);

	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);
	printf("Press enter to end everything!");
	getchar();
	return 0;
}
