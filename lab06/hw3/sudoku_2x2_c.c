#include <stdio.h>
#include <stdlib.h>
#include "sudoku_2x2_c.h"
bool check(char* set, int index){
    int idx_i = index / 4;
    int idx_j = index % 4;
    int current_cur = idx_i * 4 + idx_j;
    // same col
    for(int i = 0; i < 4; i ++){
        if(i == idx_i)continue;
        if(set[i * 4 + idx_j] == set[current_cur])return false;
    }
    // same row
    for(int j = 0; j < 4; j ++){
        if(j == idx_j)continue;
        if(set[idx_i * 4 + j] == set[current_cur])return false;
    }
    int mod_i = idx_i % 2;
    int mod_j = idx_j % 2;
    // is left_up --> (0, 0), (0, 2), (2, 0), (2, 2)
    if(mod_i == 0 && mod_j == 0){
        if( set[current_cur] == set[current_cur + 1] || \
            set[current_cur] == set[current_cur + 4] || \
            set[current_cur] == set[current_cur + 5])
            return false;
    }
    // is right_up --> (0, 1), (0, 3), (2, 1), (2, 3)
    else if(mod_i == 0 && mod_j == 1){
        if( set[current_cur] == set[current_cur - 1] || \
            set[current_cur] == set[current_cur + 3] || \
            set[current_cur] == set[current_cur + 4])
            return false;
    }
    // is left_down --> (1, 0), (1, 2), (3, 0), (3, 2)
    else if(mod_i == 1 && mod_j == 0){
        if( set[current_cur] == set[current_cur - 4] || \
            set[current_cur] == set[current_cur - 3] || \
            set[current_cur] == set[current_cur + 1])
            return false;
    }
    // is right_down --> (1, 1), (1, 3), (3, 1), (3, 3)
    else if(mod_i == 1 && mod_j == 1){
        if( set[current_cur] == set[current_cur - 5] || \
            set[current_cur] == set[current_cur - 4] || \
            set[current_cur] == set[current_cur - 1])
            return false;
    }

    return true;
}
bool solver(char* set, int index){
    if(index >= 16){
        return true;
    }

    if(*(set + index) > 0){
        return solver(set, index + 1);
    }
    else{
        for(int i = 1; i <= 4; i++){
            *(set + index) = i;
            if(check(set, index) && solver(set, index + 1)){
                return true;
            }
            *(set + index) = 0;
        }
    }
    return false;
}
bool sudoku_2x2_c(char *test_c_data){
// TODO
// Finish your sudoku algorithm in c language
    return solver(test_c_data, 0);
}