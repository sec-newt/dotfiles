#!/bin/bash

# Git Repository Management Functions
# Source this file in your .bashrc or .zshrc for easy access
# Usage: source ~/.config/shell/git-repo-functions.sh

# Color codes for output
export GIT_REPO_RED='\033[0;31m'
export GIT_REPO_GREEN='\033[0;32m'
export GIT_REPO_YELLOW='\033[1;33m'
export GIT_REPO_BLUE='\033[0;34m'
export GIT_REPO_NC='\033[0m'

# Repository paths
export SCRIPTS_REPO="/home/nk/Scripts"
export HYPR_REPO="/home/nk/.config/hypr"
export OBSIDIAN_REPO="/home/nk/Obsidian"

# Function: Check all repository status
repos-status() {
    echo -e "${GIT_REPO_BLUE}Running comprehensive repository status check...${GIT_REPO_NC}"
    /home/nk/Scripts/Bash/check-all-repos.sh
}

# Function: Backup all repositories
repos-backup() {
    echo -e "${GIT_REPO_BLUE}Running comprehensive repository backup...${GIT_REPO_NC}"
    /home/nk/Scripts/Bash/backup-all-repos.sh
}

# Function: Quick status check for specific repo
repo-status() {
    local repo="$1"
    case "$repo" in
        "scripts"|"s")
            echo -e "${GIT_REPO_BLUE}Scripts Repository Status:${GIT_REPO_NC}"
            cd "$SCRIPTS_REPO" && git status
            ;;
        "hypr"|"h")
            echo -e "${GIT_REPO_BLUE}Hypr Configuration Status:${GIT_REPO_NC}"
            cd "$HYPR_REPO" && git status
            ;;
        "obsidian"|"wiki"|"o"|"w")
            echo -e "${GIT_REPO_BLUE}Obsidian Wiki Status:${GIT_REPO_NC}"
            cd "$OBSIDIAN_REPO" && git status
            ;;
        *)
            echo -e "${GIT_REPO_YELLOW}Usage: repo-status [scripts|hypr|obsidian]${GIT_REPO_NC}"
            echo "Shortcuts: s, h, o/w"
            ;;
    esac
}

# Function: Quick commit for specific repo
repo-commit() {
    local repo="$1"
    local message="$2"
    
    if [ -z "$message" ]; then
        message="chore: quick update $(date '+%Y-%m-%d %H:%M')"
    fi
    
    case "$repo" in
        "scripts"|"s")
            echo -e "${GIT_REPO_BLUE}Committing Scripts changes...${GIT_REPO_NC}"
            cd "$SCRIPTS_REPO" && git add . && git commit -m "$message" && git push
            ;;
        "hypr"|"h")
            echo -e "${GIT_REPO_BLUE}Committing Hypr configuration changes...${GIT_REPO_NC}"
            cd "$HYPR_REPO" && git add . && git commit -m "config: $message" && git push
            ;;
        "obsidian"|"wiki"|"o"|"w")
            echo -e "${GIT_REPO_BLUE}Committing Obsidian wiki changes...${GIT_REPO_NC}"
            cd "$OBSIDIAN_REPO" && git add . && git commit -m "docs: $message" && git push
            ;;
        *)
            echo -e "${GIT_REPO_YELLOW}Usage: repo-commit [scripts|hypr|obsidian] [optional-message]${GIT_REPO_NC}"
            echo "Shortcuts: s, h, o/w"
            ;;
    esac
}

# Function: View recent commits for all repos
repos-log() {
    echo -e "${GIT_REPO_BLUE}=== Recent Commits - All Repositories ===${GIT_REPO_NC}"
    
    echo -e "\n${GIT_REPO_GREEN}Scripts Repository:${GIT_REPO_NC}"
    cd "$SCRIPTS_REPO" && git log --oneline -5
    
    echo -e "\n${GIT_REPO_GREEN}Hypr Configuration:${GIT_REPO_NC}"
    cd "$HYPR_REPO" && git log --oneline -5
    
    echo -e "\n${GIT_REPO_GREEN}Obsidian Wiki:${GIT_REPO_NC}"
    cd "$OBSIDIAN_REPO" && git log --oneline -5
}

