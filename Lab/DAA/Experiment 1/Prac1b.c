#include <stdio.h>

int minimum(int i, int j, int min, int a[]);
int maximum(int i, int j, int max, int a[]);

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
     

  }
  
  int min = minimum(0, i-1, numbers[0], numbers);
  printf("Minimum = %d\n", min);
  
  int max = maximum(0, i-1, numbers[0], numbers);
  printf("Maximum = %d\n", max);

  return 0;
}


int minimum(int i, int j, int min, int a[])
{
    int min1 = a[0];
    
    if(i == j) //for one element
    {
        min = a[j];
    }
    else 
    {
        if(i == j-1) //for two elements
        {
            if(a[i] < a[j])
            {
                min = a[i];
            }
            else
            {
                min = a[j];
            }
        }
        else //for more than two elements 
        {
            int mid = (i+j)/2;
            
            min = minimum(i, mid, min, a);
            min1 = minimum(mid+1, j, min1, a);
            
            if(min1 < min)
            {
                min = min1;
            }
        }
    }
    
    return min;
    
}

int maximum(int i, int j, int max, int a[])
{
    int max1 = a[0];
    
    if(i == j) //for one element
    {
        max = a[i];
    }
    else 
    {
        if(i == j-1) //for two elements
        {
            if(a[i] < a[j])
            {
                max = a[j];
            }
            else
            {
                max = a[i];
            }
        }
        else //for more than two elements 
        {
            int mid = (i+j)/2;
            
            max = maximum(i, mid, max, a);
            max1 = maximum(mid+1, j, max1, a);
            
            if(max < max1)
            {
                max = max1;
            }
            
    }
    
    return max;
    
    }

}