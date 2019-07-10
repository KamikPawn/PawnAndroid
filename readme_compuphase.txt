RUS
====================================
Pawn-это простой, типизированный, с 32-битным расширением языка с Си-подобным синтаксисом.
Компилятор Pawn выводит P-код (или байт-код), который впоследствии выполняется на
абстрактной машине. Скорость работы, стабильность, простота и компактность
были существенными критериями проектирования как для языка, так и для абстрактной
машине.
Через эволюцию инструментария Pawn, этот документ стабильно
растет по мере тестирования все большего числа компиляторов и добавления новых компонентов.
Совсем недавно инструкции по компиляции были перенесены в отдельный документ
под названием "буклет Pawn: руководство исполнителя". Чтобы получить Pawn инструментарий
работая над вашей системой, пожалуйста (также) обратитесь к этому документу. Узнавать
язык пешки, прочитайте документ "буклет Pawn: язык". Если вы
установили Pawn с помощью утилиты установки (для Microsoft Windows) или автопакета
(для Linux), вероятно, у вас уже есть эти документы. В противном случае, вы можете
получить оба эти документа с веб-страницы, посвященной Pawn:
 http://www.compuphase.com/pawn.htm
Ниже приведен список тем, которые этот README охватывает в следующем порядке:
о Начало работы
 Как запустить свою первую программу Pawn.
o здание с CMake
 Для портативного способа (повторного)создания программного обеспечения
о благодарности
 Для компонентов, не записанных CompuPhase
o использование библиотеки DLL AMX
 Как создать программу, которая использует предварительно построенную DLL.
o построение библиотеки DLL AMX
 Примечания о том, как DLL должна быть построена сама.
o построение модулей расширения для библиотеки DLL AMX
Начало работы
===============
Первый вопрос: что вам нужно? Если вы используете Microsoft Windows,
загрузите Pawn toolkit в виде самораспаковывающегося установочного файла; это дает
все, что нужно для начала:
о бинарники для Win32
о полный источник всех инструментов/библиотек
o документация (формат Adobe Acrobat)

Пользователи других операционных систем должны загрузить либо " pawnkit.zip"
файл или "pawnkit.tgz"(архив "Pawn toolkit"), потому что он
содержит полный исходный код. Разница между файлом " ZIP " и
Файл" TGZ", помимо другого используемого инструмента архивирования, является источником
файл в ZIP-файле имеет окончания строк DOS/Windows (CR / LF) и файл " TGZ
имеет окончания строк Unix (только LF). При "распаковке" этих архивов убедитесь
что структура каталогов в файлах ZIP / TGZ сохраняется. В противном случае
Например, компилятор Pawn не сможет найти свои файлы "include".
Также следует скачать два файла документации " пешка-lng.pdf " и
- pawn-imp.pdf " -- "Руководство по языку" и " руководство по реализации"
соответственно. Возможно, потребуется построить компилятор и абстрактную машину, а
"руководство исполнителя", скорее всего, даст вам точные рекомендации (или
по крайней мере, это укажет вам в правильном направлении). Есть несколько рекомендаций
для построения системы с CMake в разделе "построение с CMake", ниже.
Предполагая, что вы получили (каким-то образом) исполняемую версию Pawn
компилятор и Pawn времени выполнения, вы должны поместить его в каталог. Однако,
компилятор Pawn также должен найти "include files". На много работая
системы, Pawm компилятор способен автоматически читать эти заголовочные файлы
из каталога "include", который находится ниже каталога, в котором находится компилятор
в действительности. Таким образом, если компилятор Pawn (исполняемый файл) находится в каталоге
"C:\WhatEver\Pawn\bin", я предлагаю вам создать либо каталог
"C:\WhatEver\Pawn\include" или "C:\WhatEver\Pawn\bin\include-и скопируйте
".inc" файлы. Если ваша операционная система не совместима с Win32 или
Linux, компилятор Pawn может не знать, как найти каталог "include"
и вы должны указать его самостоятельно с помощью опции командной строки "- i " (когда
запуска компилятора).
Что за вашей спиной, найдите один из примеров скриптов (например, "Hello.р") и
скомпилировать его с:

pawncc Hello

Это должно произвести "Hello.amx", с которым вы можете работать:

