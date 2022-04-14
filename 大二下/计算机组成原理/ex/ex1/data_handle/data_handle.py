

def switch_dict(func, data):
    s = data[0]
    I_type = 'imm:' + s[20:32][::-1] + ' funct3:' + s[12:15][::-1] + ' rs1:' + s[15:20][::-1] + ' rd:' + s[7:12][::-1] + ' opcode:' + s[0:7][::-1]
    R_type = 'funct7:' + s[25:32][::-1] + ' func3:' + s[12:15][::-1] + ' rs1:' + s[15:20][::-1] + ' rs2:' + s[20:25][::-1] + ' opcode:' + s[0:7][::-1]
    S_type = 'imm:' + (s[7:12] + s[25:32])[::-1] +' funct3:' + s[12:15][::-1] + ' rs1:' + s[15:20][::-1] + ' rs2:' + s[20:25][::-1] + ' opcode:' + s[0:7][::-1]
    U_type = "imm:" + s[12:32][::-1] + " rd:" + s[7:12][::-1] + " opcode:" + s[0:7][::-1]
    B_type = "imm:" + (s[8:12]+s[25:31]+s[12]+s[31])[::-1] + " funct3:" + s[12:15][::-1] + " rs1:" + s[15:20][::-1] + ' rs2:' + s[20:25][::-1] + 'opcode: ' + s[0:7][::-1]
    J_type = "imm:" + (s[21:31]+s[20]+s[12:20]+s[31])[::-1] + " rd:" + s[7:12][::-1] + " opcode:" + s[0:7][::-1]
    return{
        'sw': S_type, 'sd': S_type,'li': U_type,'lw': I_type,'ld': I_type,
        'andi': I_type,'sraiw': I_type,'addi': I_type,'bge': B_type,
        'sext.w': I_type,'slliw': I_type,'lui': U_type,'mv': I_type,
        'auipc': U_type,'jalr': I_type,'ori': I_type,'slli': I_type,
        'beq': B_type,'bne': B_type,'blt': B_type,'jal': J_type,'add': R_type,
        'sub': R_type,'xor': R_type,'or': R_type,'and': R_type,'sll': R_type,
        'srl': R_type,'sra': R_type,'slt': R_type,'xori':I_type,'srli':I_type,
        'srai': I_type,'slti': I_type,'sltiu':I_type,'lb':I_type,'lh':I_type,
        'lbu': I_type,'lhu': I_type,'sb':S_type,'sh':S_type,'bltu': B_type,
        'bgeu': B_type,'ecall': I_type,'ebreak': I_type
    }.get(func, "Sorry! The instruction can't be found in risc-v instruction sets, please google it")

def main():
    result = []
    # data.txt is the file by disassembly
    # you need to create the file in example.txt format
    with open('data.txt','r') as r:
        data = r.read().split('\n')
        for i in data:
            result.append(i.split(':')[-1])
    data1 = []
    data2 = []
    for item in result:
        data1.append(item.strip('\t').split()[0])
        data2.append(item.strip('\t').split()[1])
    dict = {
        '0': '0000', '1': '0001', '2': '0010', '3': '0011',
        '4': '0100', '5': '0101', '6': '0110', '7': '0111',
        '8': '1000', '9': '1001', 'a': '1010', 'b': '1011',
        'c': '1100', 'd': '1101', 'e': '1110', 'f': '1111',
    }
    data3 = []
    for item in data1:
        temp = ""
        for i in item:
            temp += dict[i]
        data3.append(temp)

    data = []
    for i in range(len(data1)):
        data.append((data3[i][::-1], data2[i]))

    ans = []
    for i in range(len(data)):
        if len(data[i][0]) == 32:
            temp = switch_dict(data[i][1], data[i])
            ans.append(data3[i] + " " + temp)
        else:
            ans.append(data3[i] + " Sorry!Please check the 16-bit instructions yourself")
    for i in ans:
        print(i)
    # output.txt is the result you want maybe
    with open("output.txt", 'w') as w:
        for item in ans:
            w.write(item)
            w.write('\n')


if __name__ == '__main__':
    main()
