#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
@author: livenowhy
@contact: liuzhangpei@126.com
"""


import sys
import os

directory = os.getcwd()

ignore_path = ['易经', '.git']
def get_all_path(path=directory):
    path_list = []
    all_file = os.listdir(path)
    for filename in all_file:
        if os.path.isdir(filename):
            if filename not in ignore_path:
                path_list.append(filename)

    return path_list

def get_path_all_md(path):
    """
    获取一个路径下全部md文件并且按照
    名称编号排序
    title: 取md文件第一行内容 去除 ## 
    """
    all_md_files = os.listdir(path)
    md_dict = {}
    path_begin = os.path.dirname(path)
    begin = os.path.relpath(path, directory)
    for filename in all_md_files:
        file_path = os.path.join(path, filename)
        if os.path.isfile(file_path) and file_path.endswith('.md'):
            with open(file_path, 'r') as fp:
                top_line = fp.readline().replace('\n', '').replace('## ', '')
                node = {
                        'title': top_line,
                        'filepath': begin + os.sep + filename 
                        }
                index = filename.split('_')[0]
                md_dict[index] = node
    md_dict = dict(sorted(md_dict.items(), key=lambda x: x[0]))
    lines = ['* '+begin]
    for k, v in md_dict.items():
        line = "  * [{title}]({filepath})".format(title=v['title'], filepath=v['filepath'])
        lines.append(line)
    lines_str = '\n'.join(lines)

    return lines_str

def make_summary_fime():
    """
    创建 summary 文件
    """
    summary = """# Summary

## 个人日常笔记

* [Introduction](README.md)

{node}
"""

    path_list = get_all_path(path=directory)

    lines_str = ''
    for pathname in path_list:
        path = os.path.join(directory, pathname)
        line_str = get_path_all_md(path)
        lines_str += line_str
        lines_str += '\n\n' 
    summary = summary.format(node=lines_str)

    with open('SUMMARY.md', 'w') as fp:
        fp.write(summary)

if __name__ == '__main__':
    make_summary_fime()
