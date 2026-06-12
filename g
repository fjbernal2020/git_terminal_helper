#!/usr/bin/python3
# -*- coding: utf-8 -*-

#  Copyright 2015 andreas <andreas_tsu@riseup.net>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

import sys
import os
import readline

try:
    #from colorama import Fore, Back, Style
    from colorama import Fore #, Back, Style
    tcolor = True
except:
    print('colorama not found, no color will be used')
    tcolor = False
    sys.exit(1)
#------------------------
def rlinput(prompt, prefill=''):
    readline.set_startup_hook(lambda: readline.insert_text(prefill))
    try:
        return input(prompt)
    finally:
        readline.set_startup_hook()
#------------------------
def execs_defaults():
    '''
    Default pairs of key:command used in this script
    '''
    return {
        '.':     {'aka': '.',     'hlp': '>>> .          : repeat last command'},
        's':     {'aka': 's',     'hlp': '>>> s          : status'},
        'a':     {'aka': 'a',     'hlp': '>>> a [n\.]    : add file nº.n / add .'},
        't':     {'aka': 't',     'hlp': '>>> t message  : commit -m'},
        'ta':    {'aka': 'ta',    'hlp': '>>> ta message : commit -am'},
        'tap':   {'aka': 'tap',   'hlp': '>>> tap message: commit -am + push'},
        'f':     {'aka': 'f',     'hlp': '>>> f          : fetch'},
        'm':     {'aka': 'e',     'hlp': '>>> m          : merge'},
        'l':     {'aka': 'l',     'hlp': '>>> l          : pull'},
        'p':     {'aka': 'p',     'hlp': '>>> p          : push'},
        'g':     {'aka': 'g',     'hlp': '>>> g          : graphic log'},

        'b':     {'aka': 'b',     'hlp': '>>> b          : list branches'},
        'c':     {'aka': 'c',     'hlp': '>>> c          : change to branch'},
        'n':     {'aka': 'n',     'hlp': [
                                         '>>> n          : list branches',
                                         '>>> n [branch] : make new branch',
                                        ]},

        'ba':    {'aka': 'ba',    'hlp': '>>> git branch -avvv'},
        'c':     {'aka': 'c',     'hlp': '>>> git checkout [nueva rama] [desde n rama]'},
        'cf':    {'aka': 'cf',    'hlp': '>>> git checkout -f'},


        'ep':    {'aka': 'ep',    'hlp': '>>> git merge && git push'},

        'la':    {'aka': 'la',    'hlp': '>>> git pull -all'},
        'n':     {'aka': 'n',     'hlp': '>>> git switch [-c new branch], list branches if no new branch'},
        'o':     {'aka': 'o',     'hlp': '>>> git log'},

        'pa':    {'aka': 'pa',    'hlp': '>>> git push --all'},
        'po':    {'aka': 'po',    'hlp': '>>> git push origin'},
        'pu':    {'aka': 'pu',    'hlp': '>>> git push --set-upstream origin'},
        'w':     {'aka': 'w',     'hlp': '>>> git show'},
        'rw':    {'aka': 'rw',    'hlp': '>>> git remote show origin'},

        'h':     {'aka': 'h',     'hlp': '>>> git stash save [comment]'},
        'hw':    {'aka': 'hw',    'hlp': '>>> git stash show [id]'},
        'hp':    {'aka': 'hp',    'hlp': '>>> git stash pop [id]'},
        'ha':    {'aka': 'ha',    'hlp': '>>> git stash apply [id]'},
        'ho':    {'aka': 'ho',    'hlp': '>>> git stash drop [id]'},
        'hb':    {'aka': 'hb',    'hlp': '>>> git stash branch'},
        'hl':    {'aka': 'hl',    'hlp': '>>> git stash list'},
        'hr':    {'aka': 'hr',    'hlp': '>>> git stash clear'},

        'note':  {'aka': 'note',  'hlp': '>>> open program with notes or adds a note to g_notes'},
        'help':  {'aka': 'help',  'hlp': '>>> print help'},
        'ls':    {'aka': 'ls',    'hlp': '>>> list files in current folder'},
        'cd':    {'aka': 'cd',    'hlp': '>>> change current folder to new folder'},
        'nano':  {'aka': 'nano',  'cmd': 'nano', 'hlp': '>>> list files and open nano with one of them, write here the command of the program to launch'},
        'tutor': {'aka': 'tutor', 'hlp': '>>> launch the tutor-guide, write here the name of the python program'},
        'execs': {'aka': 'execs', 'hlp': '>>> write keys used to g_keys file, so keys can be changed'},
        'aexec': {'aka': 'aexec', 'hlp': '>>> add a key and a command to launch with git from here'},
        'rexec': {'aka': 'rexec', 'hlp': '>>> remove a key and a command from the user list of commands'},
        'reset': {'aka': 'reset', 'hlp': '>>> checkout -- file for modified files or reset HEAD file for new files'},
    }
