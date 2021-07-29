        SUBP fib     #声明fib函数
        PUSH 00 0    #将参数n压至栈顶 
        ISUB 1       #将栈顶值减1
        CJMP fibjmp1 #若大于一则跳转至fijmp1
        PUSH 1       #(否则)栈顶压立即数1
        RETP         #返回值
fibjmp1:PUSH 00 0    #将参数n压至栈顶
        ISUB 1       #将栈顶值减1
        CALL 1 fib   #调用函数
        PUSH 00 0    #将参数n压至栈顶
        ISUB 2       #将栈顶值n减2
        CALL 1 fib   #调用函数fib,参数数为1
        SADD         #计算栈顶两值之和并压栈
        RETP         #返回值
        SUBP pi      #声明pi函数
        PUSH 0.0     #压栈sum=0
        PUSH 1.0     #压栈sig=1.0
        PUSH 1       #压栈i=1
        PUSH 0 3     #将i压入栈顶
pijmp1: PUSH 0 0     #将参数n压入栈顶
        SSUB         #计算n-i的值
        CJMP pijmp2  #若大于0,则跳转至pijmp1
        PUSH 00 1     #将sum压至栈顶
        PUSH 00 2     #将sig压至栈顶
        PUSH 00 3     #将i压至栈顶
        SDIV         #计算sig/i的值并压栈
        SADD         #计算sum+sig/i的值并压栈
        COPY 00 1     #将栈顶的值赋值给sum
        PUSH 00       #将0进行压栈
        PUSH 00 2     #将sig进行压栈
        SSUB         #计算0-sig的值并压栈
        COPY 00 2     #将栈顶值赋值给sig
        PUSH 00 3     #将i进行压栈
        IADD 2       #将栈顶值加2
        COPY 00 3     #将栈顶赋值给i
        NJMP pijmp1  #跳转至pijmp1
pijmp2: SPOP 00 1 3   #弹栈至3位
        PUSH 00 1     #将sum压至栈顶
        RETP         #返回值
        SUBP main    #main函数
        DATA 2
        int 4 1 3 5 7#注册iarr
        int 3 1.1 2.2 3.3 #注册farr
        PUSH 0       #注册i
        PUSH 3       #将3进行压栈
        PUSH 00 0    #取i
mainjmp1:SSUB        #计算3-i的值
        CJMP mainjmp2#若大于0则跳转至mainjmp1
        PUSH 00 0    #取i
        PDAT ffff    #取arr[i]的值放至栈顶
        CALL 1 print #调用print函数
        SPOP 0 0 1   #丢弃返回结果
        PUSH 00 0    #取i
        IADD 4       #取farr基址
        PDAT ffff    #取farr[i]的值放至栈顶
        CALL 1 print #调用print函数
        SPOP 0 0 1   #丢弃返回结果
        PUSH 3       #将3进行压栈
        PUSH 00 0    #取i
        IADD 1       #i++
        COPY 00 0    #赋值给i        
        NJMP mainjmp1#跳转至mainjmp1
mainjmp2:SPOP 01 0   #销毁至0
        PUSH 3       #立即数3压栈
        PDAT ffff    #取iarr[3]
        CALL 1 print #调用print函数
        SPOP 0 0 1   #丢弃返回结果
        PUSH 1       #立即数1压栈
        PDAT ffff    #取iarr[1]
        CALL 1 fib   #调用fib函数
        SPOP 0 0 1   #丢弃返回结果
        PUSH 2       #立即数2压栈
        IADD 3       #取farr[2]
        CALL 1 pi    #调用pi函数
        SPOP 0 0 1   #丢弃返回结果     
        PUSH 0       #立即数0压栈
        RETP         #返回值
        

        





