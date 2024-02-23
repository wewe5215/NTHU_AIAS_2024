# (NTHU_109062320_朱季葳) AIAS 2024 Lab 1 HW Submission 
[toc]

### HW 1-1 Python programming Accessment

#### HW 1-1-1 Reverse Bits

- I spent 16 minutes to solve this problem. 
找處理padding的function花了一些時間
#### Code
```python
class Solution:
    # @param n, an integer
    # @return an integer
    def reverseBits(self, n):
        binary_str = bin(n)[2:] #integer to binary
        binary_str_padded = binary_str.zfill(32) #padding
        ret = binary_str_padded[::-1] #reverse the string padded
        integer_val = int(ret, 2) #binary to integer
        return integer_val
```

#### Submission screenshot
![](https://course.playlab.tw/md/uploads/b9162d50-684d-4b11-8881-a0ebb62f9e05.png)


#### HW 1-1-2 Valid Sudoku

- I spent 8 minutes to solve this problem.
#### Code
```python=
class Solution(object):
    def isValidSudoku(self, board):
        """
        :type board: List[List[str]]
        :rtype: bool
        """
        rows = [list() for _ in range(9)]
        cols = [list() for _ in range(9)]
        subgrids = [list() for _ in range(9)]
        # Iterate through the board to record the digit in the corresponding `rows`, `cols`, and `subgrids`.
        # If a collision occurs, return false, as it is illegal in a Sudoku game.
        for i in range(9):
            for j in range(9):
                if board[i][j] != ".":
                    digit = board[i][j]
                    if digit not in rows[i]:
                        rows[i].append(digit)
                    else:
                        return False
                    if digit not in cols[j]:
                        cols[j].append(digit)
                    else:
                        return False
                    if digit not in subgrids[(j//3) + 3 * (i//3)]:
                        subgrids[(j//3) + 3 * (i//3)].append(digit)
                    else:
                        return False

        return True
```

#### Submission screenshot
![](https://course.playlab.tw/md/uploads/3c6d1338-5884-4b90-b387-f288f2c831eb.png)




### HW 1-2 C programming Accessment

#### HW 1-2-1 Merge Two Sorted Lists

- I spent 13 minutes to solve this problem. 

#### Code
```cpp
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
        ListNode* list1_it = list1;
        ListNode* list2_it = list2;
        ListNode* merged;
        /*
         * if (list1_it == nullptr) && (list2_it == nullptr), then return nullptr to indicate that both lists are empty.
         * Otherwise, the output will default to [0]
         */

        if(list1_it || list2_it)merged = new ListNode;
        ListNode* head = merged;
        while(list1_it || list2_it){
            if(list1_it && list2_it){
                /*
                 * Identify the smaller value between two Nodes and append it to the list.
                 * Advance the iterator with smaller value
                 */
                if(list1_it->val <= list2_it->val){
                    ListNode* new_node = new ListNode;
                    merged->val = list1_it->val;
                    merged->next = new_node;
                    merged = merged->next;
                    list1_it = list1_it->next;
                }
                else{
                    ListNode* new_node = new ListNode;
                    merged->val = list2_it->val;
                    merged->next = new_node;
                    merged = merged->next;
                    list2_it = list2_it->next;
                }
            }
            /*
             * When list1_it is nullptr, all of the Nodes in list1 are already traversed, 
             * or it is empty originally.
             */
            else if(!list1_it){
                merged->val = list2_it->val;
                if(list2_it->next){
                    ListNode* new_node = new ListNode;
                    merged->next = new_node;
                }
                else{
                    merged->next = nullptr;
                }
                
                merged = merged->next;
                list2_it = list2_it->next;
            }
            else{
                merged->val = list1_it->val;
                if(list1_it->next){
                    ListNode* new_node = new ListNode;
                    merged->next = new_node;
                }
                else{
                    merged->next = nullptr;
                }
                
                merged = merged->next;
                list1_it = list1_it->next;
            }
            

        }
        return head;
    }
    
};
```

#### Submission screenshot
![](https://course.playlab.tw/md/uploads/760a6e11-4a34-4824-ba48-e567f3c6cf18.png)


#### HW 1-2-2 Set Matrix Zeroes

- I spent 15 minutes to solve this problem. 

#### Code
```c plus plus
class Solution {
public:
    void setZeroes(vector<vector<int>>& matrix) {
        /*
         * Use col_zero and row_zero to record the rows/columns that contain zero
         */
        vector<int>col_zero;
        vector<int>row_zero;
        for(int i = 0; i < matrix.size(); i ++){
            for(int j = 0; j < matrix[0].size(); j ++){
                if(matrix[i][j] == 0){
                    row_zero.push_back(i);
                    col_zero.push_back(j);
                }
            }
        }
        // set its entire column to 0's.
        for(int i = 0; i < col_zero.size(); i ++){
            for(int j = 0; j < matrix.size(); j ++){
                matrix[j][col_zero[i]] = 0;
            }
        }
        // set its entire row to 0's.
        for(int i = 0; i < row_zero.size(); i ++){
            for(int j = 0; j < matrix[0].size(); j ++){
                matrix[row_zero[i]][j] = 0;
            }
        }

    }
};
```

#### Submission screenshot
![](https://course.playlab.tw/md/uploads/7d714553-03bd-4fc0-a7c2-9bf65b638d37.png)

### HW 1-3 Verilog Accessment

#### HW 1-3-1 Combinational Circuit Design

- I spent 64 minutes to solve this problem. 

#### Code
```verilog
module top_module (
    input [2:0] a,
    output [15:0] q ); 
    // m1 + m6
    assign q[15] = (~a[2] & ~a[1] & a[0]) | (a[2] & a[1] & ~a[0]);
    // m3 + m5 + m6
    assign q[14] = (~a[2] & a[1] & a[0]) | (a[2] & ~a[1] & a[0]) | (a[2] & a[1] & ~a[0]);
    // m1 + m2 + (m4 + m5) + m7
    assign q[13] = (~a[2] & ~a[1] & a[0]) | (~a[2] & a[1] & ~a[0]) | (a[2] & ~a[1]) | (a[2] & a[1] & a[0]);
    // m0 + m3 
    assign q[12] = ~a[2] & (a[1] ~^ a[0]);
    // m1 + m3 + m7
    assign q[11] = (~a[2] & a[0]) | (a[1] & a[0]);
    // (m1 + m5) | (m2 + m6) | m7
    assign q[10] = (~a[1] & a[0]) | (a[1] & ~a[0]) | (a[2] & a[1] & a[0]);
    // (m0 + m1 + m2 + m3) + m7
    assign q[9] = ~a[2] | (a[1] & a[0]);
    // (m6 + m7) + (m2 + m6)
    assign q[8] = (a[2] & a[1]) | (a[1] & ~a[0]);
    // (m1 + m5) + m2
    assign q[7] = (~a[1] & a[0]) | (~a[2] & a[1] & ~a[0]);
    //(m1 + m5) + (m4 + m5) + m2
    assign q[6] = (~a[1] & a[0]) | (a[2] & ~a[1]) | (~a[2] & a[1] & ~a[0]);
    // (m0 + m1) + (m4 + m6)
    assign q[5] = (~a[2] & ~a[1]) | (a[2] & ~a[0]);
    // m0 + m7 + m2
    assign q[4] = (~a[2] & ~a[1] & ~a[0]) | (a[2] & a[1] & a[0]) | (~a[2] & a[1] & ~a[0]);
    // (m3 + m5) + (m3 + m7)
    assign q[3] = (a[2] & a[0]) | (a[1] & a[0]);
    // (m2 + m3 + m4 + m5) + (m5 + m6)
    assign q[2] = (a[2] ^ a[1]) | (a[2] & ~a[0]);
    // (m0 + m4) | (m4 + m6) | (m3 + m5)
    assign q[1] = (~a[1] & ~a[0]) | (a[2] & ~a[0]) | ((a[2] ^ a[1]) & a[0]);
    // m7
    assign q[0] = (a[2] & a[1] & a[0]);
endmodule 

```

#### Submission screenshot
![](https://course.playlab.tw/md/uploads/95d5a3ba-8afc-45a7-9c95-d6f54b92b67c.png)

#### HW 1-3-2 Sequential Circuit Design
- I spent 8 minutes to solve this problem. 

#### Code
```verilog
module top_module (
    input clk,
    input a,
    output [3:0] q );
    wire [3:0] last_q;
    // The circuit triggers on the positive edge of the clock signal.
    always @(posedge clk)begin
        // When the signal "a" is high, set the value stored in "q" to 4.
        if(a)begin
           q <= 3'b100;
        end

        // Check the value stored in "q" from the previous cycle.
        else begin
            // reset "q" to 0 in this cycle when "last_q" is 6
            if(last_q == 3'd6)begin 
                q <= 3'd0;
            end
            // Otherwise, increment the original value of "q" by 1.
            else begin
                q <= q + 3'b001;
            end

        end
        
    end
    
    //  Store the current value of "q" in "last_q" for use in the next cycle.
    assign last_q = q;
endmodule
```

#### Submission screenshot
![](https://course.playlab.tw/md/uploads/781d765c-0469-4997-8bd4-de8d3c58394c.png)


