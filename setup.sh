cd ~ 

# Backup original user files
need_backup=true
mkdir .env_backup
if [ -f .bashrc ]; then
    echo .bashrc exists. Moving to backup...
    mv .bashrc .env_backup
    need_backup=true;
fi 
if [ -f .vimrc ]; then
    echo .vimrc exists. Moving to backup...
    mv .vimrc .env_backup
    need_backup=true
fi
if [ -d .vim ]; then
    echo .vim exists. Moving to backup...
    mv .vim .env_backup
    need_backup=true
fi
# Delete environment backup if not needed
if [ "$need_backup" = false ]; then
    echo Deleting original user files
    rm -rf .env_backup
fi

# move files to home directory
mv init-linux/.bash* .
mv init-linux/.vim* .
cd .vim/
mkdir bundle; cd bundle
git clone https://github.com/nanotech/jellybeans.vim
git clone https://github.com/vim-airline/vim-airline
cd ~
rm -rf init-linux



case "$(uname)" in
    Darwin)   echo "source ~/.bashrc" > bash_profile;; # macOS runs bash_profile on shell startup
esac

source ~/.bashrc
echo Finish setting up bash and vim env. 
echo Start downloading miniconda3...
if [ -z $(which wget) ]; then 
    echo wget not found. Installing wget...
    case "$(uname)" in
        Darwin)   brew install wget;;
        Linux)    sudo apt install wget;;
    esac
fi 
echo Done!
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
