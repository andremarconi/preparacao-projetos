#!/usr/bin/env bash

DIR_ATUAL=${PWD##*/}
DIR_REPO='preparacao-projetos'

read -p "Você deseja configurar o projeto no diretório $DIR_ATUAL? [S]im ou [N]ão " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Ss]$ ]]
  then
  [[ "$0" = "$BASH_SOURCE" ]] && exit 0 || return 0
fi

echo "Criando estrutura do projeto de desenvolvimento."

    mv $DIR_REPO/.gitignore .gitignore
    mv $DIR_REPO/.prettierrc .prettierrc
    mv $DIR_REPO/.vscode .vscode
    mv $DIR_REPO/.eslintrc.json .eslintrc.json

read -p "Qual projeto você vai instalar em $DIR_ATUAL: [W]ebpack ou [S]CSS Sync? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Ww]$ ]]
  then

    echo "Criando os diretórios e arquivos para o Webpack."
    mkdir -p app/assets/{images,styles/{base,modules},scripts}
    touch app/assets/styles/styles.scss
    mv $DIR_REPO/app.js app/assets/scripts/app.js
    mv $DIR_REPO/index-webpack.html app/index.html
    mv $DIR_REPO/package-webpack.json package.json
    mv $DIR_REPO/webpack.config.js webpack.config.js
    echo "Arquivos criados."

    echo "Instalando pacotes npm."
    npm install webpack webpack-cli webpack-dev-server css-loader sass sass-loader style-loader --save-dev
    npm install normalize.css
    echo "Pacotes instalados."

    echo "Building the project."
    npm run build
    echo "Projeto inicial construído."

    echo "Removendo diretório $DIR_REPO"
    rm -rf $DIR_REPO
    echo "Diretório removido"

    echo "Estrutura do projeto usando Webpack foi criado."
    exit 0

  else

    if [[ ! $REPLY =~ ^[Ss]$ ]]
      then
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
        # handle exits from shell or function but don't exit interactive shell
    fi
fi

echo "Criando os diretórios para o SyncBrowser e SCSS."
mkdir -p {css,js,images,scss/{base,modules}}
touch scss/source.scss
mv $DIR_REPO/index-scss.html index.html

read -p "O projeto SCSS Sync é sem proxy? [S]im ou [N]ão: " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Ss]$ ]]
  then

    echo "Renomeando arquivo package-scss.json para package.json."
    mv $DIR_REPO/package-scss.json package.json
    echo "Arquivo renomeado."

  else
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
      [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
      # handle exits from shell or function but don't exit interactive shell
    fi
fi
if [[ $REPLY =~ ^[Nn]$ ]]
  then
    echo "Renomeando arquivo package-proxy.json para package.json."
    mv $DIR_REPO/package-proxy.json package.json
    echo "Arquivo renomeado."

fi
    echo "Instalando pacotes npm."
    npm install browser-sync npm-run-all prettier sass --save-dev
    echo "Pacotes instalados."

    echo "Removendo diretório $DIR_REPO"
    rm -rf $DIR_REPO
    echo "Diretório removido"

    echo "Estrutura do projeto usando SyncBrowser e SCSS criado."
    exit 0

#END