pawnrun Hello.АМХ

Многие приложения, использующие Pawn, запускают компилятор Pawn как дочерний процесс;
т. е. компилятор пешки часто является отдельной, автономной программой. Этот
абстрактная машина, однако, почти никогда не является отдельным процессом: обычно вы
хотите, чтобы абстрактная машина была интегрирована в приложение, чтобы скрипты
можно было вызывать в приложении. Другими словами, вы можете использовать "pawncc" как
есть, но вы не будете использовать "pawnrun" как есть. Вот почему pawnrun держится коротким
и дамп, "pawnrun" это программа, которая в основном разработана в руководстве Pawn
показать вам, что вы должны сделать, как минимум, чтобы встроить Pawn в программу.

Сборка с CMake
===================
CMake-это кроссплатформенная система make с открытым исходным кодом, которая генерирует " makefile"
или файлы проектов для различных компиляторов и платформ. См. http://www.cmake.org/
для получения дополнительной информации о CMake плюс свободно загружаемой копии.
Pawn toolkit поставляется с файлом проекта CMake, который создает компилятор, а
простая программа времени выполнения, которая встраивает абстрактную машину, и простая консоль
отладчик. Файл проекта CMake находится в подкаталоге "source", где
Pawn toolkit устанавливается, когда вы установили самораспаковывающийся "setup" для
Microsoft Windows. При распаковке Pawn исходный код из " ZIP " или " TGZ"
архив, файл проекта CMake находится в главном каталоге, где вы распаковали
архив.

Microsoft Windows
-----------------
1. Запустите CMakeSetup.
2. Выберите для каталога исходного кода подкаталог "source" в поле
 дерево каталогов для инструментария.
 Например, если вы установили инструментарий C:\Pawn, исходный каталог
 is C:\Pawn\source.
3. Выберите в качестве места назначения подкаталог "bin" или любой другой каталог вашего
 выбора. Makefile (или файлы проекта) будет создан в месте назначения
 справочника.
4. Выберите компилятор, чтобы использовать, как хорошо. В Microsoft Windows CMake поддерживает
 Компиляторы Microsoft и Borland, а также GNU GCC.
5. Нажмите на кнопку "Настроить". После первоначальной настройки, вы можете
 элементы отображаются красным цветом. При этом CMake указывает, что эти элементы
 может потребоваться корректировка, но в случае Pawn это редко требуется. Щелчок
 "Настройка" еще раз для окончательной конфигурации.
6. Нажмите на кнопку "ОК". Это завершает работу программы CMakeSetup после создания
 количество файлов в подкаталоге назначения.
7. Постройте программу обычным способом. Для Microsoft Visual C/C++ CMake имеет
 создал проект Visual Studio и файл "Workspace"; для других компиляторов
 CMake создает makefile.
 
Linux / Unix
------------
1. Перейдите в подкаталог "bin", в который был извлечен архив. Для
 например, если вы распаковали инструментарий в /opt /Pawn, перейдите в/opt/Pawn / bin.
 Если вы установили пешку как root, то вы также должны быть root при перекомпиляции
 Pawn.
2. Запуск "ccmake ../source " если вы установили автопакет Linux. Если у вас есть
 в "tarball", возможно, потребуется использовать " ccmake .." вместо. Параметр
 ccmake должен быть относительным путем к тому, где CMakeLists.найден файл txt.
3. Нажмите клавишу " c "для"настроить". После первоначальной настройки, вы можете
 есть элементы в списке, которые имеют "*" перед их стоимости. К этому времени,
 CMake указывает, что эти элементы могут нуждаться в корректировке, но в случае
 Pawn, это редко нужно. Введите " c " еще раз для окончательной конфигурации.
4. Нажмите кнопку " g "для"создания и выхода". Затем создайте программу
 набрав "сделать". Программы будут построены в подкаталоге "bin".
 
====================================
ORIGINAL
====================================
Pawn is a simple, typeless, 32-bit extension language with a C-like syntax.
The Pawn compiler outputs P-code (or bytecode) that subsequently runs on an
abstract machine. Execution speed, stability, simplicity and a small footprint
were essential design criterions for both the language and the abstract
machine.

