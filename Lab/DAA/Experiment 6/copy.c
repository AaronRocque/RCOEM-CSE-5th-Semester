#include <stdio.h>
#include <string.h>

struct node
{
    int val;
    char dir;
};

int max(int a, int b);
void print_lcs(char str[], int i, int j, int cost[30][30], char dir[30][30]);

void lcs(char str1[], char str2[] , int cost[30][30], char dir[30][30], int m, int n)
{
    //struct node c[m][n];

    for (int i = 0; i < m; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (i == 0 || j == 0)
            {
                cost[i][j] = 0;
                dir[i][j] = 0;
            }
            else
            {
                if (str1[i] != str2[j])
                {
                    cost[i][j] = max(cost[i - 1][j], cost[i][j - 1]);
                    if (cost[i - 1][j] >= cost[i][j - 1])
                        dir[i][j] = 'U';
                    else
                        dir[i][j] = 'S';
                }
                else
                {
                    cost[i][j] = cost[i - 1][j - 1] + 1;
                    dir[i][j] = 'D';
                }    
            }
        }
    }
    //return c;
}

void print_lcs(char str[], int i, int j, int cost[30][30], char dir[30][30])
{
    if (i == 0 || j == 0)
        return;
    
    if (dir[i][j] == 'D')
    {
        printf("ddddddddddddddddddddd\n");
        print_lcs(str, i - 1, j - 1, cost, dir);
        printf("%c", str[i]);
    }

    else
    {
        if (dir[i][j] == 'S')
            print_lcs(str, i, j - 1, cost, dir);
        else
            print_lcs(str, i - 1, j, cost, dir);
    }
}


int max(int a, int b)
{
    return (a > b) ? a : b;
}

int main()
{
    printf("aaaaaaaaaaaa\n");
    char str1[] = "AGCCCTAAGGGCTACCTAGCTT";
    char str2[] = "GACAGCCTACAAGCGTTAGCTTG";

    int cost[30][30];
    char dir[30][30];

    int m = strlen(str1);
    int n = strlen(str2);
    // struct node *c;
    // struct node c[m][n];

    lcs(str1, str2, cost, dir, m, n);

    printf("bbbbbbbbbbbbbbbbbb\n");

    printf("\n\n");

    for(int i=0; i<m;i++)
    {
        for (int j=0; j < 5; j++)
        {
            printf("%c", dir[i][j]);
        }

        printf("\n");
    }
    //c = lcs(a, b, m, n);
    print_lcs(str1, 30, 30, cost, dir);
    printf("cccccccccccccccc\n");

    return 0;
}