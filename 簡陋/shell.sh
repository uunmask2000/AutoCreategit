#!/bin/bash
echo "安裝中..."
echo -e "Please input your path: \c" #(\c迫使游標不換行)
read path
echo "切換到 : , $path"
#專案的位置 也是git的位置
cd /home/$path   
echo 'OK\n';
 
# git 初始化
  git init
  echo 'git OK\n';
  ls -l
  echo '列清單\n';
# 跳到 .git 
  cd .git
  echo 'OK\n';
  ls -l
  echo '列清單\n';
#=========先建立檔案
  rm -f config
  echo '先清除 config\n';
  touch > config 
  echo -e "
[core]
      repositoryformatversion = 0
      filemode = true
      bare = false
      logallrefupdates = true
[receive]
      denyCurrentBranch = ignore" | tee -a config
  echo 'config 被建立\n';
#=======================
# 跳到 .git 的hooks
cd hooks
  echo  "OK\n"; 
  ls -l
  echo '列清單\n';
#=========先建立檔案
  rm -f post-receive
  echo '先清除 post-receive \n';
  cp /home/post-receive post-receive 
  echo 'cp \n';
  ls -l
  echo '列清單\n';
  chown -R root:root post-receive 
  chmod +x  post-receive
  #置換 專案路徑 
  sed -i '6,7c export DEPLOY_ROOT="/home/'$path'/"' post-receive 
  echo '取代1\n'; 
  echo 'post-receive 被建立\n';
#=======================
#跳回 專案的上一層
cd /home/
ls -l
echo '列清單\n'
#跳回 專案下的權限 與 執行力
chown -R git:root $path
chmod  755 -R git:root $path
clear 
echo '結束\n'