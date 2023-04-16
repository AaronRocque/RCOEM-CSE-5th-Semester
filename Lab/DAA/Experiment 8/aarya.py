def side(adj, x, y):

    adj[x].append(y)
    adj[y].append(x)

def two_colour(adj):
 
    n = len(adj) # number of vertices
    colour_list = [0]*n # 0 represents no colour
    for u in range(n): # iterating through all the vertices
        if colour_list[u] == 0:
            if DFS(u, 'BLACK', colour_list, adj) == False:
                print("NOT BICOLORABLE.")
            else:
                print("BICOLORABLE.")


def DFS(u, c, colour_list, adj_list):
    colour_list[u] = c
    for v in adj_list[u]:
        if colour_list[v] == c:
            return False
        elif colour_list[v] == 0 and DFS(v, opposite(c), colour_list, adj) == False:
            return False
    return True

def opposite(c):
    if c =='BLACK':
        return 'RED'
    elif c =='RED':
        return 'BLACK'

while True:
 n=int(input())
 if n!= 0:
  l=int(input())
  adj = [[] for i in range(n+ 1)]
  for i in range(l):
     side(adj, int(input()), int(input()))
  two_colour(adj)
 else:
  break