@echo off
setlocal enabledelayedexpansion
cls
chcp 65001 >nul
echo ======================================
echo        BNOS Rust Node Starter
echo ======================================
echo.
cd /d "%%~dp0"

REM ==================== 环境检测与自愈 ====================
echo 🔍 检测 Rust 环境和编译产物...

set NEED_BUILD=0

if not exist "target\release\demo.exe" (
    echo ⚠️ 检测到 demo.exe 缺失
    set NEED_BUILD=1
)

if not exist "target\release\demo_listener.exe" (
    echo ⚠️ 检测到 demo_listener.exe 缺失
    set NEED_BUILD=1
)

if "!NEED_BUILD!"=="1" (
    echo.
    echo 🔧 开始自动构建...
    echo.
    
    REM 检查 Rust 是否安装
    where rustc >nul 2>&1
    if errorlevel 1 (
        echo ❌ Rust 未安装
        echo 💡 请先安装 Rust: https://rustup.rs/
        if not "%%1"=="--no-pause" pause
        exit /b 1
    )
    
    REM 构建项目
    cargo build --release
    if errorlevel 1 (
        echo.
        echo ❌ 构建失败
        if not "%%1"=="--no-pause" pause
        exit /b 1
    )
    echo.
    echo ✅ 构建成功
) else (
    echo ✅ 编译产物检测通过
)

echo.
echo ✅ 启动监听程序...
echo.
target\release\demo_listener.exe
echo.
echo ❌ 程序已退出
if not "%%1"=="--no-pause" pause