Through the evolution of the Pawn toolkit, this README had steadily been
growing, as more and more compilers were tested and more components were added.
More recently, the compiling instructions were moved to a separate document
entitled "The Pawn booklet: Implementor's Guide". To get the Pawn toolkit
working on your system, please (also) consult that document. To learn about
the Pawn language, read the document "The Pawn booklet: The Language". If you
installed Pawn via the Setup utility (for Microsoft Windows) or the autopackage
(for Linux), you probably have these documents already. Otherwise, you can
obtain both these documents from the web page devoted to Pawn:
        http://www.compuphase.com/pawn.htm

Below is a list of topics that this README covers, in this order:

o  Getting started
   How to get your first Pawn program running

o  Building with CMake
   For a portable way to (re-)build the software

o  Acknowledgements
   For components not written by CompuPhase

o  Using the AMX DLL
   How to create a program that uses the pre-built DLL.

o  Building the AMX DLL
   Notes on how the DLL must be built itself.

o  Building extension modules for the AMX DLL


Getting started
===============
The first question is: what do you need? If you are using Microsoft Windows,
download the Pawn toolkit as a self-extracting setup file; this gives
everything that you need to get started:
o  binaries for Win32
o  full source of all tools/libraries
o  documentation (Adobe Acrobat format)

Users of other operating systems should download either the "pawnkit.zip"
file or the "pawnkit.tgz" file ("Pawn toolkit" archives), because it
contains the full source code. The difference between the "ZIP" file and the
"TGZ" file is, apart from the different archiving tool used, that the source
file in the ZIP file has DOS/Windows line endings (CR/LF) and the "TGZ" file
has Unix line endings (LF only). When "unpacking" these archives, make sure
that the directory structure in the ZIP/TGZ files is retained. Otherwise, the
Pawn compiler will not be able to find its "include" files, for example.

You should also download the two documentation files "pawn-lng.pdf" and
"pawn-imp.pdf" --the "Language guide" and the "Implementor's guide"
respectively. You may need to build the compiler and abstract machine, and
the "Implementor's guide" is likely to give you precise guidelines (or at
least, it will point you in the right direction). There are a few guidelines
for building the system with CMake in the section "Building with CMake", below.

Assuming that you have obtained (somehow) an executable version of the Pawn
compiler and the Pawn run-time, you should put it in a directory. However,
the Pawn compiler also needs to locate "include files". On many operating
systems, the Pawn compiler is able to automatically read these header files
from the directory "include" that is below the directory that the compiler is
in itself. Thus, if the Pawn compiler (the executable file) is in directory
"C:\WhatEver\Pawn\bin", I suggest that you create either the directory
"C:\WhatEver\Pawn\include" or "C:\WhatEver\Pawn\bin\include" and copy the
".inc" files there. If your operating system is not compatible with Win32 or
Linux, the Pawn compiler may not know how to locate the "include" directory
and you have to specify it yourself with the "-i" command line option (when
running the compiler).

That behind your back, locate one of the example scripts (e.g. "hello.p") and
compile it with:

        pawncc hello

This should produce "hello.amx", which you can then run with:

        pawnrun hello.amx

Many applications that use Pawn, run the Pawn compiler as a child process;
i.e. the Pawn compiler is often a separate, self-contained program. The
abstract machine, however, is almost never a separate process: typically you
want the abstract machine to be integrated in the application so that scripts
can call into the application. In other words, you might be using "pawncc" as
is, but you won't be using "pawnrun" as is. This is why pawnrun is kept short
and dump, "pawnrun" is a program that is mostly developed in the Pawn manual to
show you what you should do at a minimum to embed Pawn into a program.


Building with CMake
===================
CMake is a cross-platform, open-source make system, which generates "makefile's"
or project files for diverse compilers and platforms. See http://www.cmake.org/
for more information on CMake plus a freely downloadable copy.

The Pawn toolkit comes with a CMake project file that builds the compiler, a
simple run-time program that embeds the abstract machine, and a simple console
debugger. The CMake project file is in the "source" subdirectory of where the
Pawn toolkit is installed, when you installed the self-extracting "setup" for
Microsoft Windows. When unpacking the Pawn source code from a "ZIP" or "TGZ"
archive, the CMake project file is in the main directory where you unpacked
the archive into.

Microsoft Windows
-----------------
1. Launch CMakeSetup.

