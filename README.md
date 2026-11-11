# TCC - Arquitetura de Sistemas Offline-First como Amparo à Prática Veterinária

Trabalho de Conclusão de Curso em Ciência da Computação (UNIFOR), escrito em LaTeX com o modelo **UniforTeX2**, baseado no **abnTeX2**.

Este guia explica como gerar o PDF (`main.pdf`) em qualquer computador com Windows ou Linux.

## Sumário

1. [O que é preciso](#1-o-que-é-preciso)
2. [Instalação no Linux](#2-instalação-no-linux)
3. [Instalação no Windows](#3-instalação-no-windows)
4. [Como compilar](#4-como-compilar)
5. [Uso em editores](#5-uso-em-editores)
6. [Estrutura do projeto](#6-estrutura-do-projeto)
7. [Problemas comuns](#7-problemas-comuns)

## 1. O que é preciso

| Item | Para que serve |
|---|---|
| Distribuição LaTeX (TeX Live ou MiKTeX) | Compila o documento |
| Pacotes `abntex2`, `glossaries`, `algorithm2e`, `algorithms`, `tocloft`, `titlesec`, `paracol`, `picinpar`, `lipsum`, `multirow`, `appendix`, `footmisc`, `upgreek` | Usados pelo modelo e pelo texto |
| Hifenização em português e espanhol (`babel-portuges`, `babel-spanish`) | Idiomas declarados no preâmbulo |
| `latexmk` | Executa todas as etapas da compilação na ordem certa |
| Perl | Exigido pelo `latexmk` e pelo `makeglossaries` |

O compilador usado é o **pdfLaTeX** e a bibliografia é processada pelo **BibTeX** (não é preciso Biber).

## 2. Instalação no Linux

### Ubuntu, Debian, Linux Mint, Pop!_OS

```bash
sudo apt update
sudo apt install texlive-latex-base texlive-latex-recommended texlive-latex-extra \
  texlive-fonts-recommended texlive-publishers texlive-science \
  texlive-lang-portuguese texlive-lang-spanish latexmk
```

Pacote por pacote:

- `texlive-publishers`: traz o `abntex2`.
- `texlive-latex-extra`: traz `glossaries`, `tocloft`, `titlesec`, `algorithm2e` e outros.
- `texlive-science`: traz o `algorithmic` e o `upgreek`.
- `texlive-lang-portuguese` e `texlive-lang-spanish`: hifenização dos idiomas.

### Fedora

```bash
sudo dnf install texlive-scheme-full latexmk
```

### Arch Linux, Manjaro

```bash
sudo pacman -S texlive-basic texlive-latex texlive-latexrecommended texlive-latexextra \
  texlive-fontsrecommended texlive-publishers texlive-mathscience \
  texlive-langportuguese texlive-langspanish texlive-binextra
```

### Conferência

```bash
kpsewhich abntex2.cls
```

Se aparecer um caminho terminado em `abntex2.cls`, a instalação está correta. Se não aparecer nada, o pacote `abntex2` ainda não foi instalado.

## 3. Instalação no Windows

Há duas opções. A opção A é a recomendada, porque já vem com tudo, inclusive o Perl.

### Opção A: TeX Live (recomendada)

1. Baixe o instalador `install-tl-windows.exe` em <https://tug.org/texlive/windows.html>.
2. Execute e mantenha o esquema **full** (completo). A instalação ocupa cerca de 8 GB e pode levar mais de uma hora.
3. Ao final, abra um novo **Prompt de Comando** e confira:

```bat
kpsewhich abntex2.cls
latexmk -v
```

### Opção B: MiKTeX (instalação menor)

1. Instale o MiKTeX: <https://miktex.org/download>.
2. Abra o **MiKTeX Console**, vá em **Settings** e marque **Install missing packages on-the-fly: Always**. Assim os pacotes que faltarem serão baixados durante a primeira compilação.
3. Ainda no MiKTeX Console, vá em **Updates** e clique em **Check for updates** e depois em **Update now**.
4. Instale o **Strawberry Perl**: <https://strawberryperl.com>. Sem ele o `latexmk` e o `makeglossaries` não funcionam no MiKTeX.
5. Feche e abra de novo o Prompt de Comando e confira:

```bat
perl -v
latexmk -v
```

A primeira compilação no MiKTeX é mais demorada, porque os pacotes são baixados nesse momento.

## 4. Como compilar

Abra o terminal (Linux) ou o Prompt de Comando (Windows) na pasta do projeto, onde está o `main.tex`, e rode:

```bash
latexmk main.tex
```

O arquivo `.latexmkrc` da pasta já configura tudo: usa o pdfLaTeX, roda o BibTeX, gera a lista de siglas e o glossário (`makeglossaries`) e repete a compilação até as referências cruzadas ficarem corretas. O resultado é o `main.pdf`.

Comandos úteis:

| Comando | O que faz |
|---|---|
| `latexmk main.tex` | Gera o `main.pdf` |
| `latexmk -pvc main.tex` | Recompila sozinho a cada vez que um arquivo é salvo |
| `latexmk -c` | Apaga os arquivos auxiliares e mantém o PDF |
| `latexmk -C` | Apaga os arquivos auxiliares e o PDF |

### Compilação manual (sem latexmk)

Se o `latexmk` não estiver disponível, rode os comandos nesta ordem:

```bash
pdflatex main
bibtex main
makeglossaries main
makeindex main
pdflatex main
pdflatex main
```

No Windows com MiKTeX sem Perl, troque `makeglossaries main` por `makeglossaries-lite main`.

## 5. Uso em editores

O arquivo a compilar é sempre o **`main.tex`**. Os demais arquivos `.tex` são partes dele e não compilam sozinhos.

### VS Code com LaTeX Workshop

1. Instale a extensão **LaTeX Workshop**.
2. Abra a pasta do projeto (**File > Open Folder**).
3. Abra o `main.tex` e salve, ou use **Ctrl+Alt+B**. A receita padrão da extensão já usa o `latexmk` e lê o `.latexmkrc`.

### TeXstudio

1. Vá em **Opções > Configurar TeXstudio > Compilar**.
2. Em **Compilador padrão**, escolha **Latexmk**.
3. Abra o `main.tex`, clique com o botão direito na aba dele e escolha **Definir como documento raiz explícito**.
4. Compile com **F5**.

### Overleaf

1. Compacte a pasta do projeto em um arquivo `.zip`.
2. No Overleaf, clique em **New Project > Upload Project** e envie o `.zip`.
3. Em **Menu**, defina **Compiler: pdfLaTeX** e **Main document: main.tex**.

O Overleaf já tem todos os pacotes e também lê o `.latexmkrc`.

## 6. Estrutura do projeto

```
main.tex                    Arquivo principal: dados do trabalho e ordem dos capítulos
.latexmkrc                  Configuração da compilação (glossário e lista de siglas)
lib/
  preambulo.tex             Pacotes e configurações do documento
  unifortex2.sty            Estilo da UNIFOR
elementos-pre-textuais/     Resumo, abstract, agradecimentos, siglas, etc.
elementos-textuais/         Capítulos (introdução, fundamentação, metodologia, etc.)
elementos-pos-textuais/
  referencias.bib           Referências bibliográficas
  glossario.tex             Termos do glossário
  apendices/                Apêndices
  anexos/                   Anexos
figuras/                    Imagens usadas no texto
```

### Observação sobre o arquivo de referências

Nas referências com ano estimado, no formato ABNT `[2026]`, o ano deve ficar entre chaves duplas:

```bibtex
year = {{[2026]}},
```

Com chaves simples (`year = {[2026]}`), os colchetes quebram o rótulo da referência: a citação aparece como "?" no texto e o log mostra o aviso `Label ']' multiply defined`.

## 7. Problemas comuns

| Mensagem ou sintoma | Causa | Solução |
|---|---|---|
| `File 'abntex2.cls' not found` | O pacote abnTeX2 não está instalado | Linux: instale `texlive-publishers`. Windows: use o TeX Live completo ou ative a instalação automática no MiKTeX |
| `File 'glossaries.sty' not found` (ou outro `.sty`) | Falta o pacote indicado | Linux: instale `texlive-latex-extra` e `texlive-science`. MiKTeX: ative a instalação automática |
| Erro ao compilar `preambulo.tex` | O editor compilou o arquivo aberto, e não o principal | Compile o `main.tex`. Veja a seção 5 |
| Lista de siglas ou glossário vazios | O `makeglossaries` não foi executado | Use `latexmk main.tex` na pasta do projeto, ou siga a compilação manual |
| Citação aparece como "?" ou em negrito | Chave inexistente no `.bib` ou ano com colchetes simples | Confira a chave em `referencias.bib` e a observação da seção 6 |
| `perl: command not found` ou `latexmk` não abre no Windows | Perl não instalado (MiKTeX) | Instale o Strawberry Perl e reabra o terminal |
| Mudança no `.bib` não aparece no PDF | Arquivos auxiliares antigos | Rode `latexmk -C` e compile de novo |

## Licença

O modelo UniforTeX2 é distribuído sob a licença indicada no arquivo `LICENSE`.
