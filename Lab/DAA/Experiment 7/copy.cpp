#include <bits/stdc++.h>
using namespace std;

#define V 5

bool hamCycle(bool G[V][V], int path[], int pos)
{
    
    //Case 1: All vertices are included in the path
    if(pos == V)
    {
        //This means there is a connection between the first and last vertex
        if(G[path[pos - 1]][path[0]] == 1)
        {
            return true;
        }
        else
        {
            return false;   
        }
    }

    //Case 2: Checking different different vertices with their different different connections
        //Not stating with 0 cause its already selected
    for(int vertex = 1; vertex < V; vertex++)
    {
        //Check if their is a connection between this vertex and the previously added one
        if(G[path[pos-1]][vertex] == 0)
        {
                break;
        }

        //Check if the vertex is already in the path array
        int doneFlag = 0;

        for(int i = 0; i < pos; i++)
        {
            if(path[i] == vertex)
            {
                doneFlag = 1;
                break;
            }
        }
        if(doneFlag == 1)
        {
            break;
        }

        path[pos] = vertex;

        //Calling the function again with the newly added vertex    
        if(hamCycle(G, path, pos + 1) == true)
        {
            return true;
        }

        //If it doesn't return true, means it did not get a new vertex, 
        //means the old vertex was a bad choice, 
        //we will remove it

        path[pos] = -1;

    }

    //If we reach here, this means we never returned anything,
    //this means we couldn't make the cycle 
    cout << "\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\n";
    return false;
    
}

int main() 
{
    bool graph[V][V] = {{0, 1, 0, 1, 0},
                        {1, 0, 1, 1, 1},
                        {0, 1, 0, 0, 1},
                        {1, 1, 0, 0, 1},
                        {0, 1, 1, 1, 0}};

    //This makes an array 'path' of size V
    int *path = new int[V]; 

    //Initializing the path with -1
    for(int i = 0; i < V; i++)
    {
        path[i] = -1;
    }

    path[0] = 0;

    if(hamCycle(graph, path, 1) == false)
    {
        cout << "\nSolution does not exist!\n";
    }
    else
    {
        cout << "\nSolution Exists!\n";
        cout << "Following is one Hamiltonian Cycle \n";
        for (int i = 0; i < V; i++)
        {
            cout << path[i] << " ";
        }
        
        //Printing first vertex again to show a complete cycle 
        cout << path[0] << " ";
        cout << endl;
        }
}