2. Select for the source code directory, the "source" subdirectory in the
   directory tree for the toolkit.

   For example, if you installed the toolkit in C:\Pawn, the source directory
   is C:\Pawn\source.

3. Select as destination the "bin" subdirectory, or any other directory of your
   choice. The makefile (or project files) will be generated in the destination
   directory.

4. Select the compiler to use, as well. On Microsoft Windows, CMake supports
   Microsoft and Borland compilers, as well as GNU GCC.

5. Click on the "Configure" button. After an initial configuration, you may
   have items displayed in red.  By this, CMake indicates that these items
   may need adjustment, but in the case of Pawn, this is rarely needed. Click
   "Configure" once more for the final configuration.

6. Click on the "OK" button. This exits the CMakeSetup program after creating a
   number of files in the destination subdirectory.

7. Build the program in the usual way. For Microsoft Visual C/C++, CMake has
   created a Visual Studio project and "Workspace" file; for other compilers
   CMake builds a makefile.


Linux / Unix
------------
1. Change to the "bin" subdirectory where the archive was extracted into. For
   example, if you unpacked the toolkit in /opt/Pawn, go to /opt/Pawn/bin.

   If you installed Pawn as root, then you must also be root when you recompile
   Pawn.

2. Launch "ccmake ../source" if you installed the Linux autopackage. If you got
   the "tarball", you may need to use "ccmake .." instead. The parameter of
   ccmake must be the relative path to where the CMakeLists.txt file is found.

3. Press the "c" key for "configure". After an initial configuration, you may
   have items in the list that have a "*" in front of their value. By this,
   CMake indicates that these items may need adjustment, but in the case of
   Pawn, this is rarely needed. Type "c" once more for the final configuration.

4. Press the "g" button for "generate and quit". Then build the program by
   typing "make". The programs will be built in the subdirectory "bin".


Acknowledgements
================
This work is based on the "Small C Compiler" by Ron Cain and James E. Hendrix,
as published in the book "Dr. Dobb's Toolbook of C", Brady Books, 1986.

The assembler version of the abstract machine (five times faster than the ANSI
C version and over two times faster than the GNU C version) was written by
Marc Peter (macpete@gmx.de). Marc holds the copyright of the file AMXEXEC.ASM,
but its distribution and license fall under the same conditions as those
stated in LICENSE.TXT.

The Just-In-Time compiler (JIT) included in this release was also written by
Marc Peter. As is apparent from the source code, the JIT is an evolutionary
step from his earlier abstract machine. The JIT falls under the same (liberal)
license as the other components in the Pawn toolkit. The abstract machine
has evolved slightly since Marc Peter write the JIT and the JIT does currently
not handle the "sleep" instruction correctly.

The power user David "Bailopan" Anderson (see www.bailopan.net) found many bugs
in Pawn, and provided patches and detailed reports. He and his team also
provided a new "memory file" module that make the compiler process large scripts
quicker.

G.W.M. Vissers translated Marc Peter's JIT to NASM. This makes the JIT available
to Linux and Unix-like platforms.

Greg Garner from Artran Inc. compiled the source files as C++ files (rather
than C), added type casts where needed and fixed two bugs in the Pawn compiler
in the process. Greg Garner also wrote (and contributed) the extension module
for floating point support (files FLOAT.CPP and FLOAT.INC). I am currently
maintaining these modules, in order to keep them up to date with new features
in the Pawn toolkit.

Dark Fiber contributed an extension module for the AMX to provide decent
quality pseudo-random numbers, starting with any seed. To illustrate the
module, he also wrote a simple card game (TWENTY1.SMA) as a non-trivial
Pawn script.

Dieter Neubauer made a 16-bit version of the Pawn tools (meaning that a cell
is 16-bit, instead of the default 32-bit). His changes were merged in the
original distribution. Note that fixed or floating point arithmetic will be
near to impossible with a 16-bit cell.

Robert Daniels ported Pawn to ucLinux and corrected a few errors that had to
do with the "Endianness" of the CPU. His corrections make the Pawn compiler
and abstract machine better portable to Big Endian machines.

Frank Condello made a port of the Pawn toolkit to MacOS (CFM Carbon). His
changes are merged into the main source trunk.