#------------------------
def read_execs():
    '''Read the default keys commands'''
    try:
        data = {}
        with open('%s_keys' % comands[0], 'r') as f:
            data = {line.split(':')[0].strip(): {'aka': line.split(':')[1].strip(), 'hlp': line} for line in f if line and not line.startswith('#')}
        return data
    except:
        return execs_defaults()
#------------------------
def write_gkeys():
    with open('%s_keys' % comands[0], 'w') as f:
        f.write('''#File for changing the letters used to name functions to call git
#format <a> : <b> : comment so typing 'b' you will call 'a' function.
#Nano is special, you can specify your own editor in 'cmd' field
#You can use blank lines, lines starting with # for comments or
#spaces between letters, but they must be separated by one ':'
#don't change them, the defaults are hardcoded in the script\n\n''')
        keys_sorted = sorted(execs.keys())
        for key in keys_sorted:
            f.write('{0:<5}: {1:<5}: {2}\n'.format(key, execs[key]['aka'], execs[key]['hlp']))
#------------------------
def write_execs():
    '''
    Write key:command pairs to file
    '''
    if os.path.isfile('%s_keys' % comands[0]):
        confirm = input('The file already exists, overwrite it? ')
        if confirm.upper() == 'S':
            write_gkeys()
    else:
        write_gkeys()
#------------------------
def add_exec(coms):
    if len(coms) > 4:
        uexecs[coms[2]] = ' '.join(coms[3:])
        print('%s: %s %s' % (pcolor(coms[2], Fore.YELLOW), uexecs[coms[2]], pcolor('added to user execs keys', Fore.BLUE)))
        write_uexecs()
    elif len(coms) > 2:
        data = rlinput('git command: ')
        if data:
            uexecs[coms[2]] = data
            print('%s: %s %s' % (pcolor(coms[2], Fore.YELLOW), uexecs[coms[2]], pcolor('added to user execs keys', Fore.BLUE)))
            write_uexecs()
        else:
            print('aexec key git_command')
    else:
        data = input('key: ')
        if data:
            data2 = rlinput('git command: ')
            if data2:
                uexecs[data] = data2
                write_uexecs()
                print('%s: %s %s' % (pcolor(data, Fore.YELLOW), data2, pcolor('added to user execs keys', Fore.BLUE)))
            else:
                print('aexec key git_command')
        else:
            print('aexec key git_command')
#------------------------
def rem_exec(coms):
    if len(coms) > 2 and coms[2] in uexecs:
        print('%s: %s %s' % (coms[2], uexecs[coms[2]], pcolor('removed', Fore.RED)))
        del uexecs[coms[2]]
    else:
        data = input('key: ')
        if data:
            print('%s: %s %s' % (coms[2], uexecs[coms[2]], pcolor('removed', Fore.RED)))
            del uexecs[coms[2]]
        else:
            print('rexec key')
