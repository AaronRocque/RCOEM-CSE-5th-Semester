#include <stdio.h>
#include <string.h>

void bitDestuffing(int N, int arr[])
{
	int brr[30];

	int i, j, k;
	i = 0;
	j = 0;

	int count = 1;

	while (i < N) {

		if (arr[i] == 1) {

			brr[j] = arr[i];

			for (k = i + 1; arr[k] == 1 && k < N && count < 5; k++) {
				j++;
				brr[j] = arr[k];
				count++;

				if (count == 5) {
					k++;
				}
				i = k;
			}
            count = 1;
		}

		else {
			brr[j] = arr[i];
		}
		i++;
		j++;
	}

	for (i = 0; i < j; i++)
		printf("%d", brr[i]);
}

void bitStuffing(int N, int arr[])
{
	int brr[30];

	int i, j, k;
	i = 0;
	j = 0;

	int count = 1;

	while (i < N) {

		if (arr[i] == 1) {

			brr[j] = arr[i];

			// Loop to check 
			for (k = i + 1; arr[k] == 1 && k < N && count < 5; k++) {
				j++;
				brr[j] = arr[k];
				count++;

				// insert 0
				if (count == 5) {
					j++;
					brr[j] = 0;
				}
				i = k;
			}
            count = 1;
		}

		else {
			brr[j] = arr[i];
		}
		i++;
		j++;
	}


    printf("Stuffing:\n");
	for (i = 0; i < j; i++)
		printf("%d", brr[i]);

    printf("\n\nDestuffing:\n");
    bitDestuffing(N+2, brr);
}



int main()
{
	int N = 25;
	int arr[] = { 0,0,1,1,1,1,1,1,1,1,0,1,0,1,0,0,0,1,1,1,1,1,0,0,1 };

	bitStuffing(N, arr);

	return 0;
}