Using the AMX DLL
=================
The 32-bit AMX DLL (file AMX32.DLL) uses __stdcall calling convention, which
is the most common calling convention for Win32 DLLs. If your compiler defaults
to a different calling convention (most do), you must specify the __stdcall
calling convention explicitly. This can be done in two ways:
1. a command line option for the C/C++ compiler (look up the manual)
2. setting the macros AMX_NATIVE_CALL and AMXAPI to __stdcall before including
   AMX.H. The macros AMX_NATIVE_CALL and AMXAPI are explained earlier in this
   README.

The 32-bit AMX DLL comes with import libraries for various Win32 compilers:
o  for Microsoft Visual C/C++ version 4.0 and above, use AMX32M.LIB
o  for Borland C++ version 5.0 and for Borland C++ Builder, use AMX32B.LIB
o  for Watcom C/C++ version 10.6 and 11.0, use AMX32W.LIB

The AMX DLL already includes "core" and "console" functions, which are the
equivalents of the C files AMXCORE.C and AMXCONS.C. Console output goes to a
text window (with 30 lines of 80 characters per line) that the DLL creates.
The core and console functions are automatically registered to any Pawn
program by amx_Init().

   Microsoft Visual C/C++ version 5.0 or 6.0, 32-bit:
        cl -DAMXAPI=__stdcall prun-dll.c amx32m.lib

        (Note: the "prun-dll" example does not register additional native
        functions. Therefore, AMX_NATIVE_CALL does not need to be defined.)

   Watcom C/C++ version 11.0, 32-bit:
        wcl386 /l=nt_win /dAMXAPI=__stdcall prun-dll.c amx32w.lib

        (Note: the "prun-dll" example does not register additional native
        functions. Therefore, AMX_NATIVE_CALL does not need to be defined.)

   Borland C++ version 3.1, 16-bit:
        bcc -DAMXAPI=__cdecl -W -ml prun-dll.c amx16.lib

        (Note: the program must be compiled as a Win16 application, because
        only Windows programs can use DLLs (option -W). Using large memory
        model, option -ml, is not strictly required, but it is the most
        convenient. Finally, note that the 16-bit DLL uses __cdecl calling
        convention for its exported functions, for reasons explained below.)


Building the AMX DLL
====================
The 32-bit DLL is made from the files AMX.C, AMXDLL.C, AMXCONS.C, AMXCORE.C
and AMXEXEC.ASM.

The first point to address is, again, that of calling conventions. AMXAPI and
AMX_NATIVE_CALL must be set to __stdcall. I did this by adding the macros onto
the command line for the compiler, but you could also create an include file
with these macros before including AMX.H.

The function amx_Init() of the DLL is not identical to the standard version:
it also registers the "core" and "console" modules and registers external
libraries if it can find these. The original amx_Init() in AMX.C is renamed to
amx_InitAMX(), via macros, at compile time. AMXDLL.C implements the new
amx_Init() and this one is not translated.

All in all, the makefile for the AMX DLL plays a few tricks with macros in
order to keep the original distribution untouched. When you need to recompile
the AMX DLL, you may, of course, also opt for modifying AMX.H and AMX.C to
suit the needs for Win32 DLLs.

If you rebuild the DLL for 16-bit Windows, keep the following points in mind:
o  You must use the ANSI C version of the abstract machine; there is no
   16-bit assembler implementation.
o  Use large memory model: pointers used in "interface" functions must be far
   pointers to bridge the data spaces of the .EXE and the DLL. The source
   code is (mostly) ANSI C, however, and "far pointers" are an extension to
   ANSI C. The easiest way out is to make all pointers "far" by using large
   memory model.
o  AMX_NATIVE_CALL are best set to "__far __pascal". This is the "standard"
   calling convention for have interface functions in 16-bit Windows.
o  The native functions should also be exported, so that the data segment is
   set to that of the module that the native functions reside in.
o  AMXAPI, however, must be set to "__cdecl", because amx_Exec() uses a
   variable length argument list. This is incompatible with the "pascal"
   calling convention.

The distribution for the AMX DLL comes with two makefiles: the makefile for the
32-bit DLL is for Watcom C/C++ and the makefile for the 16-bit DLL is for
Borland C++ (Inprise).

