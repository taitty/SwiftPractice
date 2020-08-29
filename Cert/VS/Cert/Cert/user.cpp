#define DOC_SIZE 100 * 100000 + 1

int doc_width;
int str_length;

struct data {
    char value;
    int id;
};
data doc[DOC_SIZE];
char tmp[DOC_SIZE];

enum state {
    IDLE,
    EDITING,
    CONFLICT,
};
int user[10000];

void Init(int width, int length, char str[])
{
    for (int i = 0; i < DOC_SIZE; ++i)
        doc[i].value = doc[i].id = 0;

    for (int i = 0; i < 10000; ++i)
        user[i] = IDLE;

    doc_width = width;
    str_length = length;

    int idx = 0;
    for (int i = 0; i < str_length; ++i) {
        doc[idx++].value = str[i];
        int pin = idx - 1;
        if (str[i] == '\n') {
            for (int j = 0; j < 5 - pin % 6; ++j)
                doc[idx++].value = ' ';
        }
    }
}

void Edit(int id, int row, int col)
{
    doc[row * 6 + col].id = id;
    user[id] = EDITING;
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
