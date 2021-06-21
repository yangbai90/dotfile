#!/usr/bin/python3
# -*- coding: utf-8 -*-
"""
@Author  : Dr. Yang Bai
@Date    : 2021.06.21
@Function: Clean the temporary files during the development of pyiron_continuum
"""
import os 
import shutil
import sys

if len(sys.argv)<1:
    sys.exit('Error: no any folder is given!!!')

damask_folder=sys.argv[1]

print('Damask folder is:',damask_folder)

tempfolders=0
modfiles=0;tempfiles=0

for subdir,dirs,files in os.walk(damask_folder):
    if ('.ci_support' in subdir) or ('.github' in subdir):
        continue
    ##########################################
    ### start to clean files
    ##########################################
    for file in files:
        if ('.f90' in file) or ('.f08' in  file) or ('.f03' in file) or ('.py' in file) or ('.yaml' in file) or ('.ico' in file) or ('.png' in file) or ('.svg' in file) or ('LICENSE' in file) or ('COPYRIGHT' in file) or ('.json' in file) or ('Makefile' in file):
            continue
        ########################################
        if ('.mod' in file) and (not '.f90'in file):
            try:
                modfiles+=1
                removepath=subdir+'/'+file
                os.remove(removepath)
            except:
                print('%s is not here'%(file))
        elif ('CMakeCache.txt' in file) or ('cmake_install.cmake' in file):
            try:
                tempfiles+=1
                removepath=subdir+'/'+file
                os.remove(removepath)
            except:
                print('%s is not here'%(file))

    ###########################################
    ### start to remove folders
    ###########################################
    IsIdeaRemove=False;IsPyCacheRemove=False
    IsBuildRemove=False;IsEggRemove=False
    for folder in dirs:
        if '.idea' in folder:
            try:
                tempfolders+=1
                removepath=subdir+'/'+folder
                print('remove folder',folder)
                shutil.rmtree(removepath)
                IsIdeaRemove=True
            except:
                if(not IsIdeaRemove):
                    print('%s is not here'%(folder))
        elif ('build' in folder) or ('dist' in folder) or ('damask.egg-info' in folder):
            try:
                tempfolders+=1
                removepath=subdir+'/'+folder
                print('remove folder',folder)
                shutil.rmtree(removepath)
                IsBuildRemove=True
            except:
                if(not IsBuildRemove):
                    print('%s is not here'%(folder))
        elif ('__pycache__') in folder:
            try:
                tempfolders+=1
                removepath=subdir+'/'+folder
                print('remove folder',folder)
                shutil.rmtree(removepath)
                IsPyCacheRemove=True
            except:
                if(not IsPyCacheRemove):
                    print('%s is not here',folder)
        elif '.egg-info' in folder:
            try:
                tempfolders+=1
                removepath=subdir+'/'+folder
                print('remove folder',folder)
                shutil.rmtree(removepath)
                IsEggRemove=True
            except:
                if(not IsEggRemove):
                    print('%s is not here',folder)
        elif ('CMakeFiles' in folder):
            try:
                tempfolders+=1
                removepath=subdir+'/'+folder
                print('remove folder',folder)
                shutil.rmtree(removepath)
                IsEnvRemove=True
            except:
                if(not IsEggRemove):
                    print('%s is not here'%(folder))

print('remove %d mod  files'%(modfiles))
print('remove %d temp files'%(tempfiles))
print('remove %d temp folders'%(tempfolders))


