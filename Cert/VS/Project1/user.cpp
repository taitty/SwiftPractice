#include <stdio.h>

#define MAX_N 1000
#define MAX_M 20

int size_N;
int size_M;
int tMap[MAX_N][MAX_N];
int tStars[MAX_M][MAX_M];

struct Result {
	int y, x;
};

void init(int N, int M, int Map[MAX_N][MAX_N])
{
	size_N = N;
	size_M = M;
	
	for (int i = 0; i < size_N; ++i)
		for (int j = 0; j < size_N; ++j)
			tMap[i][j] = Map[i][j];
}

Result findConstellation(int stars[MAX_M][MAX_M])
{
	Result res;

	for (int i = 0; i < 4; ++i) {
		matchConstellation();
		rotateConstellation();
	}

	res.y = res.x = 0;
	return res;
}