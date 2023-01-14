npm run build
cd .\dist
echo > .nojekyll 'nojekyll'
git init
git checkout -B main
git add -A
git commit -m 'deploy'
git push -f git@github.com:zgxkbtl/a2sVue.git main:gh-pages