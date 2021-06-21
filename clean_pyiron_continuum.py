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

pyiron_continuum_folder=sys.argv[1]

print('PyIron folder is:',pyiron_continuum_folder)

tempfolders=0;logfiles=0;tempfiles=0

for subdir,dirs,files in os.walk(pyiron_continuum_folder):
    if ('.ci_support' in subdir) or ('.github' in subdir):
        continue
    ##########################################
    ### start to clean files
    ##########################################
    for file in files:
        if '.log' in file:
            try:
                tempfiles+=1
                logfiles+=1
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
        elif ('build' in folder) or ('dist' in folder):
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
        elif ('env' in folder):
            try:
                tempfolders+=1
                removepath=subdir+'/'+folder
                print('remove folder',folder)
                shutil.rmtree(removepath)
                IsEnvRemove=True
            except:
                if(not IsEggRemove):
                    print('%s is not here'%(folder))

print('remove %d temp files'%(tempfiles))
print('remove %d temp folders'%(tempfolders))


