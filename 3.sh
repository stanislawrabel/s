#!/bin/bash
#

# === 🎨 COLORS ===
WHITE="\033[37m"
PURPLE="\033[35m" 
YELLOW="\033[33m"
BLUE="\033[34m"
RED="\033[31m"
BLACK="\033[30m"
WHITE="\033[37m"
GREEN="\033[32m"
YELLOW_BG="\033[43m"
GREEN_BG="\033[42m"
RED_BG="\033[41m"
RESET="\033[0m"

# === 🧠 CHECK ARIA2 ===
if ! command -v aria2c &>/dev/null; then
  echo -e "${RED}❌ aria2c not installed .${RESET}"
  echo "👉 Run: pkg install aria2c -y"
  exit 1
fi

clear

echo -e "${GREEN}+=====================================+${RESET}"
echo -e "${GREEN}|  ${RESET} ${YELLOW}    DownloadeR${RESET} & ${YELLOW}Resolver${RESET}         ${GREEN}|${RESET}"

echo -e "${GREEN}|    ${RED}         by${RESET} ${BLUE}Stano36 ${RESET}             ${GREEN}|${RESET}"
echo -e "${GREEN}+=====================================+${RESET}"                              
echo -e "${GREEN}|${RESET} ${YELLOW_BG}${BLACK}  realme   ${RESET}  ${GREEN_BG}${BLACK}  oppo  ${RESET}  ${RED_BG}${WHITE}  Oneplus  ${RESET}  ${GREEN}|${RESET}"
echo -e "${GREEN}+=====================================+${RESET}" 


# === 📁 PATHS ===
DOWNLOAD_DIR="/storage/emulated/0/Download/DownloadeR"
LOG_FILE="$DOWNLOAD_DIR/ota_downloads.log"

mkdir -p "$DOWNLOAD_DIR"

# === 🔧 CHECK DEPENDENCIES ===
for cmd in curl aria2c; do
  if ! command -v $cmd >/dev/null 2>&1; then
    echo -e "${RED}❌ Missing dependency: $cmd${RESET}"
    echo "👉 Run: pkg install $cmd -y"
    exit 1
  fi
done

# === 🔁 RESOLVE downloadCheck → ZIP ===
resolve_zip() {
  curl -s -I --http1.1 \
    -H "User-Agent: Dalvik/2.1.0 (Linux; Android 16)" \
    -H "userId: oplus-ota|16002018" \
    -H "Accept: */*" \
    -H "Accept-Encoding: identity" \
    "$1" \
  | grep -i '^location:' \
  | tail -1 \
  | awk '{print $2}' \
  | tr -d '\r'
}



while true; do
  echo
  read -p "🔗 Enter URL (ZIP or downloadCheck): " URL

  if [[ -z "$URL" || ! "$URL" =~ ^https?:// ]]; then
    echo -e "${RED}❌ Invalid URL${RESET}"
    continue
  fi

  # === 🧠 RESOLVE IF downloadCheck ===
  if [[ "$URL" == *"downloadCheck"* ]]; then
    echo -e "${YELLOW}🔄 Resolving OTA link...${RESET}"
    ZIP_URL=$(resolve_zip "$URL")

    if [[ -z "$ZIP_URL" ]]; then
      echo -e "${RED}❌ Failed to resolve ZIP link${RESET}"
      echo "⚠️ Link may be expired or region mismatch"
      continue
    fi

    URL="$ZIP_URL"
    echo -e "${GREEN}✔ ZIP resolved:${RESET}"
    echo "$URL"
  fi

  # === 🔍 QUICK CHECK ===
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$URL")
  if [[ "$STATUS" != "200" ]]; then
    echo -e "${RED}❌ Link invalid (HTTP $STATUS)${RESET}"
    continue
  fi

  # === 📄 FILE NAME ===
  FILENAME=$(basename "${URL%%\?*}")
  read -p "💾 File name [${FILENAME}]: " CUSTOM
  FILENAME="${CUSTOM:-$FILENAME}"

  echo -e "\n${BLUE}📥 Downloading...${RESET}\n"

  START=$(date '+%F %T')
  aria2c -c -x 16 -s 16 \
    -d "$DOWNLOAD_DIR" \
    -o "$FILENAME" \
    "$URL"

  if [[ $? -eq 0 ]]; then
    echo -e "${GREEN}✅ Download complete${RESET}"
    echo "[$START] OK | $FILENAME" >> "$LOG_FILE"
    echo -e "📂 Saved to: ${YELLOW}$DOWNLOAD_DIR${RESET}"
  else
    echo -e "${RED}❌ Download failed${RESET}"
    echo "[$START] FAIL | $URL" >> "$LOG_FILE"
  fi

  echo
  echo "1️⃣  Download another OTA"
  echo "0️⃣  Exit"
  read -p "➡️ Choose: " OPT

  [[ "$OPT" == "0" ]] && break
  clear
done

echo -e "\n👋 Finished. Log saved to:"
echo "$LOG_FILE"
