# preparacao-projetos

Utilizo para preparar meus projetos web.

## Instalação

Crie o diretório do projeto e entre nele.

No shell, use a linha de comando a baixo.

```bash
git clone https://github.com/andremarconi/preparacao-projetos.git && preparacao-projetos/./install.sh
```
## Instruções

Para o BrowserSync proxy com o PHP Development Server:

```
"sync": "php -S 127.0.0.1:9000 | browser-sync start --proxy '127.0.0.1:9000' -w --files 'css/*.css' '*.php'"
```