#------------------------
def read_uexecs():
    data = {}
    try:
        with open('%s_ukeys' % comands[0], 'r') as f:
            data = {line.split(':')[0].strip(): line.split(':')[1].strip() for line in f if line.strip()}
            #~ for line in f:
                #~ if line:
                    #~ key = line.split(':')[0].strip()
                    #~ value = line.split(':')[1].strip()
                    #~ data[key] = value
    except:
        pass
    return data
#------------------------
def write_uexecs():
    keys_sorted = uexecs.keys()
    keys_sorted = sorted(keys_sorted)
    with open('%s_ukeys' % comands[0], 'w') as f:
        for key in keys_sorted:
            f.write('{0:<5}: {1}\n'.format(key, uexecs[key]))
#------------------------
def show_help():
    keys_sorted = execs.keys()
    keys_sorted = sorted(keys_sorted)
    for key in keys_sorted:
        print('{0:<5}: {1:<5}: {2}'.format(key, execs[key]['aka'], execs[key]['hlp']))
    if uexecs:
        print('User commands:')
    keys_sorted = uexecs.keys()
    keys_sorted = sorted(keys_sorted)
    for key in keys_sorted:
        print('{0:<5}: {1}'.format(key, uexecs[key]))
#------------------------
def header(git_description, rama_actual=0, clear=True):
    if clear:
        os.system('clear')
    print(pcolor('Git Terminal Helper', Fore.CYAN), end='')
    print(pcolor('--->', Fore.RED), end='')
    print(pcolor('Type \'help\' for options or \'tutor\' for a tour-guide', Fore.GREEN))
    print(pcolor('%s' % git_description, Fore.YELLOW))
    if clear:
        print(pcolor('Path: %s' % os.getcwd(), Fore.GREEN))
        os.system('git status|grep "En la rama"|sed "s/En la rama/En la rama %s%s%s/g"' % (pcolor('[', Fore.RED), pcolor(rama_actual + 1, Fore.GREEN), pcolor(']', Fore.RED)))
#------------------------
def is_git_repo():
    apath = os.getcwd()
    if os.path.isdir('%s/%s' % (apath, '.git')):
        return check_desc('%s/%s' % (apath, '.git'))
    else:
        pat = apath.split('/')
        del pat[0]
        for i in range(len(pat)):
            if os.path.isdir('/%s/%s' % ('/'.join(pat[:-i]), '.git')):
                return check_desc('/%s/%s' % ('/'.join(pat[:-i]), '.git'))
    return ''
#------------------------
def check_desc(path2git):
    if os.path.isfile('%s/description' % path2git):
        with open('%s/description' % path2git, 'r') as f:
            desc = f.readline().strip()
        if desc.startswith('Unnamed'):
            desc = get_desc(path2git)
        return desc
    else:
        return get_desc(path2git)
#------------------------
def get_desc(path2git):
    desc = rlinput('Type a description for the repository: ')
    with open('%s/description' % path2git, 'w') as f:
        f.write(desc)
    # git remote add master origin ????
    return desc.strip()
#------------------------
def limita(data):
    return data[:ancho]
#------------------------
def leer_ramas(git_ramas_file, show_remote=False):
    if show_remote:
        os.system('git branch -avvv > %s' % git_ramas_file)
    else:
        os.system('git branch -vvv > %s' % git_ramas_file)
    local = []
    remote = []
    rama_actual = 0
    with open(git_ramas_file, 'r') as f:
        for line in f:
            if not line.strip().startswith('remotes'):
                local.append(line.strip())
                if line.startswith('*'):
                    rama_actual = len(local) - 1
            else:
                remote.append(line.strip())
    if not local:
        local.append('* master')
    return local, remote, rama_actual
#------------------------
def print_ramas(git_ramas_file, show_remote=False):
    local, remote, rama_actual = leer_ramas(git_ramas_file, show_remote)
    indice = 0
    ancho = int(os.popen('stty size', 'r').read().split()[1])
    espacio = len(str(len(local)))          #para disponer más espacios si hay más de 9 ramas
    for rama in local:
        indice += 1
        if rama.startswith('*'):
            print('%s%s' % (pcolor(indice, Fore.YELLOW), pcolor(rama.replace('* ', '*')[:ancho-len(str(indice))], Fore.GREEN)))
        else:
            print('%s %s' % (pcolor(indice, Fore.YELLOW), rama[:ancho-len(str(indice))-1]))
    if show_remote:
        for rama in remote:
            print(pcolor('  %s' % rama[:ancho-len(str(indice))-1], Fore.RED))
