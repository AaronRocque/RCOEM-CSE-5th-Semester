#include <iostream>
using namespace std;

//A 0 is stuffed after every consecutive 5 1's.

int main()
{
    int a[20], b[20], i, n, j, count = 0, p = 0;

    cout << "Enter the frame size:";
    cin >> n;

    cout << "Enter the string in binary" << endl;
    for (i = 0; i < n; i++)
    {
        cin >> a[i];
    }
    // int a[]={1,1,1,1,1,0,1,1};

    //Copying the array from a[] to b[]
    for (i = 0; i < n; i++)
    {
        b[i] = a[i];
    }

    //Looping through the aentire array
    for (i = 0; i < n; i++)
    {
        if (a[i] == 1)
            count++;
        else
            //Resetting count
            count = 0;

        //5 consecutive 1's found
        if (count == 5)
        {
            //Increasing number of stuffed bits by 1
            p++;
            //Increasing the frame size by 1
            n = n + 1;
            //Pushing the elements of the array ahead 
            for (j = n; j > i + 1; j--)
            {
                a[j] = a[j - 1];
            }
            //Stuffing the bit
            a[i + 1] = 0;
        }
    }

    //Printing array elements 
    cout << "After bit stuffing" << endl;
    for (i = 0; i < n; i++)
        cout << a[i] << " ";
    cout << endl;

    //Decreasing fram size by subtracting the number of stuffed bits
    n = n - p;

    //Printing the copied array
    cout << "After bit destuffing" << endl;
    for (i = 0; i < n; i++)
        cout << b[i] << " ";
    cout << endl;
}

//8

// 0
// 1
// 1
// 1
// 1
// 1
// 1
// 0