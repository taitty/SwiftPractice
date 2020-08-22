#include <stdio.h>

#define MAX_N 1000
#define MAX_M 20

int size_N;
int size_M;
int tMap[MAX_N][MAX_N];
int tStars[MAX_M][MAX_M];

struct posi {
	int x;
	int y;
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

}

Result findConstellation(int stars[MAX_M][MAX_M])
{
	Result res;

	res.y = res.x = 0;

	for (int i = 0; i < 4; ++i) {

		stars_posi star_posi;
		int numOfstar = 0;

		switch (i) {
		case 1://90
			for (int i = 0; i < size_M; ++i) {
				for (int j = size_M - 1; j > 0; --j) {
					if (stars[i][j] == 0)
						continue;

					if (stars[i][j] == 9) {
						star_posi.std.x = j;
						star_posi.std.y = i;
					}
					else {
						star_posi.nor[numOfstar].x = j;
						star_posi.nor[numOfstar].y = i;
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
						star_posi.std.x = j;
						star_posi.std.y = i;
					}
					else {
						star_posi.nor[numOfstar].x = j;
						star_posi.nor[numOfstar].y = i;
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
						star_posi.std.x = j;
						star_posi.std.y = i;
					}
					else {
						star_posi.nor[numOfstar].x = j;
						star_posi.nor[numOfstar].y = i;
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
						star_posi.std.x = j;
						star_posi.std.y = i;
					}
					else {
						star_posi.nor[numOfstar].x = j;
						star_posi.nor[numOfstar].y = i;
						++numOfstar;
					}
				}
			}
			break;
		}

		int y, x, cnt;
		for (y = 0; y <= size_N - size_M; ++y) {
			for (x = 0; x <= size_N - size_M; ++x) {
				if (tMap[star_posi.std.x + x][star_posi.std.y + y]) {
					for (cnt = 0; cnt < numOfstar; ++cnt) {
						if (tMap[star_posi.nor[cnt].x + x][star_posi.nor[cnt].y + y])
							continue;
						else
							break;
					}
				}
			}

			if (cnt == numOfstar) {
				res.x = star_posi.std.x + x;
				res.y = star_posi.std.y + y;
				return res;
			}
		}
	}

	return res;
}