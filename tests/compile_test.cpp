#include <iostream>
#include <string>
#include <unordered_map>

using namespace std;

int main(void) {
  string line;
  unordered_map<string, int> m;

  while (getline(cin, line)) {
    m[line]++;
    cout << line << " " << m[line] << endl;
  }

  return 0;
}