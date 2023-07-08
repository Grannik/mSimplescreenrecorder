#!/bin/bash
 E='echo -e';
 e='echo -en';
#
 i=0; CLEAR; CIVIS;NULL=/dev/null
 trap "R;exit" 2
 ESC=$( $e "\e")
 TPUT(){ $e "\e[${1};${2}H" ;}
 CLEAR(){ $e "\ec";}
 CIVIS(){ $e "\e[?25l";}
 R(){ CLEAR ;stty sane;CLEAR;};                 # в этом варианте фон прозрачный
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
 UNMARK(){ $e "\e[0m";}
 MARK(){ $e "\e[30;47m";}
#
 HEAD()
{
 for (( a=2; a<=37; a++ ))
          do
              TPUT $a 1;$E "\e[47;30m│\e[0m                                                                                \e[47;30m│\e[0m"
          done
TPUT  1 1;$E "\033[0m\033[47;30m┌────────────────────────────────────────────────────────────────────────────────┐\033[0m"
TPUT  3 3;$E "\e[1;36m *** simplescreenrecorder ***\e[0m";
TPUT  4 3;$E "\e[2m Многофункциональный экранный рекордер с поддержкой X11 и OpenGL.\e[0m";
TPUT  5 1;$E "\e[47;30m├\e[0m\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m"
TPUT 11 1;$E "\e[47;30m├\e[0m\e[2m─\e[36m OPTIONS\e[0m\e[2m ─────────────────────────────────────────────────────────────\e[36m ОПЦИИ \e[0m\e[2m──\e[47;30m┤\e[0m"
TPUT 23 1;$E "\e[47;30m├\e[0m\e[2m─\e[36m COMMANDS ACCEPTED THROUGH STDIN\e[0m\e[2m ──────────\e[36m КОМАНДЫ, ПРИНИМАЕМЫЕ ЧЕРЕЗ STDIN \e[0m\e[2m──\e[47;30m┤\e[0m"
TPUT 24 3;$E "\e[2m Start the recording                                           \e[32m record-start\e[0m";
TPUT 25 3;$E "\e[2m Pause the recording                                           \e[32m record-pause\e[0m";
TPUT 26 3;$E "\e[2m Cancel the recording and delete the output file              \e[32m record-cancel\e[0m";
TPUT 27 3;$E "\e[2m Finish the recording and save the output file                  \e[32m record-save\e[0m";
TPUT 28 3;$E "\e[2m Активировать расписание записи                           \e[32m schedule-activate\e[0m";
TPUT 29 3;$E "\e[2m Отключить расписание записи                            \e[32m schedule-deactivate\e[0m";
TPUT 30 3;$E "\e[2m Показать окно приложения                                       \e[32m window-show\e[0m";
TPUT 31 3;$E "\e[2m Скрыть окно приложения                                         \e[32m window-hide\e[0m";
TPUT 32 3;$E "\e[2m Quit the application                                                  \e[32m quit\e[0m";
TPUT 33 1;$E "\e[47;30m├\e[0m\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m"
TPUT 35 1;$E "\e[47;30m├\e[0m\e[2m─ Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter ─────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m"
}
 FOOT(){ MARK;TPUT 38 1;$E "\033[0m\033[47;30m└────────────────────────────────────────────────────────────────────────────────┘\033[0m";UNMARK;}
  M0(){ TPUT  6 3; $e " УСТАНОВКА                                                          \e[32m INSTALL \e[0m";}
  M1(){ TPUT  7 3; $e " КРАТКИЙ ОБЗОР                                                     \e[32m SYNOPSIS \e[0m";}
  M2(){ TPUT  8 3; $e " ОПИСАНИЕ                                                       \e[32m DESCRIPTION \e[0m";}
  M3(){ TPUT  9 3; $e " СМОТРИТЕ ТАКЖЕ                                                    \e[32m SEE ALSO \e[0m";}
  M4(){ TPUT 10 3; $e " МЕСТОПОЛОЖЕНИЕ ФАЙЛОВ                                       \e[32m FILE LOCATIONS \e[0m";}
#
  M5(){ TPUT 12 3; $e " Show this help message                                              \e[32m --help \e[0m";}
  M6(){ TPUT 13 3; $e " Show version information                                         \e[32m --version \e[0m";}
  M7(){ TPUT 14 3; $e " Загрузите и сохраните настройки программы в ФАЙЛ       \e[32m --settingsfile=FILE \e[0m";}
  M8(){ TPUT 15 3; $e " Запись сообщений журнала в FILE                           \e[32m --logfile[=FILE] \e[0m";}
  M9(){ TPUT 16 3; $e " Записать статистику записи в ФАЙЛ                       \e[32m --statsfile[=FILE] \e[0m";}
 M10(){ TPUT 17 3; $e " Не показывать значок на панели задач                          \e[32m --no-systray \e[0m";}
 M11(){ TPUT 18 3; $e " Запустить приложение в скрытом виде                         \e[32m --start-hidden \e[0m";}
 M12(){ TPUT 19 3; $e " Немедленно начать запись                                 \e[32m --start-recording \e[0m";}
 M13(){ TPUT 20 3; $e " Немедленно активируйте расписание записи               \e[32m --activate-schedule \e[0m";}
 M14(){ TPUT 21 3; $e " Показать схему синхронизации (для отладки)                   \e[32m --syncdiagram \e[0m";}
 M15(){ TPUT 22 3; $e " Запустите внутренний тест                                      \e[32m --benchmark \e[0m";}
