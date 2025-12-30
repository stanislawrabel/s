#!/bin/bash
set -e

# 🛠 Automatický mód
export DEBIAN_FRONTEND=noninteractive
export TERM=xterm

echo "📦 Fixing broken packages and cleaning up..."
dpkg --configure -a || true
apt --fix-broken install -y || true
apt clean

echo "📦 Updating Termux and installing dependencies..."
yes "" | pkg update -y
yes "" | pkg upgrade -y

echo "📦 Installing required packages..."
pkg install -y python python2 git tsu curl
pip install wheel
pip install pycryptodome
pip3 install --upgrade requests pycryptodome git+https://github.com/R0rt1z2/realme-ota

# 🔹 SCRIPTS & FILES
echo "📥 Downloading scripts and data files..."
REPO="https://raw.githubusercontent.com/stanislawrabel/s/main"

for file in 1.sh 2.sh 3.sh models.txt devices.txt; do
    curl -sSL "$REPO/$file" -o "$file"
done

chmod +x 1.sh 2.sh 3.sh

# Nahrádza celé bloky s aliasmi
PREFIX=${PREFIX:-/data/data/com.termux/files/usr}
mkdir -p "$PREFIX/bin"

for name in 1 2 3; do
  target="$HOME/${name}.sh"
  wrapper="$PREFIX/bin/$name"
  cat > "$wrapper" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
exec bash "$target" "\$@"
EOF
  chmod +x "$wrapper"
done
echo -e "\e[32m✅ Installation completed. Use commands: 1 | 2 | 3\e[0m"
exit
