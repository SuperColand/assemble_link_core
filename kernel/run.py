import pygrading
import os
from pygrading import Job, TestCases
from pygrading.verdict import Verdict
from pygrading.html import str2html

# 顶层模块的输出引脚的 (含义,位宽,是否为16进制)，按引脚顺序排列
output_bits = [
    ('pc', 32, True),
    ('inst', 32, True),
    ('reg_write', 1, False),
    ('reg_addr', 5, False),
    ('reg_data_in', 32, True),
    ('mem_write', 1, False),
    ('mem_addr', 10, True),
    ('正常停机', 1, False),
    ('无法解析的指令', 1, False),
    ('除0异常', 1, False),
    ('运行步数太多', 1, False),
    ('count', 32, False),
]

def parse_one_line(line):
    '''
    根据output_bits，对output.txt的一行进行解析
    '''
    assert isinstance(line, str)
    result = {}
    idx = 0
    for pair in output_bits:
        name = pair[0]
        length = pair[1]
        need_hex = pair[2]
        val = 0
        old_idx = idx
        for i in range(length):
            while line[idx] == ' ' or line[idx] == '\t':
                idx += 1
            val *= 2
            if line[idx] == '1':
                val += 1
            idx += 1
        # print(name + ":" + line[old_idx:idx])
        result[name] = val
        if need_hex:
            result[name] = hex(val)
    return result

def run(job: Job, case: TestCases.SingleTestCase) -> dict:
    """任务执行函数

    用于执行测试用例

    参数:
        job: 传入的当前任务对象
        case: 单独的测试用例对象

    返回值:
        result: 测试用例执行结果字典，该结果会被汇总到job对象的summary对象中
    """

    # 创建一个结果对象
    result = {"name": case.name, "score": 0, "verdict": "", "output":""}
    # run_file = job.get_config()['run_file']

    # input_str = open(case.input_src).read()
    # 执行评测任务命令
    # exec_result = pygrading.exec(run_file, input_str=input_str)
    # output_str = open(case.output_src).read()

    # if pygrading.utils.compare_str(exec_result.stdout, output_str):
    #     result["score"] = case.score
    #     result["verdict"] = Verdict.Accept

    # assembler、linker、库文件 复制到包含汇编文件的目录下
    submit_dir = job.get_config().submit_dir
    assembler_path = job.get_config()['assembler']
    linker_path = job.get_config()['linker']
    libP4_path = os.path.join(submit_dir, "c", "libP4.a")
    testcase_dir = case.input_src
    assemble_dir = os.path.join(testcase_dir, 'assemble')
    pygrading.exec(f"cp {libP4_path} {assembler_path} {linker_path} {assemble_dir}")

    message = ""

    # 对assemble目录下所有asm文件进行汇编，然后全部链接起来
    cnt = 1
    asm_success = True
    # 遍历asm文件，同时构造链接指令
    link_instruction = "./linker main.out "
    for f in os.listdir(assemble_dir):
        if len(f) >= 5 and f[-4:] == ".asm":
            f_name = f[:-4]
            asm_result = pygrading.exec(f"cd {assemble_dir} && ./assembler {f_name}.asm {f_name}.int {f_name}.out")
            if asm_result.returncode == 0:
                message += f"文件{f}汇编成功......"
            else:
                message += f"文件{f}汇编失败......"
                asm_success = False
            if f_name != "main":
                link_instruction += f_name + ".out "
    link_instruction += "main.o"
    # 检查汇编结果
    if not asm_success:
        message += "存在文件汇编失败的情况，测试停止"
        result["output"] = message
        return result
    # 链接
    message += "文件全部汇编成功，进行链接......"
    link_result = pygrading.exec(f"cd {assemble_dir} && {link_instruction}")
    if link_result.returncode != 0:
        message += "链接失败，测试停止"
        result["output"] = message
        return result
    message += "链接成功......"

    # logisim运行测试
    logisim_dir = os.path.join(submit_dir, 'logisim')
    # main.o复制到logisim目录下
    cp_result = pygrading.exec(f"cp {assemble_dir}/main.o {logisim_dir}")
    if cp_result.returncode != 0:
        message += "没有找到生成的机器码文件......"
        result["output"] = message
        return result
    message += "机器码已生成......"
    pygrading.exec(f"cd {logisim_dir} && echo \"v2.0 raw\" >input.txt && cat main.o >>input.txt")
    message += "在logisim cpu中运行机器码......"
    # 获取logisim评测指令
    logisim_judge_inst_path = os.path.join(testcase_dir, "judge.sh")
    with open(logisim_judge_inst_path) as f:
        judge_inst = f.readline()
    java_result = pygrading.exec(f"cd {logisim_dir} && {judge_inst}")
    if java_result.returncode != 0:
        message += "运行出错，错误信息为" + java_result.stderr
        result['output'] = message
    message += "成功，对结果进行分析......"

    # 分析logisim运行结果
    output_file = os.path.join(logisim_dir, "output.txt")
    pygrading.exec(f"cp {output_file} {testcase_dir}")
    ram_data = []
    last_pin_line = ""
    with open(output_file, "r") as f:
        while True:
            line = f.readline()
            if line == "":
                break
            if len(line) >= 50:
                last_pin_line = line
            if len(line) < 50: # output文件由若干行引脚数据+若干行内存数据构成，如果比较短就说明是内存数据
                ram_data.append(line)
    # final_result = pygrading.exec(f"cat {logisim_dir}/output.txt")
    pin = parse_one_line(last_pin_line)
    run_message = ""
    if pin['无法解析的指令'] == 1:
        run_message += f"异常停机：指令{pin['inst']}无法被解析"
    elif pin['除0异常'] == 1:
        run_message += f"异常停机：指令{pin['inst']}中除数为0"
    elif pin['运行步数太多'] == 1:
        run_message += f"异常停机：运行步数达到{pin['count']}，超出限制"
    if run_message != "":
        result["output"] = message + run_message
        return result
    message += "正常停机，比对RAM内容......"
    # 比对内存结果
    example_path = os.path.join(testcase_dir, "example.txt")
    with open(example_path, "r") as f:
        for ram_line in ram_data:
            f_line = f.readline()
            # message += ram_line + " vs " + f_line + "......"
            if ram_line != f_line:
                message += "RAM内容和预期不一致"
                result['output'] = message
                return result
    message += "RAM内容与预期一致，测试通过"
    result['output'] = message
    result['score'] = 100 * job.get_config()['ratio']
    result['verdict'] = Verdict.AC
    return result
