
# ---------------- Confis & Editor(s)
alias zshconfig='$EDITOR ~/.zshrc'
alias ohmyzshconfig='$EDITOR ~/.oh-my-zsh'
alias tmuxconfig='$EDITOR ~/.tmux.conf'
#alias vimconfig='$EDITOR ~/.vimrc'
alias nvimconfig='$EDITOR ~/.config/nvim'
alias cheatvim='cheatnvim'
alias utilsconfig='$EDITOR ~/.zshutils'
alias sc='source ~/.zshrc'

# Visual studio code
alias coden='code -n $1'
alias codediff='code -d -n $1 $2'

# ---------------- Standard CLI
alias c='clear'
alias lisap='ls -lisap'
alias lisa='ls -lisap'
alias lisah='ls -lisaph'
alias lisapgrep='ls -lisap | grep $1'
alias lspath='ls -lrt -d -1 $PWD/*'
alias lssubdir='ls -lrt -d -1 */*'
alias biggest='du -sh * | sort -nr | head -n $1'
alias sizessort='du -sh * | sort -nr'
alias sizeof='du -sh $1'
alias dfh='df -H'
alias dfht='df -HT'
alias findin='find $1 -name $2'
alias countfilesdir='find $1 -type f | wc -l'
alias grepinfiles='grep -R --color=auto "$1" .'
alias mkdirp='mkdir -p $1'
alias mkdird='() { mkdir -p "$1_$(eval "date +'%F'")" ;}'
alias mkdirs='mkdir {1..$1}'
alias chmodx='chmod +x $1'
alias rebootnow='sudo shutdown --reboot now'
alias shutdownnow='sudo shutdown now'
alias rmemptydirs='find . -type d -empty'
alias rmrfrecursive='find . -name "$1" -print0 | xargs -0 rm -rf'
alias md5filesindir='find . -type f -exec openssl md5 {} \;'
#alias printfstructure='find $1 -maxdepth $2 -type d'
    # Currently using tree for printing a folder structure

# batch renaming
alias prefix_all='for f in *; do mv $f $1$f; done'
alias lowercase_all='for f in *; do mv "$f" "$f.tmp"; mv "$f.tmp" "`echo $f | tr "[:upper:]" "[:lower:]"`"; done'
#alias rntoparentfolder_dry='for f in */* ;do fp=$(dirname "$f"); ext="${f##*.}" ; echo "$f" "$fp"/"$fp"."$ext" ;done'
#alias rntoparentfolder_x='for f in */* ;do fp=$(dirname "$f"); ext="${f##*.}" ; mv "$f" "$fp"/"$fp"."$ext" ;done'

#alias stripoutprefix='for f in *; do mv "$f" "${f#$1}"; done'
#alias stripout='for f in *; do mv "$f" "${f/$1/}"; done'
    # For those commands better use F2-tool which has a dry and execute run for more security when renaming

# ---------------- Archives
alias unrarmultip='find . -name "*.rar" -exec unar {} \;'
alias unrarmultsubdir='find . -type f -name "*.rar" -execdir unar {} \;'
alias unrarpw='unar -p $2 $1'
alias unzipsubdir='7z x $1 -o\*'
alias targz='tar -xzvf $1'
alias tartar='tar -xvf $1'
alias tarnew='tar -czvf $1 $2'
alias merge001ip='cat $1.* > $1'
alias merge001='cat $1.* > $2'

# ---------------- Tools
alias -g Z='| fzf'
alias treelvl='tree -L $1'
alias treedlvl='tree -d -L $1'
alias p10kconfig='p10k configure'
alias cp='rsync -ah --progress'
alias cp2='rsync -ah --info=progress2'
alias cpr='rsync -ahr --progress'
alias mv2='rsync -ahP --remove-source-files'
alias mv3='rsync -ah --info=progress2 --remove-source-files'

# ---------------- DEV
alias ggraph='git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all'

# ---------------- TMUX
alias tmuxkillall='tmux kill-session -a'
alias tmuxnew='tmux new -A -s $1'

# ---------------- Remote
alias ulremote='rsync -ahPe ssh -avz $1 $2@$3:/$4'
alias dlremote='rsync -ahPe ssh -avz $1@$2:/$3 $4'
alias scpcp='scp -r $1@$2:$3 $4'
alias ftpto='ncftp -u $1 -p $2 $3'
alias sshy='ssh -Y $1@$2'

# Mount
alias mountremotehome='sshfs -o follow_symlinks $1@$2:/home/$1 $mntdir/remote'
alias umountremote='umount -f $mntdir/remote'
alias mountcifsdir='mount -t cifs -o credentials=/etc/win.creds,uid=1000,gid=1000,dir_mode=0755,file_mode=0755 $1 $mntdir/cifs'