import pygrading
from pygrading import Job
from pygrading.verdict import Verdict
from pygrading.html import str2html
import re
import os
import sys


def prework(job: Job):
    """任务预处理函数

    通常用于创建测试用例和创建配置信息

    参数:
        job: 传入的当前任务对象

    返回值:
        返回值为空，预处理内容需要更新到job对象中
    """

    # # 检查测试样例
    # testcase_dir = job.get_config().testcase_dir
    # input_pattern = re.compile(r"input(\d+)\.txt")
    # inputs_num = [input_pattern.findall(x) for x in os.listdir(testcase_dir)]
    # inputs_num = [x[0] for x in inputs_num if len(x) > 0]
    # inputs_src = [os.path.join(testcase_dir, f"input{x}.txt") for x in inputs_num]
    # outputs_src = [os.path.join(testcase_dir, f"output{x}.txt") for x in inputs_num]
    # check_outputs = [x for x in outputs_src if not os.path.exists(x)]
    # if check_outputs:
    #     job.verdict(Verdict.UnknownError)
    #     job.comment(f"测试样例<br/>{'<br/>'.join(check_outputs)}<br/>不存在，请联系管理员。")
    #     job.is_terminate = True
    #     return
    #
    #
    # # 创建测试用例和配置信息
    # testcases = pygrading.create_testcase(100)
    # for i, v in enumerate(zip(inputs_src, outputs_src)):
    #     input_src, output_src = v
    #     testcases.append(name=f"TestCase{i + 1}", score=100 / len(inputs_src), input_src=input_src, output_src=output_src)
    #
    # # 更新测试用例和配置信息到任务
    # job.set_testcases(testcases)


    testcase_dir = job.get_config().testcase_dir
    submit_dir = job.get_config().submit_dir
    # testcase_dir是只读的，所以全复制到submit_dir之下
    pygrading.exec(f"cp -r {testcase_dir}/* {submit_dir}")
    c_dir = os.path.join(submit_dir, 'c')
    c_src = os.path.join(submit_dir, "*.c")

    comment = ""

    # 编译生成两个可执行文件
    zip_path = os.path.join(submit_dir, "src.zip")
    if os.path.exists(zip_path):
        comment += "找到src.zip，进行解压\n"
        pygrading.exec("unzip src.zip")

    assembler_src = os.path.join(submit_dir, "my_assembler_utils.c")
    linker_src = os.path.join(submit_dir, "my_linker_utils.c")

    if not os.path.exists(assembler_src) and not os.path.exists(linker_src):
        job.verdict("Fail")
        job.comment("没有找到my_assembler_utils.c和my_linker_utils.c，两个文件需要至少上传一个")
        job.is_terminate = True
        return
    if not os.path.exists(assembler_src):
        comment += "没有找到my_assembler_utils.c，将使用标准版本代替，得分上限为50%\n"
    elif not os.path.exists(linker_src):
        comment += "没有找到my_linker_utils.c，将使用标准版本代替，得分上限为50%\n"
    else:
        comment += "my_assembler_utils.c和my_linker_utils.c都找到了\n"
    job.get_config()['ratio'] = 0 # 给分比例
    if os.path.exists(assembler_src):
        pygrading.exec(f"cp {assembler_src} {c_dir}")
        job.get_config()['ratio'] += 0.5
    if os.path.exists(linker_src):
        pygrading.exec(f"cp {linker_src} {c_dir}")
        job.get_config()['ratio'] += 0.5
    comment += "进行编译......"
    cp_result = pygrading.exec(f"cp {assembler_src} {linker_src} {c_dir}")
    compile_result = pygrading.exec(f"cd {c_dir} && make")
    if compile_result.returncode != 0 \
        or not os.path.exists(f"{c_dir}/assembler") \
        or not os.path.exists(f"{c_dir}/linker"):
        comment += "出错\n"
        comment += "报错信息为：\n"
        comment += compile_result.stderr
        job.verdict(Verdict.CompileError)
        job.comment(str2html(comment))
        job.is_terminate = True
        return
    comment += "编译成功\n"

    job.get_config()['my_comment'] = comment
    job.get_config()['assembler'] = os.path.join(c_dir, "assembler")
    job.get_config()['linker'] = os.path.join(c_dir, "linker")
    job.get_config()['logisim_dir'] = os.path.join(submit_dir, "logisim")

    # 设定测例
    testcases = pygrading.create_testcase(100)
    cnt = 0
    for file_name in os.listdir(submit_dir):
        full_path = os.path.join(submit_dir, file_name)
        if os.path.isdir(full_path) and file_name[:8] == "testcase":
            testcases.append(
                name=file_name,
                score=100,
                input_src=full_path
            )
            cnt += 1
    job.set_testcases(testcases)
    job.get_config()['testcase_number'] = cnt
    #
    #
    # # 编译提交程序
    # submit_dir = job.get_config().submit_dir
    # sources = [os.path.join(submit_dir, x) for x in os.listdir(submit_dir) if x[-2:] == '.c']
    # if not sources:
    #     job.verdict(Verdict.CompileError)
    #     job.comment("未找到有效的提交文件")
    #     job.is_terminate = True
    #     return
    #
    # run_file = os.path.join(submit_dir, "run")
    # compile_result = pygrading.exec(f"gcc {' '.join(sources)} -o {run_file}")
    # if compile_result.returncode != 0 or not os.path.exists(run_file):
    #     job.verdict(Verdict.CompileError)
    #     job.comment(str2html(compile_result.stderr))
    #     job.is_terminate = True
    #     return
    # job.get_config()["run_file"] = run_file



