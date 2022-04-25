map<string, vector<vector<string>>>out;
map<string, int>quad;
map<string, int>nex_quad;
int inc_quad(string func_name){
    quad[func_name] = next_quad[func_name];
    nex_quad[func_name] += 1;
    return quad[func_name];
}
int get_nex_quad(string func_name){
    return nex_quad[func_name];
}
int get_code_len(string func_name){
    return quad[func_name];
}
void emit(string func_name, string dest, string src1, string src2, string op){
    inc_quad(func_name);
    vector<string>p ;
    p.push_back(dest);
    p.push_back(src1);
    p.push_back(src2);
    p.push_back(op); 
    out[func_name].push_back(p);
}
void create_new_func(string func_name){
    vector<vector<string>>p;
    out[func_name] = p;
    quad[func_name] = -1;
    nex_quad[func_name] = 0;
}
void print_out(){
    map<string,vector<vector<string>>>::iterator it;

    vector<vector<string>>::iterator ti;
    for (it = out.begin(); it != out.end(); it++)
    {
        cout<<it->first <<":";
        vector<vector<string>>p;
        p = it->second;
        for(ti = p.begin(); ti != p.end(); ti++  ){
            for(int i = 0; i < *ti.size(); i++){
                cout<< *ti[i]<<" ";
            }
            cout<< endl;
        }
    }
}
void backpatch(string func_name, vector<int> p, string loc ){
    vector<int>::iterator ptr;
    for (ptr = p.begin(); ptr < p.end(); ptr++)
        out[func_name][*ptr][2] = loc;

}
void no_op(string func_name, vector<int>loc){
    vector<int>::iterator ptr;
    for (ptr = loc.begin(); ptr < loc.end(); ptr++)
        out[func_name][*ptr][3] = "NO_OP";
}
