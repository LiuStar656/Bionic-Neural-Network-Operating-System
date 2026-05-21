@echo off
cls
chcp 65001 >nul
echo ======================================
echo        BNOS Node Starter (Windows)
echo ======================================
echo.
cd /d "%~dp0"

REM ==================== 环境检测与自愈 ====================
echo 🔍 检测虚拟环境状态...

if not exist "venv\Scripts\python.exe" (
    echo ⚠️ 检测到虚拟环境缺失或损坏
    echo.
    echo 🔧 开始自动修复...
    echo.
    
    REM 调用python_create_node.py进行修复
    if exist "..\..\python_create_node.py" (
        python ..\..\python_create_node.py --repair-only "%CD%"
        if errorlevel 1 (
            echo.
            echo ❌ 自动修复失败
            echo 💡 请手动删除venv文件夹后重新创建节点
            pause
            exit /b 1
        )
        echo.
        echo ✅ 虚拟环境重建成功
    ) else (
        echo ❌ 找不到python_create_node.py，无法自动修复
        echo 💡 请手动删除venv文件夹后重新创建节点
        pause
        exit /b 1
    )
)

REM ==================== 启动节点 ====================
echo 🔍 检测到虚拟环境正常
echo.

REM ==================== 依赖安装检查 ====================
if exist "requirements.txt" (
    echo 📦 检测到 requirements.txt，检查依赖安装状态...
    
    REM 激活虚拟环境并检查依赖
    call venv\Scriptsctivate.bat
    
    REM 尝试导入所有依赖来检查是否已安装（使用 UTF-8 编码）
    python -c "import pkg_resources; pkg_resources.working_set.require([l.strip() for l in open('requirements.txt', encoding='utf-8').read().splitlines() if l.strip() and not l.strip().startswith('#')])" 2>nul
    if errorlevel 1 (
        echo 🔧 开始安装依赖...
        python -m pip install -r requirements.txt
        if errorlevel 1 (
            echo.
            echo ⚠️ 依赖安装失败，但将继续启动
        ) else (
            echo.
            echo ✅ 依赖安装成功
        )
    ) else (
        echo ✅ 依赖已安装或无需安装
    )
    
    echo.
)

echo 🔧 启动节点...
echo.

python listener.py

echo.
echo ✅ 节点已停止
pause