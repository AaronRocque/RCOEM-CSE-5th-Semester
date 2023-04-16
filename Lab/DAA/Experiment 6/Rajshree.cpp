#include <iostream>
using namespace std;
int max(int a, int b) { return (a > b ? a : b); }
void LCS(string str1, string str2, int cost[5][5], char dir[5][5])
{
    for (int i = 0; i < 5; i++)
    {
        for (int j = 0; j < 5; j++)
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
                    if (cost[i - 1][j] > cost[i][j - 1])
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
}
void printLCS(string str, int i, int j, int cost[5][5], char dir[5][5])
{
    if (i == 0 || j == 0)
        return;
    else if (dir[i][j] == 'D')
    {
        printLCS(str, i - 1, j - 1, cost, dir);
        cout << str[i];
    }
    else
    {
        if (dir[i][j] == 'S')
            printLCS(str, i, j - 1, cost, dir);
        else
            printLCS(str, i - 1, j, cost, dir);
    }
}
int main()
{
    string str1 = "0ABCD";
    string str2 = "0ABDE";
    int cost[5][5];
    char dir[5][5];

    LCS(str1, str2, cost, dir);
    for (int i = 0; i < 5; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            cout << cost[i][j] << " ";
        }
        cout << endl;
    }

    for (int i = 0; i < 5; i++)
    {
        for (int j = 0; j < 5; j++)
            cout << dir[i][j] << " ";
        cout << endl;
    }
    printLCS(str1, 4, 4, cost, dir);
}