function fish_prompt
  $GOPATH/bin/powerline-go -modules "user,host,ssh,cwd,perms,jobs,newline,git,root" -error $status -cwd-mode plain -shell bare
end
