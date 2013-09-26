
submodules=`git submodule |awk '{print $2}'`

for submodulepath in $submodules; do
    git config -f .git/config --remove-section submodule.$submodulepath
    git config -f .gitmodules --remove-section submodule.$submodulepath
    git rm --cached $submodulepath
    git commit -a -m "rm $submodulepath"
    rm -rf $submodulepath
    rm -rf .git/modules/$submodulepath
done

