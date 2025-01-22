#!/usr/bin/env python
#coding:utf-8
import os

# 根据文件夹查询项目名
def get_proj_name(dir):
    for file in os.listdir(dir):
        if file.endswith('.xcodeproj'):
           proj_name = os.path.splitext(file)[0]
           return proj_name
    return ''

# 查询项目根目录
def get_root_dir():
    curPath = os.getcwd()
    while (get_proj_name(curPath) == ''):
        curPath = os.path.dirname(curPath)
    return curPath

# 查询项目名和根目录
def proj_name_and_root_dir():
    curPath = os.getcwd()
    while (get_proj_name(curPath) == ''):
        curPath = os.path.dirname(curPath)
    projName = get_proj_name(curPath)
    return (projName, curPath)