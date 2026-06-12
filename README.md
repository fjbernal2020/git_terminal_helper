# 🚀 Git Terminal Helper
**A lightweight interactive Git helper focused on speed and daily use.**

> "Forked and remade from a script dating back to 2015 and used every day since then. Developed between March 20th and March 29th, 2026. Born in Málaga, Andalucía ☀️"

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


# 🚀 Git Terminal Helper
**A refined, lightning-fast interactive shell for Git workflows.**

# Forked and remade from a script dating back to 2015 and used every day since then.
# Developed between March 20th and March 29th, 2026.
# Born in Málaga, Andalucía ☀️

---

## 📖 Overview
**Git Terminal Helper** is a powerful Python-based wrapper designed to bridge the gap between complex Git commands and developer productivity. It provides an interactive prompt with short aliases, index-based file selection, and automatic status refreshing.

This project is the 2026 "remake" of a personal tool used daily for over a decade, now modernized with advanced CLI features.

## ✨ Key Features
* **Alias-driven workflow:** Use `s` for status, `p` for push, `l` for pull, and more.
* **Index-based selection:** Add or restore files using numbers (e.g., `a 1 3 5`) instead of typing long paths.
* **Smart Branching:** Switch or merge branches using their list index.
* **Custom Commands:** Easily add your own shortcuts via the `gkeys` or `ukeys` configuration files.
* **Persistent History:** Full command history during your session thanks to `prompt_toolkit`.
* **Rich UI:** Beautifully colored output for better readability.

## 🛠️ Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/youruser/git-terminal-helper.git](https://github.com/youruser/git-terminal-helper.git)
   cd git-terminal-helper


   # 🚀 Git Terminal Helper
**A refined, interactive CLI wrapper for lightning-fast Git workflows.**

> "Forked and remade from a script dating back to 2015 and used every day since then. Developed between March 20th and March 29th, 2026. Born in Málaga, Andalucía ☀️"
<p align="center">
  <img src="demo.gif" alt="Git Terminal Helper demo">
</p>


---

## 📖 Overview
**Git Terminal Helper** is a high-productivity Python tool designed to simplify daily Git operations. It provides an interactive prompt with short aliases, index-based file/branch selection, and automatic status refreshing.

This 2026 version is a complete refactor of a decade-old tool, now leveraging modern Python libraries for a superior terminal experience.

## ✨ Key Features
* **Alias-driven workflow:** Use `s` for status, `p` for push, `l` for pull, etc.
* **Index-based selection:** Add or restore files using numbers (e.g., `a 1 3 5`) instead of typing long paths.
* **Smart Branching:** Switch or merge branches using their list index (e.g., `c 2`).
* **Custom Commands:** Add your own shortcuts via `execs` or `uexecs` config files.
* **Persistent History:** Full command history during your session.
* **Rich UI:** Beautifully colored output for better readability.

---

## 🛠️ Installation & Setup

### 1. Requirements
Ensure you have **Python 3.10+** installed. The script depends on two main libraries:
* `rich` (for terminal formatting)
* `prompt_toolkit` (for the interactive shell and history)

### 2. Install Dependencies
You can install them via pip:
```bash
pip install rich prompt_toolkit
