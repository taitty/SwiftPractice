#include <stdio.h>

char skip[26];
char text[20]="qwertyuioppoiuytrewq";
char key[4];

void makeTable() {

    for (int i=0;i<='z'-'a';++i) {
        skip[i]=4;
    }
    
    for (int i=0;i<3;++i) {
        skip[key[i]-'a'] = 4-i-1;
    }
}

int bmSearch() {
 
    makeTable();
    
    int i,j;
    for (i=0;i<16;) {
        for (j=3;j>=0;--j) {
            if (text[i+j]!=key[j]) {
                i += skip[text[i+j]-'a'];
                break;
            }
        }
        
        if (j == -1)
            return 1;
    }
    
    return 0;
}

int main() {
    
    printf("enter key : ");
    scanf("%s", key);
    
    printf("%s\n", (bmSearch())?"TRUE":"FALSE");
    
    return 0;
}
