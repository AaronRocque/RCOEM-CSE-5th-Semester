import numpy as np
import random
from collections import defaultdict

def convert(a):
    adjList = defaultdict(list)
    for i in range(len(a)):
        for j in range(len(a[i])):
            if a[i][j]== 1:
                adjList[i].append(j)
    return adjList

######################################################################################

#Generates a random number 'n' between 5 and 10
n = random.randint(5,10)
print("The size of the matrix, n = " + str(n))

matrix=[]
rows, cols=n,n
for i in range(rows):
    col = []
    for j in range(cols):
        col.append(random.randint(0,1))
        if i == j:
          col.append(0)
    matrix.append(col)
print("\nThe Matrix is: ")
print(matrix)

######################################################################################

AdjList = convert(matrix)
print("\nAdjacency List:")
# print the adjacency list
for i in AdjList:
	print(i, end ="")
	for j in AdjList[i]:
		print(" -> {}".format(j), end ="")
	print()
 
######################################################################################

class Graph():
  def __init__(self,vertices):
    self.graph = defaultdict(list)
    self.V = vertices

  def addEdge(self,u,v):
    self.graph[u].append(v)
  
  def removeEdge(self,u,v):
    for i in range(len(self.graph[u])):
      if(self.graph[u][i] == v):
        self.graph[u].pop(i);
        break;

  def isCyclicUtil(self, v, visited, recStack, list1):

    visited[v] = True
    recStack[v] = True

    for neighbour in self.graph[v]:
      if visited[neighbour] == False:
        if self.isCyclicUtil(neighbour, visited, recStack, list1) == True:
          list1.append(v)
          return True
      elif recStack[neighbour] == True:
        list1.append(v)
        return True

    recStack[v] = False
    return False

  def isCyclic(self):
    list1 = []
    visited = [False] * (self.V + 1)
    recStack = [False] * (self.V + 1)
    for node in range(self.V):
      if visited[node] == False:
        if (self.isCyclicUtil(node, visited, recStack, list1) == True):
          if(len(list1) >= 3 and len(list1) < n):
            print("\nOnly part of the graph is cyclic.")
            print("\nThe cycle vertices are: ")
            print(list(reversed(list1)))
          elif(len(list1) >= n):
            print("\nThe complete graph is cyclic.")
            print("\nThe cycle vertices are: ")
            print(list(reversed(list1)))
          return True
    return False

g = Graph(n)
for i in AdjList:
 for j in AdjList[i]:
   g.addEdge(i,j)
   g.removeEdge(j,i)

if g.isCyclic() == 1:
	print ()
else:
	print ("\nGraph doesn't contain cycle.")