#
 M16(){ TPUT 34 3; $e " Grannik Git                                                                 ";}
 M17(){ TPUT 36 3; $e " Exit                                                                        ";}
LM=17
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
  0) S=M0;SC; if [[ $cur == enter ]];then R;echo -e "
\e[32m sudo apt install simplescreenrecorder\e[0m
";ES;fi;;
  1) S=M1;SC; if [[ $cur == enter ]];then R;echo -e "
\e[32m simplescreenrecorder [OPTIONS]\e[0m
";ES;fi;;
  2) S=M2;SC; if [[ $cur == enter ]];then R;echo -e "
 SimpleScreenRecorder — это многофункциональная программа для записи экрана,
 поддерживающая X11 и OpenGL. Он имеет графический пользовательский интерфейс на
 основе Qt. Он может записывать весь экран или его часть, а также напрямую
 записывать приложения OpenGL. Запись можно поставить на паузу и возобновить в
 любой момент. Поддерживается множество различных форматов файлов и кодеков.
 Это классика и пожалуй единственная программа, для Linux OS, позволяющая записать
 экран и звук с динамика одновременно!
";ES;fi;;
  3) S=M3;SC; if [[ $cur == enter ]];then R;echo -e "
 More documentation can be found at:
\e[36m https://www.maartenbaert.be/simplescreenrecorder/\e[0m
";ES;fi;;
  4) S=M4;SC; if [[ $cur == enter ]];then R;echo -e "
 Файлы, используемые SimpleScreenRecorder, можно найти в следующих местах:
 Settings:\e[32m ~/.ssr/settings.conf\e[0m
 Logs:\e[32m ~/.ssr/logs/\e[0m
 Input profiles:\e[32m /usr/share/simplescreenrecorder/input-profiles/
 ~/.ssr/input-profiles/\e[0m
 Output profiles:\e[32m /usr/share/simplescreenrecorder/output-profiles/
 ~/.ssr/output-profiles/\e[0m
 Translations:\e[32m /usr/share/simplescreenrecorder/translations/\e[0m
";ES;fi;;
  5) S=M5;SC; if [[ $cur == enter ]];then R;echo -e "
\e[32m simplescreenrecorder --help\e[0m
";ES;fi;;
  6) S=M6;SC; if [[ $cur == enter ]];then R;echo -e "
\e[32m simplescreenrecorder --version\e[0m
";ES;fi;;
  7) S=M7;SC; if [[ $cur == enter ]];then R;echo -e "
 Загрузите и сохраните настройки программы в ФАЙЛ. Если опущено:
\e[32m ~/.ssr/settings.conf\e[0m используется.
";ES;fi;;
  8) S=M8;SC; if [[ $cur == enter ]];then R;echo -e "
 Запись сообщений журнала в FILE. Если ФАЙЛ опущен, используется
\e[32m ~/.ssr/log-DATE_TIME.txt\e[0m
";ES;fi;;
  9) S=M9;SC; if [[ $cur == enter ]];then R;echo -e "
 Записать статистику записи в ФАЙЛ. Если FILE опущен, используется
\e[32m /dev/shm/simplescreenrecorder-stats-PID\e[0m
 Он будет постоянно обновляться и удаляться при закрытии страницы записи.
";ES;fi;;
 10) S=M10;SC;if [[ $cur == enter ]];then R;echo -e "
 Не показывать значок на панели задач:\e[32m simplescreenrecorder --no-systray\e[0m
";ES;fi;;
 11) S=M11;SC;if [[ $cur == enter ]];then R;echo -e "
 Запустить приложение в скрытом виде:\e[32m simplescreenrecorder --start-hidden\e[0m
";ES;fi;;
 12) S=M12;SC;if [[ $cur == enter ]];then R;echo -e "
 Немедленно начать запись:\e[32m simplescreenrecorder --start-recording\e[0m
";ES;fi;;
 13) S=M13;SC;if [[ $cur == enter ]];then R;echo -e "
 Немедленно активируйте расписание записи:\e[32m simplescreenrecorder --activate-schedule\e[0m
";ES;fi;;
 14) S=M14;SC;if [[ $cur == enter ]];then R;echo -e "
 Показать схему синхронизации (для отладки):\e[32m simplescreenrecorder --syncdiagram\e[0m
";ES;fi;;
 15) S=M15;SC;if [[ $cur == enter ]];then R;echo -e "
 Запустите внутренний тест:\e[32m simplescreenrecorder --benchmark\e[0m
";ES;fi;;
#
 16) S=M16;SC;if [[ $cur == enter ]];then R;echo -e "
 Sa 08 Jul 2023 18:03:33 CEST
 mSimplescreenrecorder описание программы simplescreenrecorder
 Asciinema:  \e[36m https://asciinema.org/a/595632\e[0m
 Codeberg:   \e[36m https://codeberg.org/Grannik/mSimplescreenrecorder\e[0m
 Github:     \e[36m \e[0m
 Gitlab:     \e[36m \e[0m
 Sourceforge:\e[36m \e[0m
 Notabug:    \e[36m \e[0m
 Bitbucket:  \e[36m \e[0m
 Framagit:   \e[36m \e[0m
 GFogs:      \e[36m \e[0m
 Gitea       \e[36m \e[0m
 Bastyon:\e[36m \e[0m
";ES;fi;;
 17) S=M17;SC;if [[ $cur == enter ]];then R;clear;ls -l;exit 0;fi;;
 esac;POS;done
