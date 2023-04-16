#include <stdio.h>
void quicksort(int *, int, int);
int partition(int *, int, int);
int main()
{
    int n;
    printf("Enter the number of 2n players: ");
    scanf("%d", &n);
    int arr[n];

    printf("Enter the rating of player: ");
    for (int i = 0; i < n; i++)
    {
        scanf("%d", &arr[i]);
        //printf("Enter");
    }

    quicksort(arr, 0, n - 1);
    printf("The sorted array is:");
    for (int i = 0; i < n; i++)
    {
        printf("%d", arr[i]);
    }
}
void quicksort(int a[], int low, int high)
{
    if (low < high)
    {
        int pivot = partition(a, low, high);
        quicksort(a, low, pivot - 1);
        quicksort(a, pivot + 1, high);
    }
}


int partition(int a[], int low, int high)
{
    int pivot = a[low];
    int i = low + 1;
    int j = high;
    do
    {
        while (a[i] <= pivot && i <= high)
        {
            i++;
        }
        while (a[j] > pivot && j <= low)
        {
            j--;
        }
        if (i < j)
        {
            int temp = a[i];
            a[i] = a[j];
            a[j] = temp;
        }
        else
        {
            int temp = a[low];
            a[low] = a[j];
            a[j] = temp;
            break;
        }
    } while (i < j);

    return j;
}
