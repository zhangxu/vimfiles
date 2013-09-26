
cwd=`pwd`
for p in bundle/*; do
    cd $p
    git pull origin master
    cd $cwd
done

