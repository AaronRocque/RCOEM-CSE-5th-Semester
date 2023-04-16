f = open('Stock.txt','r')
contents = f.read().split('\n')
for i in range(0, len(contents)):
    contents[i] = int(contents[i])
print("The contents of the file are \n")
print(contents)

#------------------------------------------------------------------

def find_min_and_max(a,i,j,min,max):
    min1 = a[0]
    max1 = a[0]

    if i == j: #for one element
        min = a[j]
        max = a[i]
    else:
        if i == j-1: #for two elements
            
            if a[i] < a[j]:
                max = a[j]
                min = a[i]
            else:
                max = a[i]
                min = a[j]
        else: #for more than two elements
            mid = (i + j) //2

            (min, max) = find_min_and_max(a, i, mid, min , max)
            (min1, max1) = find_min_and_max(a, mid+1, j, min1, max1)

            if max < max1:
                max = max1

            if min1 < min:
                min = min1

    return min, max


#------------------------------------------------------------------

(min, max) = find_min_and_max(contents, 0, len(contents)-1, contents[0], contents[0])
print("The minimum element in the list is", min)
print("The maximum element in the list is", max)