# Function: Check remote connectivity
repos-remote() {
    echo -e "${GIT_REPO_BLUE}=== Remote Repository Status ===${GIT_REPO_NC}"
    
    echo -e "\n${GIT_REPO_GREEN}Scripts:${GIT_REPO_NC}"
    cd "$SCRIPTS_REPO" && git remote -v
    
    echo -e "\n${GIT_REPO_GREEN}Hypr Config:${GIT_REPO_NC}"
    cd "$HYPR_REPO" && git remote -v
    
    echo -e "\n${GIT_REPO_GREEN}Obsidian Wiki:${GIT_REPO_NC}"
    cd "$OBSIDIAN_REPO" && git remote -v
    
    echo -e "\n${GIT_REPO_BLUE}=== Remote Repository Files ===${GIT_REPO_NC}"
    ls -la /home/nk/Jsync/*.git 2>/dev/null | grep "\.git$"
}

# Function: Navigate to repository
repo-cd() {
    local repo="$1"
    case "$repo" in
        "scripts"|"s")
            echo -e "${GIT_REPO_BLUE}Navigating to Scripts repository...${GIT_REPO_NC}"
            cd "$SCRIPTS_REPO"
            ;;
        "hypr"|"h")
            echo -e "${GIT_REPO_BLUE}Navigating to Hypr configuration...${GIT_REPO_NC}"
            cd "$HYPR_REPO"
            ;;
        "obsidian"|"wiki"|"o"|"w")
            echo -e "${GIT_REPO_BLUE}Navigating to Obsidian wiki...${GIT_REPO_NC}"
            cd "$OBSIDIAN_REPO"
            ;;
        *)
            echo -e "${GIT_REPO_YELLOW}Usage: repo-cd [scripts|hypr|obsidian]${GIT_REPO_NC}"
            echo "Shortcuts: s, h, o/w"
            return 1
            ;;
    esac
    pwd
}

# Function: Show help for all git repo functions
repos-help() {
    echo -e "${GIT_REPO_BLUE}Git Repository Management Functions:${GIT_REPO_NC}"
    echo
    echo -e "${GIT_REPO_GREEN}repos-status${GIT_REPO_NC}              Check status of all repositories"
    echo -e "${GIT_REPO_GREEN}repos-backup${GIT_REPO_NC}              Backup all repositories"
    echo -e "${GIT_REPO_GREEN}repos-log${GIT_REPO_NC}                 Show recent commits for all repos"
    echo -e "${GIT_REPO_GREEN}repos-remote${GIT_REPO_NC}              Check remote connectivity"
    echo
    echo -e "${GIT_REPO_GREEN}repo-status [repo]${GIT_REPO_NC}        Check specific repository status"
    echo -e "${GIT_REPO_GREEN}repo-commit [repo] [msg]${GIT_REPO_NC}   Commit changes to specific repository"
    echo -e "${GIT_REPO_GREEN}repo-cd [repo]${GIT_REPO_NC}            Navigate to specific repository"
    echo
    echo -e "${GIT_REPO_YELLOW}Repository shortcuts:${GIT_REPO_NC}"
    echo "  scripts, s     - Scripts repository"
    echo "  hypr, h        - Hypr configuration"
    echo "  obsidian, o, w - Obsidian wiki"
    echo
    echo -e "${GIT_REPO_BLUE}Examples:${GIT_REPO_NC}"
    echo "  repos-status"
    echo "  repo-status s"
    echo "  repo-commit h 'Updated accessibility keybindings'"
    echo "  repo-cd o"
}

# Aliases for convenience
alias grs='repos-status'
alias grb='repos-backup' 
alias grl='repos-log'
alias grr='repos-remote'
alias grh='repos-help'

echo -e "${GIT_REPO_GREEN}Git repository management functions loaded!${GIT_REPO_NC}"
echo -e "Type ${GIT_REPO_BLUE}repos-help${GIT_REPO_NC} to see available commands."
