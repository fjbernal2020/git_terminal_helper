# 🚀 Git Terminal Helper
**A lightweight interactive Git helper focused on speed and daily use.**

> "Forked and remade from a script dating back to 2015 and used every day since then. Developed between March 20th and March 29th, 2026. Born in Málaga, Andalucía ☀️"

<p align="center">
  <img src="demo.gif" alt="Git Terminal Helper demo">
</p>

---

## 📖 Overview
**Git Terminal Helper** is a high-productivity Python tool that simplifies daily Git operations. It provides an interactive prompt with short aliases, index-based file/branch selection, and automatic status refreshing.

## ✨ Key Features
* **Alias-driven:** `s` (status), `p` (push), `l` (pull), `b` (branches).
* **Index selection:** Stage files using numbers (e.g., `a 1 2`) instead of paths.
* **Quick Switch:** Change or merge branches using their index (e.g., `c 2`).
* **Customizable:** Add your own shortcuts via `execs` or `uexecs`.
* **Rich UI:** Beautifully colored output for clarity.

---

## 🛠️ Quick Installation

The easiest way to install it on Linux/macOS is using the provided installer:

1. **Clone the repo:**
   ```bash
   git clone [https://github.com/youruser/git-terminal-helper.git](https://github.com/youruser/git-terminal-helper.git)
   cd git-terminal-helper

Run the installer:
    Bash

    chmod +x install.sh
    ./install.sh

That's it! Now you can just type g inside any Git repository to start the helper.
🚀 How to Use

Once installed, simply run:
Bash

g

Common Shortcuts
Key Action
s   Status: Show current status with file indexes

a <id>  Add: Stage files by their index (e.g., a 1 2)

t <msg> Commit: Git commit -m "your message"

tap <msg>   All-in-one: Commit all changes and Push

c <id>  Checkout: Switch to branch by index

help    Help: Show all commands

