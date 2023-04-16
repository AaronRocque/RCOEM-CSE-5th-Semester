#include <stdio.h>
#include <stdlib.h>
struct node
{
    int val;
    char dir;
};
void print_lcs(int n, char a[], struct node C[][n], int i, int j)
{
    if (i == 0 || j == 0)
    {
        return;
    }
    if (C[i][j].dir == 'D')
    {
        print_lcs(n, a, C, i - 1, j - 1);

        printf("%c", a[i]);
    }
    else
    {
        if (C[i][j].dir == 'U')
        {
            print_lcs(n, a, C, i - 1, j);
        }
        else
        {
            print_lcs(n, a, C, i, j - 1);
        }
    }
}
int main()
{
    char a[] = "AGCCCTAAGGGCTACCTAGCTT";
    char b[] = "GACAGCCTACAAGCGTTAGCTTG";
    printf("First string: %s\n", a);
    printf("Second string: %s\n", b);
    struct node C[22][23];
    for (int i = 0; i < 22; i++)
    {
        for (int j = 0; j < 23; j++)
        {
            if (a[i] == 0 || b[j] == 0)
            {
                C[i][j].val = 0;
                C[i][j].dir = 'H';
            }
            if (a[i] != b[j])
            {
                C[i][j].val = C[i - 1][j].val > C[i][j - 1].val ? C[i - 1][j].val : C[i][j - 1].val;
                if (C[i - 1][j].val >= C[i][j - 1].val)
                {
                    C[i][j].dir = 'U';
                }
                else
                {
                    C[i][j].dir = 'S';
                }
            }
            if (a[i] == b[j])
            {
                C[i][j].val = C[i - 1][j - 1].val + 1;
                C[i][j].dir = 'D';
            }
        }
    }
    print_lcs(23, a, C, 21, 22);
}