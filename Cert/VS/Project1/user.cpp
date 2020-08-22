#include <stdio.h>

#define MAX_N 1000
#define MAX_M 20

int size_N;
int size_M;
int tMap[MAX_N][MAX_N];
int tStars[MAX_M][MAX_M];

struct posi {
	int x;
	int y
};

struct stars_posi {
	posi std;
	posi nor[MAX_M];
};

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

void makeTable(int deg, int stars[MAX_M][MAX_M])
{
	stars_posi result;
	int numOfstar = 0;

	switch (deg) {
	case 1://90
		for (int i = 0; i < size_M; ++i) {
			for (int j = size_M - 1; j > 0; --j) {
				if (stars[i][j] == 0)
					continue;

				if (stars[i][j] == 9) {
					result.std.x = j;
					result.std.y = i;
				}
				else {
					result.nor[numOfstar].x = j;
					result.nor[numOfstar].y = i;
					++numOfstar;
				}
			}
		}
		break;
	case 2://180
		for (int i = size_M - 1; i > 0; --i) {
			for (int j = size_M - 1; j > 0; --j) {
				if (stars[i][j] == 0)
					continue;

				if (stars[i][j] == 9) {
					result.std.x = j;
					result.std.y = i;
				}
				else {
					result.nor[numOfstar].x = j;
					result.nor[numOfstar].y = i;
					++numOfstar;
				}
			}
		}
		break;
	case 3://270
		for (int i = size_M - 1; i > 0; --i) {
			for (int j = 0; j < size_M; ++j) {
				if (stars[i][j] == 0)
					continue;

				if (stars[i][j] == 9) {
					result.std.x = j;
					result.std.y = i;
				}
				else {
					result.nor[numOfstar].x = j;
					result.nor[numOfstar].y = i;
					++numOfstar;
				}
			}
		}
		break;
	default:// 0
		for (int i = 0; i < size_M; ++i) {
			for (int j = 0; j < size_M; ++j) {
				if (stars[i][j] == 0)
					continue;

				if (stars[i][j] == 9) {
					result.std.x = j;
					result.std.y = i;
				}
				else {
					result.nor[numOfstar].x = j;
					result.nor[numOfstar].y = i;
					++numOfstar;
				}
			}
		}
		break;
	}
}

Result findConstellation(int stars[MAX_M][MAX_M])
{
	Result res;

	for (int i = 0; i < 4; ++i) {
		makeTable(i, starts)
		matchConstellation();
	}

	res.y = res.x = 0;
	return res;
}