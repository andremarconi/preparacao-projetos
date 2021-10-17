#!/usr/bin/env bash

echo "Criando estrutura do projeto de desenvolvimento."

# echo "Clonando o repositório com os arquivos do projeto"
# git clone https://github.com/andremarconi/preparacao-projetos.git
# echo "Repositório clonado."
# echo "Entrando no diretório."
# cd preparacao-projetos

echo "Removendo o diretório .git."
rm -rf .git
echo "Diretório removido."

read -p "Qual projeto você vai instalar: [W]ebpack ou [S]CSS Sync? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Ww]$ ]]
  then

    echo "Criando os diretórios e arquivos para o Webpack."
    mkdir -p app/assets/{images,styles/{base,modules},scripts}
    touch app/assets/styles/styles.scss
    echo "Diretórios app/assets/{images,styles/{base,modules},scripts e arquivos criados."

    echo "Movendo arquivo app.js para o diretório scripts e index.html para o
    diretório app."
    mv app.js app/assets/scripts/app.js
    mv index-webpack.html app/index.html
    echo "Arquivos movidos."

    echo "Renomeando arquivo package-webpack.json para package.json."
    mv package-webpack.json package.json
    echo "Arquivo renomeado."

    echo "Removendo arquivos desnecessários."
    rm package-proxy.json package-scss.json index-scss.html
    echo "Arquivos removidos."

    echo "Instalando pacotes npm."
    npm install webpack webpack-cli webpack-dev-server css-loader sass sass-loader style-loader --save-dev
    npm install normalize.css
    echo "Pacotes instalados."

    echo "Building the project."
    npm run build
    echo "Projeto inicial construído."

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
echo "Diretório scss{base,modules},css,js,images criados."

echo "Criando os arquivos."
touch scss/source.scss
mv index-scss.html index.html
echo "Arquivos index.html e scss/source.scss criados."

read -p "O projeto SCSS Sync é sem proxy? [S]im ou [N]ão: " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Ss]$ ]]
  then
    
    echo "Renomeando arquivo package-scss.json para package.json."
    mv package-scss.json package.json
    echo "Arquivo renomeado."

    echo "Removendo arquivos desnecessários."
    rm package-proxy.json package-webpack.json index-webpack.html app.js webpack.config.js
    echo "Arquivos removidos."
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
    mv package-proxy.json package.json
    echo "Arquivo renomeado."

    echo "Removendo arquivos desnecessários."
    rm package-scss.json package-webpack.json index-webpack.html app.js webpack.config.js
    echo "Arquivos removidos."
fi
    echo "Instalando pacotes npm."
    npm install browser-sync npm-run-all prettier sass --save-dev
    echo "Pacotes instalados."

    echo "Estrutura do projeto usando SyncBrowser e SCSS criado."
    exit 0


#END
