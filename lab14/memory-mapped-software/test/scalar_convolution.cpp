#include <iostream>
#include <stdio.h>
#include <iomanip>
#include <vector>

using namespace std;

#define INPUT_SIZE 8
#define KERNEL_SIZE 3
#define OUTPUT_SIZE 6
#define CHANNEL_SIZE 2
int kernel_center_X = KERNEL_SIZE / 2;
int kernel_center_Y = KERNEL_SIZE / 2;
void im2col(const int N[][INPUT_SIZE][INPUT_SIZE], vector<vector<int> >& N_col) {
    int col = 0;
    for (int i = 0; i < OUTPUT_SIZE; ++i) {
        for (int j = 0; j < OUTPUT_SIZE; ++j) {
            for (int cc = 0; cc < CHANNEL_SIZE; ++cc) {
                for (int m = 0; m < KERNEL_SIZE; ++m) {
                    for (int n = 0; n < KERNEL_SIZE; ++n) {
                        int ii = i + (m - kernel_center_X) +1;
                        int jj = j + (n - kernel_center_Y) +1;
                        N_col[col].push_back(N[cc][ii][jj]);
                    }
                }
            }
            ++col;
        }
    }
}

void kernel2row(const int M[][KERNEL_SIZE][KERNEL_SIZE], vector<vector<int> >& M_row) {
    
    for (int i = 0; i < OUTPUT_SIZE; ++i) {
        for (int j = 0; j < OUTPUT_SIZE; ++j) {
            int col = 0;
            for (int cc = 0; cc < CHANNEL_SIZE; ++cc) {
                for (int m = 0; m < KERNEL_SIZE; ++m) {
                    for (int n = 0; n < KERNEL_SIZE; ++n) {
                        M_row[col].push_back(M[cc][m][n]);
                        ++col;
                    }
                }
            }
        }
    }
    // for (int cc = 0; cc < CHANNEL_SIZE; ++cc) {
    //     for (int m = 0; m < KERNEL_SIZE; ++m) {
    //         for (int n = 0; n < KERNEL_SIZE; ++n) {
    //             M_row.push_back(M[cc][m][n]);
    //         }
    //     }
    // }
}

void matrixMultiplication(const vector<vector<int> >& N_col, const vector<vector<int> >& M_row, int P[][OUTPUT_SIZE]) {
    for (int i = 0; i < OUTPUT_SIZE * OUTPUT_SIZE; ++i) {
        int sum = 0;
        int temp = 0;
        for (int k = 0; k < M_row.size(); ++k) {
                sum += N_col[i][k] * M_row[k][i];
                cout << N_col[i][k] * M_row[k][i] << " ";
                
        }
        cout << endl;
        int row = i / OUTPUT_SIZE;
        int col = i % OUTPUT_SIZE;
        P[row][col] = sum;
    }
    // for(int i = 0; i < OUTPUT_SIZE; i ++){
    //     for(int j = 0; j < OUTPUT_SIZE; j ++){
    //         for(int k = 0; k < OUTPUT_SIZE; k ++){
    //             P[i][j] += N_col[i][k] * M_row[k][j];
    //         }
    //     }
    // }
    // for(int i = 0; i < OUTPUT_SIZE; i ++){
    //     for(int j = 0; j < OUTPUT_SIZE; j ++){
    //         for(int k = 0; k < OUTPUT_SIZE; k ++){
    //             P[i][j] += N_col[i][k] * M_row[k][j];
    //         }
    //     }
    // }
    cout << endl;
    int sum = 0;
    for (int k = 0; k < M_row.size(); ++k) {
        cout << "[";
        for(int i = 0; i < OUTPUT_SIZE * OUTPUT_SIZE; ++i){
            cout << N_col[i][k];
            if(i == (OUTPUT_SIZE * OUTPUT_SIZE - 1)){
                cout << "],";
            }
            else{
                cout << ", ";
            }
            // cout << N_col[i][k] * M_row[k][i]<< " ";
        }
        cout << endl;
    }

    cout << endl;
    for(int i = 0; i < OUTPUT_SIZE * OUTPUT_SIZE; ++i){
        cout << "[";
        for (int k = 0; k < M_row.size(); ++k) {
            cout << M_row[k][i];
            if(k == M_row.size() - 1){
                cout << "],\n";
            }
            else{
                cout << ", ";
            }
        }
    }
}

