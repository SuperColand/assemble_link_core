# 汇编链接器实验的评测核

> 此评测核由lyh和wzx于2022年11月共同完成，
> 
> lyh负责评测逻辑和Logisim CPU的设计；
> 
> wzx对Logisim 2.16版本进行了修改，使其在命令行评测时可以输出内存内容。
> 
> 李宇衡 liyuheng55555@126.com 2023年1月16日

## 评测核工作过程

评测核的输入为学生编写的汇编器、链接器C代码源文件，经过4个步骤的评测，验证代码的正确性：
1. 使用gcc，将C文件编译成可执行的汇编器、链接器。
2. 使用汇编器、链接器，处理测试用例中的汇编代码，得到机器码。
3. 将机器码输入Logisim CPU，运行直到停机。
4. 读取Logisim中ram的内容。

如果ram内容符合预期，则说明汇编器、链接器编写正确。

## 评测核结构

评测核依托于希冀提供的pygrading包进行编写，按照包的要求，分成prework、run、postwork三部分：
1. prework是最先执行的，只执行一次，prework中会做：
   1. 检查源文件是否被上传
   2. 进行编译
   3. 设定测例
2. run是随后执行的，针对每个测例会进行一次run，每次run会做：
   1. 对测例中的汇编文件，进行汇编和链接，得到机器码
   2. 将机器码输入Logisim CPU，运行直到停机 
   3. 分析Logisim输出的内容，知晓停机原因和内存数据
   4. 将内存数据与测例中的预期结果进行比对，判定是否通过本测例
3. postwork是最后执行的，只执行一次，postwork中会做：
   1. 统计最终得分
   2. 生成反馈页面

## 测试文件结构

涉及到测试的文件都位于`test/p4/testdata`文件夹下：
- c文件夹：包含编译步骤中所需的的c文件、头文件、Makefile、静态链接库文件
- logisim文件夹：包含Logisim程序、用logisim绘制的cpu、cpu所引用的mips反汇编探针
- 若干个以`testcase`开头的测例文件夹，其结构为
  - assemble文件夹：本测例的汇编代码文件，测试中会将
  - example.txt：本测例的预期内存结果
  - judge.sh：本测例的评测指令，每个测例的这个文件只有-ram选项有区别
- 如果有其它东西存在，大概是没用的，删掉吧

这些东西都可以在希冀的终端上进行配置，而不需要修改评测核

## 报错

考虑到评测过程比较复杂，评测核提供了较为详尽的报错机制，包括：
1. 允许只上传汇编器或链接器C代码（此时最多得到50%分数），但不允许二者都没上传
2. 编译过程出错，此时会给出gcc的错误信息
3. 汇编某个文件时出错
4. 链接全部文件时出错
5. logisim载入机器码出错
6. logisim没有正常停机
7. 内存结果出错

## 其它需要说明的

`打包内核`会生成kernel.pyz文件，也就是真正可执行的评测内核

assemble_link_core_onclass是课上使用的评测内核，和本内核相比修改了一点点：
- 必须仅上传汇编器c文件
- 降低了logisim cpu运行步数限制（因为课上评测机压力较大，运行得比平时慢）

# 一些编写评测核的常用指令

## 构建Docker镜像
```shell
python manage.py docker-build
```

## 导出Docker镜像
```shell
python manage.py docker-save
```

## 打包内核

```shell
python manage.py package
```

## 测试

```shell
python manage.py test
```
