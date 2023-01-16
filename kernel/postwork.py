import pygrading

from pygrading import Job
from pygrading.html import str2html


def postwork(job: Job) -> dict:
    """任务后处理函数

    用于汇总测试执行结果

    参数:
        job: 传入的当前任务对象

    返回值:
        返回值为空，后处理内容需要更新到job对象中
    """

    # 获取执行结果总分
    total_score = job.get_total_score()

    # 更新结果输出字段
    number = job.get_config()['testcase_number']
    job.get_config()['my_comment'] += "测试点数量为" + str(number)
    job.get_config()['my_comment'] += "，每个测试点100分，你的得分为" + str(total_score) + "\n"

    job.verdict("满分" if total_score == 100*number else "非满分")
    score = round(total_score/(100 * number) * 100)
    job.score(score)
    job.comment(str2html(job.get_config()['my_comment']))
    # job.comment("Mission Complete")
    summary = job.get_summary()
    # job.comment(gg.render_template("comment.html", summary=summary))

    # 渲染 HTML 模板页面（可选）
    # 被渲染的页面应位于 kernel/templates/html 目录下
    job.detail(pygrading.render_template("detail.html", summary=summary))
