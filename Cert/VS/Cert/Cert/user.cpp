#define MAX_N 1000
#define MAX_M 20

int size_N;
int size_M;
int tMap[MAX_N][MAX_N];
int temp[MAX_M][MAX_M];

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

Result findConstellation(int stars[MAX_M][MAX_M])
{
	Result res;

	res.y = res.x = 0;

	for (int i = 0; i < 4; ++i) {

		stars_posi star_posi = { 0, };
		int numOfstar = 0;

		// make table
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

		// match stars
		int y, x;
		int cnt = 0;
		for (y = 0; y < size_N - size_M + 1; ++y) {
			for (x = 0; x < size_N - size_M + 1; ++x) {
				if (tMap[star_posi.std.y + y][star_posi.std.x + x]) {
					for (cnt = 0; cnt < numOfstar; ++cnt) {
						if (tMap[star_posi.nor[cnt].y + y][star_posi.nor[cnt].x + x])
							continue;
						else
							break;
					}

					if (cnt == numOfstar) {
						res.x = star_posi.std.x + x;
						res.y = star_posi.std.y + y;
						return res;
					}
				}
			}
		}

		// rotate
		for (int i = 0; i < size_M; ++i)
			for (int j = 0; j < size_M; ++j)
				temp[i][j] = stars[i][j];

		for (int i = 0; i < size_M; ++i)
			for (int j = 0; j < size_M; ++j)
				stars[j][size_M - 1 - i] = temp[i][j];
	}

	return res;
}