void convolution_2D(int N[][INPUT_SIZE][INPUT_SIZE], int M[][KERNEL_SIZE][KERNEL_SIZE], int P[][OUTPUT_SIZE]) {
    // for (int cc = 0; cc < CHANNEL_SIZE; ++cc ){
    //     for (int i = 0; i < OUTPUT_SIZE; ++i){              // rows
    //         for (int j = 0; j < OUTPUT_SIZE; ++j){          // columns
    //             for (int m = 0; m < KERNEL_SIZE; ++m){    // kernel rows
    //                 for (int n = 0; n < KERNEL_SIZE; ++n){ // kernel columns
                        
    //                         // Calculate index of input signal
    //                         int ii = i + (m - kernel_center_X) +1; 
    //                         int jj = j + (n - kernel_center_Y) +1;

    //                         P[i][j] += N[cc][ii][jj] * M[cc][m][n];
    //                 }
    //             }
    //         }
    //     }
    // }
    vector<vector<int> > N_col(OUTPUT_SIZE * OUTPUT_SIZE);
    vector<vector<int> > M_row(CHANNEL_SIZE * KERNEL_SIZE * KERNEL_SIZE);
    
    im2col(N, N_col);
    kernel2row(M, M_row);
    matrixMultiplication(N_col, M_row, P);
}

int main(){
    int   n[CHANNEL_SIZE][INPUT_SIZE ][INPUT_SIZE];
    int   m[CHANNEL_SIZE][INPUT_SIZE ][INPUT_SIZE];
    int ker[CHANNEL_SIZE][KERNEL_SIZE][KERNEL_SIZE];
    int ans[OUTPUT_SIZE][OUTPUT_SIZE];
    for(int c = 0; c<CHANNEL_SIZE;++c)
        for(int i=0; i<INPUT_SIZE;++i)
            for(int j=0;j<INPUT_SIZE;++j)
                n[c][i][j] = j, m[c][i][j] = j;

    for(int c = 0; c<CHANNEL_SIZE;++c)
        for(int i=0; i<KERNEL_SIZE;++i)
            for(int j=0;j<KERNEL_SIZE;++j)
                ker[c][i][j] = j;

    for(int i=0; i<OUTPUT_SIZE;++i)
        for(int j=0;j<OUTPUT_SIZE;++j)
            ans[i][j] = 0;


    //print
    printf("------ INPUT ------\n");
    for(int c = 0; c<CHANNEL_SIZE;++c){
        for(int i=0; i<INPUT_SIZE;++i){
            for(int j=0;j<INPUT_SIZE;++j)
                cout<<" "<<n[c][i][j];
            cout<<"\n";
        }
        cout<<"\n";
    }
    printf("\n------ KERNEL ------\n");
    for(int c = 0; c<CHANNEL_SIZE;++c){
        for(int i=0; i<KERNEL_SIZE;++i){
            for(int j=0;j<KERNEL_SIZE;++j)
                cout<< hex <<" "<<ker[c][i][j];
            cout<<"\n";
        }
        cout<<"\n";
    }
    printf("\n------ OUTPUT ------\n");
    for(int i=0; i<OUTPUT_SIZE;++i){
        for(int j=0;j<OUTPUT_SIZE;++j)
            cout<< hex <<" "<<ans[i][j];
        cout<<"\n";
    }
    
    // ------ CALCULATE ------
    convolution_2D(n,ker,ans);
    printf("\n------ ANSWER ------\n");
    for(int i=0; i<OUTPUT_SIZE;++i){
        for(int j=0;j<OUTPUT_SIZE;++j)
            cout<< hex <<" "<<ans[i][j];
        cout<<"\n";
    }
    return 0;
}