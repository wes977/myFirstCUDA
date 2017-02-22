#include <iostream>
#include <ctime>
#include <cstdlib>
#include <math.h>
#include <stdio.h>
#include <iostream>
#include <string>
#include <stdio.h>

using namespace std;

#define SIZE	1024
#define MAX_PRIME	1024
#define passwordSize 4





__global__ void PasswordCrack(int *a, int n)
{

	int i = blockDim.x * blockIdx.x + threadIdx.x;
//	int j = blockDim.x * blockIdx.x + threadIdx.y;

	if (i > 1)
	{
		if (i < n ) // just checking these numbers 
		{

			if (i > 2)
			{
				a[(i) * 2] = 1;

			}
		}
	}


}


int main()
{

	int *a;
	int *d_a;
	int threadsPerBlock = MAX_PRIME;
	int blocksPerGrid = (MAX_PRIME + threadsPerBlock - 1) / threadsPerBlock;


	clock_t startTime = clock(); //Start timer
	clock_t endTime = clock(); //Start timer
	a = (int *)malloc(SIZE * sizeof(int));
	cudaMalloc(&d_a, SIZE * sizeof(int));


	for (int j = 1; j <= MAX_PRIME +1; j++)
	{
		a[j] = 0;
	}


	cudaMemcpy(d_a, a, SIZE * sizeof(int), cudaMemcpyHostToDevice);


	startTime = clock(); //  Resetting the clock 
	dim3 dimBlock(MAX_PRIME, 1, 1);
	dim3 dimGrid(1);
	PasswordCrack <<<dimGrid, dimBlock >>> (d_a, MAX_PRIME);



	endTime = clock();			// Getting the end time 
	printf("StartTime \t: %d Milliseconds \n", startTime);
	printf("endTime \t: %d Milliseconds \n", endTime);
	printf("Time taken \t: %d Milliseconds \n", (endTime - startTime));
	cudaMemcpy(a, d_a, SIZE * sizeof(int), cudaMemcpyDeviceToHost);
	int Counter = 0;
	for (int i = 0; i < MAX_PRIME; i++)
	{
		printf("%d = %d\n",i + 1, a[i]);
		if (a[i] == 0)
		{
			Counter++;
		}
	}
	printf("number of primes = %d", Counter);
	//free(a);

	cudaFree(d_a);

	printf("Press enter to end everything!");
	getchar();
	return 0;
}
