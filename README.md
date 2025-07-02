# 🔥 Metasploit Mini Pro — Termux Based

A lightweight Metasploit-based framework for Termux that includes:

- 🔍 Vulnerability Scanner  
- 🛠️ Exploit Information  
- 💣 Payload Generator (APK/EXE/Script)  
- 🎧 Listener (with Ngrok support possible)  
- 🧠 Post-Exploitation Commands  

---

## 🚀 Features

- ✅ Easy-to-use Menu Interface  
- ✅ Fast Vulnerability Scanner (Nmap)  
- ✅ Payload Creator for Android, Windows, Python, Bash  
- ✅ Supports Metasploit Listener  
- ✅ Post-Exploitation Toolkit (Meterpreter Commands Reference)  
- ✅ Runs on Rootless Android (with Ngrok/Cloudflare for listener)  

---

## 🛠️ Requirements

- Termux App (Latest Version)  
- Git  
- Nmap  
- Metasploit Framework  
- (Optional) Ngrok for Port Forwarding  

---

## 🔥 Installation

```bash
pkg update && pkg upgrade -y
pkg install git nmap wget curl -y
pkg install unstable-repo
pkg install metasploit -y

git clone https://github.com/CCU-BNCC/Metasploit-Mini.git
cd Metasploit-Mini
chmod +x metasploit-mini.sh
bash metasploit-mini.sh
