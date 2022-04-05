import re

inp = "digraph {\n"
def makenode(a, b, c ):
    global inp
    inp = inp + "I" + a + " -> " + "I" + b + " [ " + "label= " + c +"]\n"


lines = []
with open('abc.txt') as f:
    lines = f.readlines()

curr_node = "-1"
state = "state"
reduc = "reduce"
for line in lines:
    #print(int(res[6]))
    if line == '\n' :
        continue
    if line[0:5] == state :
        res = re.findall(r'\w+', line)
        curr_node = res[1]
        continue
    if curr_node == '-1' :
        continue
    if line[5] <= 'Z' and line[5] >= 'A':
        res = re.findall(r'\w+', line)
        if res[1] == reduc :
            continue
        makenode(curr_node, res[6], res[0])
        continue
    if line[5] <= 'z' and line[5] >= 'a' :
        res = re.findall(r'\w+', line)
        makenode(curr_node, res[6], res[0])
        continue

inp += "}"
with open('samp.dot', 'w') as g:
    g.write(inp)


    

        