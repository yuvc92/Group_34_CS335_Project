
typedef struct{
    int offset;
    string type;
    int wid;
    int scopelevel;
    map<string, string>attr;
}identifier;

typedef struct {
    string scopename;
    string parent;
    string type;
    string returntype;
    int scopelevel;
    string var;
    map<string,identifier>variables;
    int num;
}scope;

typedef struct{
    string memory;
    bool store;
    string scope;
    string var;
    string reg;
} temp_var;


class SymbolTable
{
    // Access specifier
    public:
    map<string, scope>symbol_table;
    vector<scope>stack_history; //////////////////////////
    vector<int>offset_stack;
    map<string, scope>function_list;
    vector<scope>scope_stack;
    map<string, temp_var>addr_desc;
    int string_count = 0;
    int var_count = 0;
    
    // Member Functions()
    string getNewTempVar(string memLoc, string var, bool loadfromMem)
    {
       var_count += 1;
       string temp = "var" + to_string(var_count);
       temp_var t1;
       t1.memory = memLoc;
       t1.reg = "";
       t1.store = loadfromMem;
       t1.scope = getCurrScope();
       t1.var = var;
       addr_desc[temp] = t1;
       return temp;
    }
    void changeMemLoc(string name, string memLoc, string var ){
        addr_desc[name].memory = memLoc;
        addr_desc[name].var = var;
        addr_desc[name].scope = getCurrScope();
    }
    identifier* lookup(string id){
        int curr_scope = scope_stack.size();
        return lookupScope(id, curr_scope -1);
    }
    identifier* lookupScope(string id, int pos){
        if(pos < 0)return NULL;
        scope curr = scope_stack[pos];
        auto it = curr.variables.find(id);
        if(it != curr.variables.end()){
            return it;
        }
        else return lookupScope(id, pos-1);
    }

    string getCurrScope(){
        return scope_stack[scope_stack.size() - 1].scopename;
    }
    void addScope(string name, string var){
        scope curr = scope_stack[scope_stack.size() - 1];
        scope t1;
        t1.scopename = name;
        t1.parent = curr.scopename;
        t1.type = "FUNCTION";
        t1.returntype = "NUMBER";
        t1.scopelevel = curr.scopelevel +1;
        t1.var = var;
        scope_stack.push_back(t1);
        offset_stack.push_back(0);
        function_list[scopename] = t1;
    }

    void add_Id(string id, string type){
        scope curr = scope_stack[scope_stack.size() - 1];
        int curr_offset = offset_stack.pop_back();
        identifier t1 ;
        int wd = wid(type);
        t1.offset = curr_offset;
        t1.type = type;
        t1.wid = wd
        t1.scopelevel = curr.scopelevel; 
        curr.variables[id] = t1;
        offset_stack.push_back(curr_offset + wd);
    }

    void add_attr(string id, strng key, string val){
        identifier* t1 = lookup(id);
        t1->attr[key] = val;
    }
    string get_attr(string id, string key){
        identifier* t1 = lookup(id);
        if(key == "type")return t1->type;
        auto it = t1->attr.find(key);
        if(it != t1->attr.end()){
            return t1->attr[key];
        }
        return "";
    }
    string get_attr_from_scope(string key){
        scope curr = scope_stack[scope_stack.size() - 1];
        return curr.returntype;
    }
    void add_attr_to_scope(string ){
        scope curr = scope_stack[scope_stack.size() - 1];

    }
    void add_attr_to_scope1(string p,int q ){
        scope curr = scope_stack[scope_stack.size() - 1];
        curr.num = q
    }
    void add_attr_to_scope2(string p,string q ){
        scope curr = scope_stack[scope_stack.size() - 1];
        curr.returntype = q;
    }
    printscopestack
    get_attr_from_func
    get_func_attr
    // getBaseAddr
    bool present(string id){
        if(lookup(id))return true;
        return false;
    }
    bool curr_present(string id){
        scope curr = scope_stack[scope_stack.size() - 1];
        // scope_stack[pos];
        auto it = curr.variables.find(id);
        if(it != curr.variables.end()){
            return true;
        }
        return false;
    }
    void remove_scope(){
        scope curr = scope_stack.pop_back();
        curr.wid = offset_stack.pop();
        stack_history.push_back(curr);
    }
    int wid(string type){
        if(type == "NUMBER")return 4;
        if(type == "STRING")return 256;
        if(type == "UNDDEFINED")return 0;
        if(type == "FUNCTION")return 4;
        if(type == "BOOLEAN")return 4;
        return 0;
    }
};