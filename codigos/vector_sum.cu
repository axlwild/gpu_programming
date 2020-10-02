/* Suma de matrices por hilos */


#include <ctime>
#include <iostream>
#include <time.h>
#include <math.h>
#define N 90000000

using namespace std;

void generateRandom(int *h_a);
void parallelAddition();
void serialAddition();
// en el host "h_"
// en device "d_"
int *h_a, *h_b, *h_c, *serialC;
int *d_a, *d_b, *d_c;
int size = N * sizeof(int);
double serialTimer;
float parallelTimer;
// definición del Kernel.
__global__ void vectorAdd(int *d_a, int *d_b, int *d_c){
    // múltiples bloques e hilos se deben de generar.
    // se necesita un índice para mapear...
    int index = threadIdx.x + (blockIdx.x * blockDim.x);
    d_c[index] = d_a[index] + d_b[index];
}

int main(int argc, char const *argv[])
{
    h_a = (int * ) malloc(size);
    h_b = (int * ) malloc(size);
    h_c = (int * ) malloc(size);
    serialC = (int * ) malloc(size);
    
    generateRandom(h_a);
    generateRandom(h_b);

    parallelAddition();
    serialAddition();
    free(h_a);
    free(h_b);
    free(h_c);
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    cout << "Speedup: " << (serialTimer / parallelTimer) << endl;
}

void generateRandom(int *h_a){
    srand(time(NULL));
    for (int i = 0; i < N; i++){
        h_a[i] = rand() % 101;
    }
}

void parallelAddition(){
    cudaMalloc((void **) &d_a, size);
    cudaMalloc((void **) &d_b, size);
    cudaMalloc((void **) &d_c, size);

    // transferir datos de host a device
    cudaMemcpy(d_a, h_a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, size, cudaMemcpyHostToDevice);

    int threads = 512;
    int blocks  = ceil(N/threads);

    // eventos para tomar tiempo
    cudaEvent_t start, stop;

    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start, 0);

    // llamada a kernel, número de bloques y de kernel
    vectorAdd<<<blocks, threads>>>(d_a, d_b, d_c);

    cudaEventRecord(stop, 0);

    cudaEventSynchronize(stop);

    cudaEventElapsedTime(&parallelTimer, start, stop);

    cout << "ellapser parallel timer: " << parallelTimer << "ms" << endl;

    cudaMemcpy(h_c, d_c, size, cudaMemcpyDeviceToHost);
    
}

void serialAddition(){
    clock_t start = clock();

    for(int i = 0; i<N; ++i){
        h_c[i] = h_a[i] + h_b[i];
    }
    clock_t end = clock();
    serialTimer = double(end-start) / double(CLOCKS_PER_SEC);
    cout << "Elapsed Serial Time: " << serialTimer << endl;
}