#include <bits/stdc++.h>
using namespace std;

//Finds minimum of three numbers
int min(int x, int y, int z) 
{ 
    return min(min(x, y), z); 
}

int editDistDP(string str1, string str2, int m, int n)
{
    //Table to store results of subproblems
    int dp[m + 1][n + 1];

    //Fills d[][] in bottom up manner
    for (int i = 0; i <= m; i++)
    {
        for (int j = 0; j <= n; j++)
        {
            //If first string is empty,
            //insert all characters of second string
            if (i == 0)
                dp[i][j] = j; // Min. operations = j

            //If second string is empty,
            //remove all characters of second string
            else if (j == 0)
                dp[i][j] = i; // Min. operations = i

            //If last characters are same, 
            //ignore last char and recur for remaining string
            else if (str1[i - 1] == str2[j - 1])
                dp[i][j] = dp[i - 1][j - 1];

            //If the last character is different, 
            //consider all possibilities and find the minimum
            else
                dp[i][j] = 1 + min(dp[i][j - 1],      // Insert
                                   dp[i - 1][j],      // Remove
                                   dp[i - 1][j - 1]); // Replace
        }
    }

    return dp[m][n];
}

//Driver code
int main()
{
    //Stored dictionary of 10 words
    char dictionary[10][10] = {"hello", "hell", "halo", "hand", "help", "god", "gold", "good", "goon", "gone"};

    //Prints the words of the dictionary
    cout << "\nThe words in the dictionary are: \n";
    for (int i = 0; i < 10; i++)
    {
        cout << dictionary[i] << "\n";
    }
    cout << "\n";

    //A word is taken as input
    string str1;
    cout << "\nEnter the word: \n";
    cin >> str1;

    string str2;
    
    //The distances i.e. the no. of changes on each word to make it like str1 is stored here
    int arr[10];

    //Checking str1 with every word of the dictionary to fill arr[]
    for (int i = 0; i < 10; i++)
    {
        //If the word is found as it is in the dictionary
        if (str1 == dictionary[i])
        {
            cout << "\nCORRECT SPELLING!\n";
            exit(0);
        }
        //If word doesn't match run the algo.
        else
        {
            str2 = dictionary[i];
            arr[i] = editDistDP(str1, dictionary[i], str1.length(), str2.length());
        }
    }

    //Print the distance
    // for (int i = 0; i < 10; i++)
    // {
    //     cout << arr[i] << "\t";
    // }

    int min = 99;

    cout << "\nThe spelling of the word you entered is incorrect:\n";
    cout << "\nDid you mean:\n\n";

    for (int j = 0; j < 5; j++)
    {
        //Stores index of the minimum value in each iteration
        int var;

        for (int i = 0; i < 10; i++)
        {
            if (arr[i] <= min)
            {
                min = arr[i];
                var = i;
            }
        }

        min = 99;
        arr[var] = 9999;
        cout << dictionary[var] << "\n";
    }

    return 0;
}