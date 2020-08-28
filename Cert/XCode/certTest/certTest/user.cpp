
#define FALSE       0
#define EDITING     1
#define CONFLICT    2

int doc_width;
int str_length;

struct one_char {
    char value;
    char editing;
};
one_char doc[100001][101];

void Init(int width, int length, char str[])
{
    for (int i=0;i<100001;++i) {
        for (int j=0;j<101;++j) {
            doc[i][j].value = '\0';
            doc[i][j].editing = FALSE;
        }
    }
    
    doc_width = width;
    str_length = length;
  
    int row = 0;
    int col = 0;
    int cnt = 0;
    
    if (str[0] == '\n') {
        ++row;
        ++cnt;
    }
    
    do {
        doc[row][col++].value = str[cnt++];
        if ((col == 6) || (doc[row][col-1].value == '\n')) {
            col = 0;
            ++row;
        }
    } while (cnt < str_length);
}

void Edit(int id, int row, int col)
{
}

void Add(int id, int length, char str[])
{
}

void Delete(int id, int length)
{
}

void Substitute(int id, int length, char str[])
{
}

int EditDone(int id)
{
    return 0;
}
