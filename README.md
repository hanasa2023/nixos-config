<h2 align="center">:snowflake: Hanasaki's Nix Config :snowflake:</h2>

<p align="center">
</p>

<p align="center">
	<a href="https://github.com/hanasa2023/nix-config/stargazers">
		<img alt="Stargazers" src="https://img.shields.io/github/stars/hanasa2023/nix-config?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41"></a>
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-24.05-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
    <a href="https://github.com/ryan4yin/nixos-and-flakes-book">
        <img src="https://img.shields.io/static/v1?label=Nix Flakes&message=learning&style=for-the-badge&logo=nixos&color=DDB6F2&logoColor=D9E0EE&labelColor=302D41"></a>
  </a>
</p>

## How to use it?
- clone this reponsitory
```git clone https://github.com/hanasa2023/nixos-config.git ~/nixos-config```
- backup your config files
```sudo mv /etc/nixos /etc/nixos.bak```
- make a soft link
```sudo ln -s ~/nixos-config/ /etc/nixos```
- rebuild your system
```sudo nixos-rebuild switch```
