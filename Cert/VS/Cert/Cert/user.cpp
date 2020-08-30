#define DOC_SIZE 100 * 100000 + 1
#define NUM_OF_IDS 10000

int doc_width;
int str_length;
char doc[DOC_SIZE];

enum state {
    IDLE,
    EDITING,
    CONFLICT,
};

struct editor {
    int idx;
    int state;
    char func;
    int strLen;
    char str[201];
};
editor user[NUM_OF_IDS];

void Init(int width, int length, char str[])
{
    for (int i = 0; i < DOC_SIZE; ++i)
        doc[i] = 0;

    for (int i = 0; i < NUM_OF_IDS; ++i)
        user[i].state = IDLE;

    doc_width = width;
    str_length = length;

    int idx = 0;
    for (int i = 0; i < str_length; ++i) {
        doc[idx] = str[i];
        if (doc[idx] == '\n') {
            for (int j = 0; j < doc_width - 1 - idx % doc_width; ++j)
                doc[idx++] = ' ';
            doc[idx++] = '\n';
        } 
        else {
            ++idx;
        }
    }
}

void Edit(int id, int row, int col)
{
    user[id].idx = row * doc_width + col;
    user[id].state = EDITING;
}

void Add(int id, int length, char str[])
{
    user[id].func = 'a';
    user[id].strLen = length;
    for (int i = 0; i < length; ++i)
        user[id].str[i] = str[i];
}
  
void Delete(int id, int length)
{
    user[id].func = 'd';
    user[id].strLen = length;
}

void Substitute(int id, int length, char str[])
{
    user[id].func = 's';
    user[id].strLen = length;
    for (int i = 0; i < length; ++i)
        user[id].str[i] = str[i];
}

int doAdd(int id) {
    char tgtStr[1001] = { 0, };
    char tmp[DOC_SIZE] = { 0, };

    // backup str
    int docIdx = user[id].idx;
    int tgtIdx = 0;
    do {
        if (doc[docIdx] != ' ')
            tgtStr[tgtIdx++] = doc[docIdx++];
        else
            ++docIdx;
    } while (doc[docIdx] != '\n');
    tgtStr[tgtIdx] = '\n';

    int tmpIdx = 0;
    do {
        tmp[tmpIdx++] = doc[docIdx++];
    } while (doc[docIdx] != '\0');

    // add str
    docIdx = user[id].idx;
    for (int i = 0; i < user[id].strLen; ++i)
        doc[docIdx++] = user[id].str[i];

    // restore str
    tgtIdx = 0;
    do {
        doc[docIdx++] = tgtStr[tgtIdx++];
    } while (tgtStr[tgtIdx] != '\n');

    for (int j = 0; j < doc_width - 1 - (docIdx - 1) % doc_width; ++j)
        doc[docIdx++] = ' ';
    doc[docIdx++] = '\n';

    tmpIdx = 0;
    do {
        doc[docIdx++] = tmp[tmpIdx++];
    } while (tmp[tmpIdx] != '\0');

    return user[id].strLen;
}

int EditDone(int id)
{
    if (user[id].state == CONFLICT)
        return 0;

    int offset = 0;
    switch (user[id].func)
    {
    case 'a':
        offset = doAdd(id);
        user[id].state = IDLE;
        for (int i = 0; i < NUM_OF_IDS; ++i) {
            if (user[i].state == EDITING) {
                user[i].idx = user[i].idx + offset;
            }
        }
        break;
    case 'd':
        break;
    case 's':
        break;
    default:
        return 0;
    }
    return 1;
}
