# BNOS - Bionic Neural Network Operating System

🌍 Language | 语言选择：[中文](README.md) | [English](README_EN.md)

## 📖 Introduction

BNOS (Bionic Neural Network Operating System) is a general-purpose modular execution engine based on bionic neural networks. The system adopts a brain-inspired architecture where multiple collaborative nodes are combined to build various application systems. It can be used for plugin-based systems, automation pipelines, task scheduling, edge computing, microservices, and other scenarios, as well as for building AI agents. Each node is the smallest execution unit in the system (similar to neurons or functional modules in the brain), and multiple nodes communicate and collaborate through JSON files to jointly realize complex business logic and processing capabilities.

## 🧬 Design Philosophy

This system draws inspiration from the core characteristics of biological neural networks, mapped to general-purpose modular execution scenarios:

- **Functional Nodes (Neurons)**: Each node functions like a neuron or functional module in the brain, responsible for specific subtask processing
- **Node Collaboration (Neural Circuits)**: Multiple nodes connect through data files, forming a collaboration network within the system
- **Attention Mechanism**: Task filtering based on rules simulates the attention focusing mechanism of nodes
- **Duplicate Processing Prevention**: Automatically marks processed tasks to avoid nodes repeatedly executing the same operations (improves efficiency)
- **Modular Design**: Flexibly build various application systems with complex capabilities by combining nodes with different functions

## ⚡ High Concurrency Design Philosophy

BNOS does not require all nodes to support high concurrency, but adopts a brain-inspired architecture:

1. **High-Performance Node Implementation**: High concurrency and high-performance requirements (such as LLM inference, large-scale computing, high-frequency access) are implemented only within individual specialized nodes
2. **Flexible Technology Stack**: These nodes can freely use multi-threading, multi-processing, coroutines, third-party engines, and other technologies without framework restrictions
3. **Lightweight Node Stability**: Other nodes are only responsible for task perception, attention filtering, decision scheduling, and result storage, maintaining lightweight stability
4. **Minimalist Communication**: Inter-node communication is achieved through files, avoiding the complexity of distributed systems

This architecture makes the system both simple and stable, while enabling extreme performance in critical nodes.

## 🏗️ System Architecture

```
Upper Task (upper_data.json)
    ↓
Listener (listener.py) ← Attention Filtering (node attention mechanism)
    ↓
Node Processing Logic (main.py) ← Functional Unit Execution
    ↓
Output to Next Node (output.json) ← Inter-Node Communication
```

### Core Components

- **listener.py**: Node listener responsible for monitoring upper tasks, executing attention filtering, and calling node processing logic
- **main.py**: Node processing logic implementing execution logic for specific functional units within the agent
- **config.json**: Node configuration file defining node name, listening path, attention rules, etc.
- **packet.py**: Data packet structure definition file (inter-node communication format)
- **create_node.py**: Node creation tool that automatically generates complete node structures

## ✨ Key Features

- 🔒 **Environment Isolation**: Each node has its own independent Python virtual environment (venv), ensuring independence of functional units within the system
- 🎯 **Attention Mechanism**: Supports precise task filtering based on field values; nodes only focus on qualifying tasks (simulates attention focusing)
- 📝 **Duplicate Processing Prevention**: Automatically marks processed tasks to avoid nodes repeatedly executing the same operations (improves system efficiency)
- 📊 **Logging System**: Comprehensive node activity logging with both file and console output for tracking system behavior
- 🚀 **Modular Construction**: Provides node generator for one-click creation of standardized functional nodes, enabling rapid combination to build various application systems
- 💻 **Cross-Platform**: Supports Windows, Linux, and macOS systems
- 🌐 **General-Purpose Workflow Orchestration**: Supports building complex workflows, data pipelines, microservice components, etc. by combining multiple nodes
- 🔌 **Pluggable Design**: Node logic is independently encapsulated, allowing easy replacement, upgrade, or addition of new functional nodes to flexibly adjust system capabilities, suitable for plugin systems, automation toolchains, and other scenarios

## 📁 Project Structure

```
bnos/
├── data/
│   └── upper_data.json          # Upper task data file (task source)
├── node_test/                    # Example functional node (component unit of the system, such as data processing node, business logic node, API node, etc.)
│   ├── venv/                     # Independent virtual environment
│   ├── logs/                     # Log directory
│   │   └── listener.log         # Node activity log
│   ├── config.json              # Node configuration (attention parameters)
│   ├── listener.py              # Listener program (task receiver)
│   ├── main.py                  # Node processing logic (functional unit execution)
│   ├── packet.py                # Data packet definition (communication format)
│   ├── output.json              # Output data file (node output)
│   └── start.sh                 # Linux/macOS startup script
├── create_node.py               # Node creation tool (functional unit generator)
└── README.md                    # Project documentation
```

## 🚀 Quick Start

### Prerequisites

- Python 3.6+
- pip (for creating virtual environments)

### Create Functional Nodes

1. Run the node creation tool in the project root directory:

```bash
python create_node.py
```

2. Enter the node name (e.g., data_processor, api_handler, task_scheduler), and the system will automatically generate:
   - Complete node directory structure
   - Independent Python virtual environment
   - Standard configuration file
   - Startup scripts (Windows: `start.bat` / Linux: `start.sh`)

### Configure Node Attention

Edit the `config.json` file:

```json
{
  "node_name": "data_processor",           // Node name (functional unit ID)
  "listen_upper_file": "../data/upper_data.json",  // Path to upper task file (input channel)
  "output_file": "./output.json",     // Output file path (output channel)
  "filter": {                         // Attention filtering rules (attention mechanism)
    "type": "data_task"
  },
  "output_type": "data_result"         // Output data type identifier
}
```

### Write Node Processing Logic

