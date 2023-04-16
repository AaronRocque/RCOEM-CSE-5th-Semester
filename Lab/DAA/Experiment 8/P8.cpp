#include <bits/stdc++.h>
using namespace std;

int main()
{

    int t = 1;
    int ans = 0;
    int i = 0;
    vector<int> result;

    while (t != 0)
    {

        //V for Vertices, E for Edges
        int V, E; 

        cin >> V;

        //If 0, that means end of input
        if (V == 0) 
        {
            break;
        }

        cin >> E; 

        map<int, vector<int>> graph;
        /*We have to use Map in combination with Vector
        * because for every node say 0, there can be 
        * multiple nodes attached to it, say 0-1, 0-2, 0-5 etc.
        * This is just like the Family name being the key and
        * the family members being memebers of that family.
        * Say, "Stark" is the family name and "Jon", "Rob",
        * "Sansa", "Arya", "Bran" are its members.
        *   
        * families["Stark"];
        * families["Stark"].push_back( "Jon" );
	    * families["Stark"].push_back( "Robb" );
        */

        for (int a = 0; a < E; a++)
        {
            int x, y;

            //Cause the inputs are two and in a single line
            cin >> x >> y;

            //Using the smaller value as key
            if (x > y)
            {
                graph[y].push_back(x);
            }
            else
            {
                graph[x].push_back(y);
            }
        }

        map<int, int> color;

        ans = 0;

        //auto, automatically detects the type of the variable
        for (auto x : graph)
        {
            if (color[x.first] == 0)
            {
                color[x.first] = 1;
            }

            for (int a = 0; a < x.second.size(); a++)
            {
                if (color[x.first] == color[x.second[a]])
                {
                    // cout<<"Breaking at "<<x.first<<"-"<<x.second[a]<<endl;
                    ans = 1;
                    break;
                }
                if (color[x.second[a]] == 0)
                {
                    if (color[x.first] == 1)
                    {
                        color[x.second[a]] = 2;
                    }

                    if (color[x.first] == 2)
                    {
                        color[x.second[a]] = 1;
                    }
                }
            }

            if (ans == 1)
            {
                break;
            }
        }

        

        if (ans == 1) 
        {
            result.push_back(1);
        }
        else
        {
            result.push_back(0);
        }

        i++;
 
    }

    for(auto j = result.begin(); j != result.end(); j ++)
    {
        if (*j == 1)
        {
            cout << "NOT BICOLORABLE." << endl;
        }
        else
        {
            cout << "BICOLORABLE." << endl;
        }
    }
    

    return 0;
}

//INPUT:
/*
3
3
0 1
1 2
2 0
9
8
0 1
0 2
0 3
0 4
0 5
0 6
0 7
0 8
0
*/