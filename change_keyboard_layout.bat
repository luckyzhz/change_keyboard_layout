:: 本脚本通过修改注册表来修改键盘布局
:: 运行脚本后需要【重启系统】或【注销后重新登陆系统】
:: 才能使修改生效



@echo off

:: 以管理员运行脚本
%1 start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" ::","","runas",1)(window.close)&&exit

:: 设置编码为 utf-8，避免显示乱码
chcp 65001 > nul

:: 用户提示
echo 请选择需要的键盘布局（默认 1. 美式键盘）：
echo.
echo 1. 美式键盘
echo.
echo 2. 日文键盘
echo.
set /p layout=请输入编号（默认1）:

:: 如果没有输入，则把 layout 设为默认值 1
if "%layout%"=="" (
    set layout=1
)

:: 根据所选编号，设置注册表值
if %layout%==1 (
    set value=kbdus.dll
) else if %layout%==2 (
    set value=kbd106.dll
)

:: 注册表路径
set reg_dir="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\00000804"

:: 修改注册表
reg add %reg_dir% /v "Layout File" /t REG_SZ /d %value% /f

:: 用户提示
echo.
echo.
echo 键盘布局已设为 %value%
echo.
echo 请【重启系统】或【注销后重新登陆系统】

:: 暂停，避免命令行窗口立即关闭
pause > nul