#------------------------
def print_files(print_out=True):
    if print_out:
        print('%s [%s]' % (pcolor('>>> list files', Fore.RED), os.getcwd()))
    nombres = os.listdir('.')
    fichs = []
    folds = []
    indice = 0
    for nombre in nombres:
        if not nombre.startswith('.'):
            if os.path.isfile(nombre):
                fichs.append(nombre)
            elif os.path.isdir(nombre):
                folds.append(nombre)
            else:
                print('Neither file nor folder: %s' % nombre)
    if print_out:
        for fich in fichs:
            indice += 1
            print('%s %s' % (pcolor(indice, Fore.YELLOW), fich))
        for fold in folds:
            indice += 1
            print('%s %s' % (pcolor(indice, Fore.YELLOW), pcolor('%s/' % fold, Fore.RED)))
    return fichs, folds
#------------------------
def print_status(gpath, print_out=True):
    indice = 0
    sec = ('*', 'r', 'c', 'a')
    status_list = {x: {} for x in sec}
    os.system('git status>%s_status' % gpath)
    with open('%s_status' % gpath, 'r') as f:
        lines = f.readlines()
    now = ''
    for line in lines:
        if line.startswith('\t'):
            indice += 1
            if now == 'r':
                linea = line.split(':')[1].strip()
                status_list[now][str(indice).strip()] = linea
            elif now == 'c':
                linea = line.split(':')[1].strip()
                status_list[now][str(indice).strip()] = linea
            elif now == 'a':
                linea = line.strip()
                status_list[now][str(indice).strip()] = linea
            else:
                linea = line.strip()
            status_list['*'][str(indice).strip()] = linea
            if print_out:
                if 'new file:' in line:
                    print('\t%s %s' % (pcolor(indice, Fore.YELLOW), pcolor(line.strip(), Fore.GREEN)))
                else:
                    print('\t%s %s' % (pcolor(indice, Fore.YELLOW), pcolor(line.strip(), Fore.RED)))
        elif print_out:
            print(line.strip())
        if 'git reset' in line:
            now = 'r'
        elif 'git add' in line:
            a1 = lines.index(line) + 1
            if a1 < len(lines) and 'git checkout' in lines[a1]:
                now = 'c'
            else:
                now = 'a'
    return status_list
#------------------------
def pcolor(txt, color):
    if tcolor:
        return '%s%s%s' % (color, txt, Fore.RESET)
    else:
        return txt
#------------------------
def exe(orden):
    print(pcolor('>>> %s' % orden, Fore.RED))
    os.system(orden)