Implement the `process()` function in `main.py` (functional unit execution logic):

```python
def process(data):
    """Process input task and return results (functional unit execution)"""
    value = data.get("data", 0)
    return float(value) + 1
```

### Start Functional Node

**Windows:**
```bash
cd node_test
start.bat
```

**Linux/macOS:**
```bash
cd node_test
chmod +x start.sh
./start.sh
```

## 📋 Configuration Guide

### config.json Parameters

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `node_name` | string | Unique node identifier (functional unit ID) | `"data_processor"` |
| `listen_upper_file` | string | Upper task file path (relative or absolute, input channel) | `"../data/upper_data.json"` |
| `output_file` | string | This node's output file path (output channel) | `"./output.json"` |
| `filter` | object | Attention filtering rules, key-value pair matching (attention mechanism) | `{"type": "data_task"}` |
| `output_type` | string | Output data type identifier (result type) | `"data_result"` |

### Attention Filtering Mechanism (Node Attention)

- If `filter` is an empty object `{}`, the node processes all tasks (broad attention)
- If filtering rules are configured, tasks are processed only when they contain all specified fields with exact value matches (focused attention)
- Example: `{"type": "data_task"}` means the node only focuses on tasks with `type` field value of `"data_task"`

### Data Packet Format (Inter-Node Communication)

**Input Task Packet** (`upper_data.json`):
```json
{
  "type": "data_task",
  "data": 153,
  "_processed_data_processor": true
}
```

**Output Result Packet** (`output.json`):
```json
{
  "code": 0,
  "type": "data_result",
  "data": 154
}
```

## 🔧 Development Guide

### Adding Dependencies

Add required Python packages to the node's `requirements.txt` file:

```
requests==2.28.0
numpy==1.23.0
openai==1.0.0
```

Then activate the virtual environment and install:

```bash
# Windows
venv\Scripts\activate
pip install -r requirements.txt

# Linux/macOS
source venv/bin/activate
pip install -r requirements.txt
```

### Debugging Tips

1. **View Logs**: Check `logs/listener.log` to understand node operation status (internal agent activity monitoring)
2. **Monitor Data**: Observe changes in `upper_data.json` and `output.json` (internal agent signal flow tracking)
3. **Test Attention**: Modify the `filter` rules in `config.json` to verify task filtering (attention adjustment)

### Log Format

```
[2026-04-24 17:26:11] [INFO] ✅ This is my task, starting processing
[2026-04-24 17:26:11] [INFO] ✅ Processing complete | Marked: _processed_perception_node
[2026-04-24 17:26:12] [ERROR] ❌ Task packet format error
```

## 🔄 Workflow (Node Collaborative Processing)

1. **Task Reception**: `listener.py` continuously monitors the `upper_data.json` file (node receives tasks from upstream nodes)
2. **Attention Filtering**: Determines whether to process the task based on `filter` rules in `config.json` (node attention focusing)
3. **Duplicate Check**: Checks if the task has been processed by the current node (via `_processed_<node_name>` marker, avoiding duplicate execution)
4. **Node Processing**: Calls `main.py` to execute node functional logic, passing JSON task as command-line arguments (functional unit execution)
5. **Output Results**: Writes processing results to `output.json` (node output, passed to downstream nodes)
6. **Mark Completion**: Adds processing markers to `upper_data.json` to prevent duplicate processing (task completion marking)

## ⚠️ Important Notes

1. **JSON Format**: Ensure all JSON files are properly formatted, otherwise parsing errors will occur
2. **File Permissions**: Ensure nodes have read/write permissions for data files
3. **Virtual Environment**: Each node must use an independent virtual environment to avoid dependency conflicts
4. **Concurrency Safety**: The current version does not support running multiple instances of the same node simultaneously
5. **Path Configuration**: Paths in configuration files can be relative or absolute
6. **System Design**: When designing systems, reasonably combine multiple nodes to form complete processing capabilities

## 🎯 Application Scenarios

As a general-purpose modular execution engine, BNOS is suitable for the following scenarios:

- 🔌 **Modular Plugin Systems**: Build scalable plugin architectures through node composition
- 📊 **Data Pipelines**: Construct automated pipelines for data processing, transformation, and analysis
- ⏰ **Task Scheduling**: Implement distributed scheduling and execution of complex tasks
- 🌐 **Edge Computing**: Deploy lightweight node networks on edge devices
- 🏗️ **Microservices**: Build node-based microservice components and API gateways
- 🛠️ **Automation Toolchains**: Create CI/CD, testing, deployment, and other automation toolchains
- 🤖 **AI Agents**: Build multi-node collaborative AI agent systems (perception, reasoning, decision nodes, etc.)
- 🧠 **Brain-Inspired Computing Experiments**: Conduct research experiments in brain-inspired computing and neural network simulation

## 🐛 FAQ

### Q: Node is not processing tasks?
A: Check the following:
- Confirm that `filter` rules are correctly configured (attention settings)
- Check `logs/listener.log` for filtering logs
- Verify that `upper_data.json` format is correct

### Q: How to reset node processing state?
A: Manually delete the `_processed_<node_name>` field from `upper_data.json` (clear node memory)

### Q: Virtual environment creation failed?
A: Ensure Python is installed and the `python -m venv` command is available

### Q: How to build a complete application system?
A: Create multiple functional nodes (such as data processing nodes, business logic nodes, API nodes, etc.), configure their `listen_upper_file` and `output_file` to form collaborative workflows, jointly constituting a complete application system. It can also be used to build AI agents by combining perception nodes, reasoning nodes, decision nodes, etc. to implement agent functionality.

## 📄 License

This project is licensed under the MIT License.

## 👥 Contributing

Contributions are welcome! Please feel free to submit Pull Requests or Issues.

---

**Last Updated**: 2026-04-24
