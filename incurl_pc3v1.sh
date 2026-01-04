#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

REPO="https://raw.githubusercontent.com/stanislawrabel/s/main"
OTA_REPO="https://github.com/R0rt1z2/realme-ota.git"

# 🔍 DETEKCIA TERMUXU
if [[ -n "$TERMUX_VERSION" ]] || [[ "$PREFIX" == *com.termux* ]]; then
    IS_TERMUX=1
    INSTALL_DIR="$HOME/realme-ota"
    BIN_DIR="$PREFIX/bin"
    SHELL_PATH="$PREFIX/bin/bash"
else
    IS_TERMUX=0
    INSTALL_DIR="$HOME/realme-ota"
    BIN_DIR="$HOME/.local/bin"
    SHELL_PATH="/bin/bash"
fi

mkdir -p "$BIN_DIR"

echo "📦 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing dependencies..."
sudo apt install -y python3 python3-pip python3-venv git curl nano

echo "📥 Cloning realme-ota..."
if [ ! -d "$INSTALL_DIR" ]; then
    git clone "$OTA_REPO" "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip wheel
pip install .

# 🔹 DOWNLOAD SCRIPTS
echo "📥 Downloading OTA downloader script and data..."
curl -sSL "$REPO/1.sh" -o "$INSTALL_DIR/1.sh"
curl -sSL "$REPO/2.sh" -o "$INSTALL_DIR/2.sh"
curl -sSL "$REPO/3.sh" -o "$INSTALL_DIR/3.sh"
curl -sSL "$REPO/models.txt" -o "$INSTALL_DIR/models.txt"
curl -sSL "$REPO/devices.txt" -o "$INSTALL_DIR/devices.txt"
chmod +x "$INSTALL_DIR/"*.sh

# 🔹 CREATE WRAPPERS
echo "⚙️ Creating launcher commands..."

for name in 1 2 3; do
  wrapper="$BIN_DIR/$name"
  cat > "$wrapper" <<EOF
#!$SHELL_PATH
exec bash "$INSTALL_DIR/${name}.sh" "\$@"
EOF
  chmod +x "$wrapper"
done

echo -e "\n\e[32m✅ Installation completed.\e[0m"
echo -e "➡️ Run tools using:  \e[33mo\e[0m | \e[33ms\e[0m | \e[33md\e[0m"
echo ""
exi