#------------------------
def wat_exe(coms):
    gpath = coms[0]
    txtpath = '%s_ramas' % gpath
    notes = '%s_notes' % gpath
    orden = coms[1]
    ramas, remotes, rama_actual = leer_ramas(txtpath)
    header(is_git_repo(), rama_actual)
    ancho = int(os.popen('stty size', 'r').read().split()[1])
    print(pcolor('>>> %s' % ' '.join(coms[1:]), Fore.CYAN))
    #------------------------
    if orden.isdigit():
        if int(orden) > 0 and int(orden) <= len(ramas):
            if int(orden) - 1 == rama_actual:
                print(limita(ramas[rama_actual]))
                print(pcolor('Ya estás en ese branch, nothing to do...', Fore.RED))
            else:
                rama_actual = int(orden) - 1
                exe('git checkout %s' % ramas[rama_actual].split(' ')[0])
                wat_exe(('%s %s' % (comands[0], execs['s']['aka'])).split(' '))
        else:
            print('El número de rama es incorrecto')
    #---------------
    elif orden == execs['a']['aka'] and len(coms) > 2:
        status_list = print_status(coms[0], False)
        for item in coms[2:]:
            if item not in status_list['*'].values():
                if item.isdigit() and item in status_list['*']:
                    coms[coms.index(item)] = status_list['*'][item]
        exe('git add %s' % ' '.join(coms[2:]))
        print_status(coms[0])
    #---------------
    elif orden == execs['a.']['aka']:
        exe('git add .')
        print_status(coms[0])
    #---------------
    elif orden == execs['b']['aka']:
        print(pcolor('>>> git branch -vvv', Fore.RED))
        print_ramas(txtpath)
    #---------------
    elif orden == execs['ba']['aka']:
        print(pcolor('>>> git branch -avvv', Fore.RED))
        print_ramas(txtpath, True)
    #---------------
    elif orden == execs['c']['aka'] or orden == execs['cf']['aka']:
        if len(coms) == 2:
            exe('git checkout')
        #---------------
        elif len(coms) == 3:
            if coms[2].isdigit():
                if int(coms[2]) <= len(ramas):
                    if int(coms[2]) - 1 == rama_actual:
                        print(limita(ramas[rama_actual]))
                        print(pcolor('Ya estás en ese branch, nothing to do...', Fore.RED))
                    else:
                        rama_actual = int(coms[2]) - 1
                        if orden == 'c':
                            exe('git checkout %s' % ramas[rama_actual].split(' ')[0])
                        else:
                            exe('git checkout -f %s' % ramas[rama_actual].split(' ')[0])
                        wat_exe(('%s %s' % (comands[0], execs['s']['aka'])).split(' '))
                else:
                    print('El número de rama es incorrecto')
            else:
                if orden == 'c':
                    exe('git checkout -b %s' % '_'.join(coms[2:]))
                else:
                    exe('git checkout -f -b %s' % '_'.join(coms[2:]))
        #---------------
        elif len(coms) == 4:
            if coms[2] == '--':
                status_list = print_status(coms[0], False)
                for item in coms[3:]:
                    if item not in status_list.values():
                        if item.isdigit() and item in status_list['*']:
                            coms[coms.index(item)] = status_list['*'][item]
                exe('git checkout -- %s' % ' '.join(coms[3:]))
            elif coms[3].isdigit() and int(coms[3]) <= len(ramas):
                rama = int(coms[3]) - 1
                cual = 1
                if rama != rama_actual:
                    cual = 0
                exe('git checkout -b %s %s' % (coms[2], ramas[rama].split(' ')[cual]))
    #---------------
    #elif orden == execs['rm']['aka']:
        #~ if len(coms) > 2
    #---------------
    #elif orden == execs['mv']['aka']:
        #~ if len(coms) > 2:
    #---------------
    elif orden == execs['s']['aka']:
        print(pcolor('>>> git status', Fore.RED))
        print_status(coms[0])
    #---------------
    elif orden == execs['reset']['aka']:
        status_list = print_status(coms[0], False)
        res = []
        che = []
        for item in coms[2:]:
            if item not in status_list['*'].values():
                if item.isdigit() and item in status_list['*']:
                    if item in status_list['r']:
                        res.append(status_list['r'][item])
                    elif item in status_list['c']:
                        res.append(status_list['c'][item])
                    else:
                        print('%s is not tracked' % status_list['*'][item])
                else:
                    print('%s no está en la lista' % item)
            elif item in status_list['r']:
                res.append(item)
            elif item in status_list['c']:
                res.append(item)
        if res:
            exe('git reset HEAD %s' % ' '.join(res))
        if che:
            exe('git checkout -- %s' % ' '.join(che))
        if res or che:
            print_status(coms[0])
    #---------------
    elif orden == execs['e']['aka']:
        if len(coms) > 2:
            for nbranch in coms[2:]:
                if nbranch.isdigit() and int(nbranch) <= len(ramas):
                    rama = ramas[int(nbranch) - 1].split(' ')[0]
                    if rama == '*':
                        rama = ramas[int(nbranch) - 1].split(' ')[1]
                    exe('git merge %s' % rama)
                else:
                    print(pcolor('El número de rama introducido no es correcto', Fore.RED))
        else:
            print(pcolor('g e <n branch>, Falta el número de la rama', Fore.RED))
    #---------------
    elif orden == execs['ep']['aka']:
        if len(coms) > 2:
            go_on = False
            for nbranch in coms[2:]:
                if nbranch.isdigit() and int(nbranch) <= len(ramas):
                    exe('git merge %s' % ramas[int(nbranch) - 1].split(' ')[0])
                    go_on = True
                else:
                    print(pcolor('El número de rama introducido no es correcto', Fore.RED))
            if go_on:
                exe('git push')
        else:
            print('g e <n branch>, Falta el número de la rama')
    #---------------
    elif orden == execs['t']['aka']:
        if len(coms) > 2:
            exe('git commit -m "%s"' % ' '.join(coms[2:]))
        else:
            exe('git commit')
    #---------------
    elif orden == execs['ta']['aka']:
        if len(coms) > 2:
            exe('git commit -a -m "%s"' % ' '.join(coms[2:]))
        else:
            exe('git commit -a')
    #---------------
    elif orden == execs['tap']['aka']:
        if len(coms) > 2:
            exe('git commit -a -m "%s"' % ' '.join(coms[2:]))
        else:
            exe('git commit -a')
        if '[origin' in ramas[rama_actual]:
            exe('git push')
        else:
            exe('git push --set-upstream origin %s' % (ramas[rama_actual]).split(' ')[1])
    #---------------
    elif orden == execs['l']['aka']:
        if '[origin' in ramas[rama_actual]:
            exe('git pull')
        else:
            exe('git branch -u origin/%s' % (ramas[rama_actual]).split(' ')[1])
            exe('git pull')
    #---------------
    elif orden == execs['la']['aka']:
        exe('git pull --all')
    #---------------
    elif orden == execs['o']['aka']:
        exe('git log')
    #---------------
    elif orden == execs['p']['aka']:
        exe('git push')
    #---------------
    elif orden == execs['pa']['aka']:
        exe('git push --all')
    #---------------
    elif orden == execs['po']['aka']:
        exe('git push origin %s' % (ramas[rama_actual]).split(' ')[1])
    #---------------
    elif orden == execs['pu']['aka']:
        exe('git push --set-upstream origin %s' % (ramas[rama_actual]).split(' ')[1])
    #---------------
    elif orden == execs['w']['aka']:
        exe('git show')
    #---------------
    elif orden == execs['rw']['aka']:
        exe('git remote show origin')
    #---------------
    elif orden == execs['f']['aka']:
        exe('git fetch')
    #---------------
    elif orden == execs['h']['aka']:
        if len(coms) > 2:
            exe('git stash save %s' % ' '.join(coms[2:]))
        else:
            exe('git stash')
    #---------------
    elif orden == execs['hw']['aka']:
        if len(coms) > 2 and coms[2].isdigit():
            exe('git stash show %s' % coms[2])
        else:
            exe('git stash show')
    #---------------
    elif orden == execs['hp']['aka']:
        if len(coms) > 2 and coms[2].isdigit():
            exe('git stash pop %s' % coms[2])
        else:
            exe('git stash pop')
    #---------------
    elif orden == execs['ha']['aka']:
        if len(coms) > 2 and coms[2].isdigit():
            exe('git stash apply --%s' % coms[2])
        else:
            exe('git stash apply')
    #---------------
    elif orden == execs['ho']['aka']:
        if len(coms) > 2 and coms[2].isdigit():
            exe('git stash drop %s' % coms[2])
        else:
            exe('git stash drop')
    #---------------
    elif orden == execs['hb']['aka'] and len(coms) > 2:
        if len(coms) > 3 and coms[3].isdigit():
            exe('git stash branch %s %s' % (coms[2], coms[3]))
        else:
            exe('git stash branch %s' % coms[2])
    #---------------
    elif orden == execs['hl']['aka']:
        exe('git stash list')
    #---------------
    elif orden == execs['hr']['aka']:
        exe('git stash clear')
    #---------------
    elif orden == execs['g']['aka']:
        exe('git log --oneline --abbrev-commit --all --graph --decorate --color')
    #---------------
    elif orden == execs['n']['aka']:
        if len(coms) > 2:
            exe('git switch -c %s' % coms[2])
        else:
            exe('git switch list')

    #---------------
    #~ elif orden == execs['']['aka']:
    #---------------
    elif orden == execs['note']['aka']:
        if len(coms) == 2:
            print(pcolor('>>> List notes', Fore.RED))
            os.system('%s %s' % (execs['nano']['cmd'], notes))
        else:
            data = ' '.join(coms[2:])
            print('%s %s' % (pcolor('>>> Add note to notes:', Fore.RED), pcolor(data, Fore.GREEN)))
            os.system('echo %s >> %s' % (data, notes))
    #---------------
    elif orden == execs['help']['aka']:
        show_help()
    #---------------
    elif orden == execs['ls']['aka']:
        print_files()
        print()
    #---------------
    elif orden == execs['cd']['aka']:
        fold = ''
        if len(coms) > 2 and coms[2].isdigit():
            fichs, folds = print_files(print_out = False)
            if int(coms[2]) <= len(folds) + len(fichs):
                fold = folds[int(coms[2]) - len(fichs) - 1]
                os.chdir(fold)
        else:
            fold = ' '.join(coms[2:])
            if os.path.isdir(fold):
                os.chdir(fold)
            else:
                fold = ''
        if fold:
            print('cd %s' % fold)
    #---------------
    elif orden == execs['nano']['aka']:
        if len(coms) > 2:
            fichs, folds = print_files(print_out = False)
            for num in coms[2:]:
                if num.isdigit():
                    exe('%s "%s"' % (execs['nano']['cmd'], fichs[int(num) - 1]))
                else:
                    exe('%s %s' % (execs['nano']['cmd'], num))
        elif len(coms) == 2:
            fichs, folds = print_files()
            n = input('\nfile number: ')
            if n.isdigit() and int(n) > 0 and int(n) <= len(fichs):
                exe('%s %s' % (execs['nano']['cmd'], fichs[int(n) - 1]))
            else:
                exe('%s %s' % (execs['nano']['cmd'], n))
    #---------------
    elif orden == execs['tutor']['aka']:
        os.system('python %s/tutor.py' % os.getcwd())
    #---------------
    elif orden == execs['execs']['aka']:
        print(pcolor('Keys used will be written to %s_keys file, so you can changed them' % comands[0], Fore.GREEN))
        write_execs()
        exe('%s %s_keys' % (execs['nano']['aka'], comands[0]))
    #---------------
    elif orden == execs['aexec']['aka']:
        add_exec(coms)
    #---------------
    elif orden == execs['rexec']['aka']:
        rem_exec(coms)
    #---------------
    elif orden in uexecs:
        exe(uexecs[orden])
##------------------------
comands = sys.argv
if tcolor:
    color = Fore.CYAN
else:
    color = ''
prompt = pcolor('>>> ', color)
last_orden = ''
#------------------------
git_repo = is_git_repo()
if not git_repo:
    print('This folder is not a git repository...')
    #ampliar aqui para iniciar o clonar
else:
    header(git_repo)
    ancho = int(os.popen('stty size', 'r').read().split()[1])
    execs = read_execs()
    uexecs = read_uexecs()
    if len(comands) == 1: #modo interactivo
        wat_exe(('%s %s' % (comands[0], execs['s']['aka'])).split(' '))
        orden = rlinput(prompt)
        while orden:
            wat_exe(('%s %s' % (comands[0], orden)).split(' '))
            orden = rlinput(prompt)
            if orden == '.' and last_orden:
                orden = last_orden
            else:
                last_orden = orden
        os.system('clear')
    else:
        wat_exe(comands)
#------------------------
