<h1 align="center">Fedora-Startup<h1>
<p align="center">A personal Makefile program to install some software from a fresh installation of fedora whenever I fuck up things on my OS and need to reinstall the whole fucking thing<p>

## Prerequesites:
- enable third party repositories by going to `Software > Software Repositories > Third Party Repositories` then enable all
- Make sure to update packages with 
```bash
sudo dnf update -y
```

## Download:
```bash
git clone https://github.com/Existential-nonce/Fedora-Startup
```

## Fedora software installation:
```bash 
cd Fedora-Startup/
sudo make
```