INF = 9999999 #A very big number

no_of_cities = 5

distances = [
     [0.0, 427.50202366902516, 385.2763086761522, 351.6311760175055, 419.1135964192494],    #Nagpur
     [427.50202366902516, 0.0, 74.550293671268, 87.48224082988976, 9.979747789152853],      #Mumbai
     [385.2763086761522, 74.550293671268, 0.0, 102.55989455322387, 74.1264796790887],       #Pune
     [351.6311760175055, 87.48224082988976, 102.55989455322387, 0.0, 77.55690666294466],    #Nashik
     [419.1135964192494, 9.979747789152853, 74.1264796790887, 77.55690666294466, 0.0]       #Thane
    ]

cities = ['Nagpur', 'Mumbai', 'Pune', 'Nashik', 'Thane']

selected_city = [0, 0, 0, 0, 0, 0, 0]

selected_city[0] = 1

no_edge = 0


print("\nEdge : Weight\n")

while (no_edge < no_of_cities - 1):
    
    minimum = INF
    a = 0
    b = 0
    
    for m in range(no_of_cities):
        if selected_city[m]:
            for n in range(no_of_cities):
                if ((not selected_city[n]) and distances[m][n]):  
                    if minimum > distances[m][n]:
                        minimum = distances[m][n]
                        a = m
                        b = n
    print(cities[a] + " -> " + cities[b] + " : " + str(distances[a][b]))
    selected_city[b] = True
    no_edge += 1

print("\n")