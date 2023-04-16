#include <stdio.h>

int minimum(int arr[]);
int maximum(int arr[]);

int main(void)
{
  int numbers[50];
  int i = 0;
  FILE *file;

  if (file = fopen("Stock.txt", "r"))
  {
    while (fscanf(file, "%d", &numbers[i]) != EOF)
    {
      i++;
    }
    fclose(file);

    numbers[i] = '\0';
     
    int min = minimum(numbers);
    int max = maximum(numbers);
    
    printf("Minimum = %d\n", min);
    printf("Maximum = %d\n", max);
  }

  return 0;
}

int minimum(int arr[])
{
    int min = arr[0];
    
    for(int i = 0; arr[i] != '\0'; i++)
    {
        if(arr[i] <= min)
        {
            min = arr[i];
        }
    }
    
    return min;
}

int maximum(int arr[])
{
    int max = arr[0];
    
    for(int i = 0; arr[i] != '\0'; i++)
    {
        if(arr[i] >= max)
        {
            max = arr[i];
        }
    }
    
    return max;
}
