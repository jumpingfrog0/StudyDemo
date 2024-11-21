#!/usr/bin/env python
#-*- coding: utf-8 -*-
"""
文件名称: xcodebuild analyze
描述: 编译耗时分析。
"""

import os
import re
import subprocess
import file_utils

def main():
    cur_path = os.getcwd()
    print(cur_path)

    root_dir = file_utils.get_root_dir()
    print(root_dir)

    # 切换到Buz主工程目录
    os.chdir(root_dir)
    cur_work_dir = os.getcwd()
    print('切换到Buz主工程目录：' + cur_work_dir)

    build_log = "build3.log"
    build_output_path = os.path.join(cur_path, build_log)
    run_xcodebuild_command(build_output_path)

    # 切换到Scripts工作目录
    os.chdir(cur_path)
    cur_work_dir = os.getcwd()
    print('切换到Scripts工作目录：' + cur_work_dir)

    awk_output_path = os.path.join(cur_path, "slowest.log")
    # run_awk_command(build_log, awk_output_path)

def test(output_file_path):
    # 定义shell命令
    command = r"""
    ls | tee {}
    """.format(output_file_path)

    os.system(command)

def run_xcodebuild_command(output_file_path):
    # 定义shell命令
    # command = r"""
    # xcodebuild \
    #     clean build \
    #     -workspace SwiftDemo.xcworkspace \
    #     -scheme SwiftDemo \
    #     -configuration Debug \
    #     -sdk iphonesimulator \
    #     OTHER_SWIFT_FLAGS="-driver-time-compilation \
    #     -Xfrontend -debug-time-function-bodies \
    #     -Xfrontend -debug-time-compilation" | \
    # tee {}
    # """.format(output_file_path)

    # command = r"""
    # xcodebuild \
    #     clean build \
    #     -workspace SwiftDemo.xcworkspace \
    #     -scheme SwiftDemo \
    #     -configuration Debug \
    #     -sdk iphonesimulator \
    #     -showBuildTimingSummary | xcpretty | gnomon -i | tee build4.log
    # """

    command = r"""
    xcodebuild \
        clean build \
        -workspace SwiftDemo.xcworkspace \
        -scheme SwiftDemo \
        -configuration Debug \
        -sdk iphonesimulator \
        -showBuildTimingSummary | xcpretty | gnomon -i
    """

    full_command = f"({command}) | tee {output_file_path}"

    process = subprocess.Popen(full_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    # 获取命令的输出和错误信息
    stdout, stderr = process.communicate()

    if process.returncode == 0:
        print("Command executed successfully.")
    else:
        print(f"Error executing command: Exit status {process.returncode}")

    print(stdout)

    # command = r"""
    # xcodebuild \
    #     clean build \
    #     -workspace SwiftDemo.xcworkspace \
    #     -scheme SwiftDemo \
    #     -configuration Debug \
    #     -sdk iphonesimulator \
    #     -showBuildTimingSummary | xcpretty | gnomon -i | \
    # tee {}
    # """.format(output_file_path)

    # exit_status = os.system(command)
    # print(exit_status)
    # print("--------------")
    # if exit_status == 0:
    #     print("** BUILD SUCCEEDED **")
    # else:
    #     print("** BUILD FAILED **")


def run_awk_command(build_log, output_file_path):

    print(build_log)
    print(output_file_path)

    # 定义shell命令
    # command = r"""
    # awk '/Driver Compilation Time/,/Total$/ { print }' build2.log | \
    # grep compile | \
    # cut -c 55- | \
    # sed -e 's/^ *//;s/ (.*%)  compile / /;s/ [^ ]*Bridging-Header.h$//' | \
    # sed -e "s|$(pwd)/||" | \
    # sort -rn | \
    # tee {}
    # """.format(output_file_path)

    command = r"""
    awk '/Driver Compilation Time/,/Total$/ { print }' build2.log | \
    grep compile | \
    cut -c 55- | \
    sed -e 's/^ *//;s/ (.*%)  compile / /;s/ [^ ]*Bridging-Header.h$//' | \
    sed -e "s|$(pwd)/||" | \
    sort -rn | \
    tee slowest.log
    """

    # os.system(command)

    exit_status = os.system(command)
    print("--------------")
    if exit_status == 0:
        print("** awk SUCCEEDED **")
    else:
        print("** awk FAILED **") 

def run_common_demo():
    # 定义shell命令
    command = r"""
    awk '/Driver Compilation Time/,/Total$/ { print }' profile.log | \
    grep compile | \
    cut -c 55- | \
    sed -e 's/^ *//;s/ (.*%)  compile / /;s/ [^ ]*Bridging-Header.h$//' | \
    sed -e "s|$(pwd)/||" | \
    sort -rn | \
    tee slowest.log
    """

    # 使用subprocess.Popen来运行命令
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    # 获取命令的输出和错误信息
    stdout, stderr = process.communicate()

    # 输出或保存stdout中的内容
    print(stdout)

    # 检查命令是否成功执行
    if process.returncode == 0:
        print("awk Command executed successfully.")
    else:
        print(f"Error executing awk command: {stderr}")


if __name__ == "__main__":
    main()