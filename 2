#!/bin/bash

# 🎨 Farby pre výstup
YELLOW="\033[33m";
BLUE="\033[34m"
RED="\033[31m"
BLACK="\033[30m"
WHITE="\033[37m"
GREEN="\033[32m"
YELLOW_BG="\033[43m"
GREEN_BG="\033[42m"
RED_BG="\033[41m"
RESET="\033[0m"

# 📌 Regióny, verzie a servery
declare -A REGIONS=(
    [00]="EX Export 00000000"
    [A4]="APC Global 10100100"
    [A5]="OCA Oce_Cen_Australia 10100101"
    [A6]="MEA Middle_East_Africa 10100110"
    [A7]="ROW Global 10100111"  
    [1A]="TW Taiwan 00011010" 
    [1B]="IN India 00011011"
    [1E]="AU Australia 00011110"
    [2C]="SG Singapure 00101100"
    [3B]="JP Japan 00111011" 
    [3C]="VN Vietnam 00111100" 
    [3E]="PH Philippines 00111110"
    [33]="ID Indonesia 00110011" 
    [37]="RU Russia 00110111" 
    [38]="MY Malaysia 00111000"
    [39]="TH Thailand 00111001" 
    [44]="EUEX Europe 01000100" 
    [5A]="KZ Kazakhstan 01011010"
    [51]="TR Turkey 01010001"
    [7B]="MX Mexico 01111011" 
    [75]="EG Egypt 01110101" 
    [8D]="EU-NO Europe_Non_GDPR 10001101"
    [82]="HK Hong_Kong 10000010"
    [83]="SA Saudi_Arabia 10000011" 
    [9A]="LATAM Latin_America 10011010" 
    [9E]="BR Brazil 10011110"
    [97]="CN China 10010111"
)


declare -A VERSIONS=(
  [A]="Launch version" 
  [C]="First update" 
  [F]="Second update" 
  [H]="Third update"
)
declare -A SERVERS=(
  [97]="-r 1" 
  [44]="-r 0" 
  [51]="-r 0"
)

declare -A MODEL_NAMES
while IFS='|' read -r code name; do
MODEL_NAMES["$code"]="$name"
done < models.txt
# Načítanie názvov modelov
declare -A MODEL_NAMES
[[ -f models.txt ]] && while IFS='|' read -r code name; do
  MODEL_NAMES["$code"]="$name"
done < models.txt

# 🔧 Funkcia na generovanie variánt modelu
generate_model_variants() {
  local base_model="$1"
  local region="$2"
  local variants=()

  case "$region" in
    44) # EEA: iba základný model a EEA
      variants+=("$base_model" "${base_model}EEA")
      ;;
    37) variants+=("$base_model" "${base_model}RU") ;;
    51) variants+=("$base_model" "${base_model}TR") ;;
    1B) variants+=("$base_model" "${base_model}IN") ;;
    33|38|39|3E) variants+=("$base_model" "${base_model}T2") ;;
    *) variants+=("$base_model") ;;
  esac

  echo "${variants[@]}"
}
# 🛠️ Funkcia na spustenie OTA pre model/variant/region
run_ota() {
  local device_model="$1"
  local version="$2"
  local region="$3"

  region_data=(${REGIONS[$region]})
    region_code=${region_data[0]}
    region_name=${region_data[1]}
    nv_id=${region_data[2]}
  server="${SERVERS[$region]:--r 3}"

  clean_model=$(echo "$device_model" | sed 's/IN\|RU\|TR\|EEA\|T2//g')
  base_model="$clean_model"

  ota_command="realme-ota $server $device_model ${base_model}_11.${version}.01_0001_100001010000 6 $nv_id"
#  echo -e "🔍 I run the command: ${BLUE}$ota_command${RESET}"
  output=$(eval "$ota_command")
  
  real_ota_version=$(echo "$output" | grep -o '"realOtaVersion": *"[^"]*"' | cut -d '"' -f4)
  [[ -z "$real_ota_version" ]] && return

  # Spracovanie údajov
    real_ota_version=$(echo "$output" | grep -o '"realOtaVersion": *"[^"]*"' | cut -d '"' -f4)
    real_version_name=$(echo "$output" | grep -o '"realVersionName": *"[^"]*"' | cut -d '"' -f4)
    os_version=$(echo "$output" | grep -o '"realOsVersion": *"[^"]*"' | cut -d '"' -f4)
    android_version=$(echo "$output" | grep -o '"realAndroidVersion": *"[^"]*"' | cut -d '"' -f4)
    security_os=$(echo "$output" | grep -o '"securityPatchVendor": *"[^"]*"' | cut -d '"' -f4)
    ota_f_version=$(echo "$real_ota_version" | grep -oE '_11\.[A-Z]\.[0-9]+' | sed 's/_11\.//')
    ota_date=$(echo "$real_ota_version" | grep -oE '_[0-9]{12}$' | tr -d '_')
    ota_version_full="${device_model}_11.${ota_f_version}_${region_code}_${ota_date}"

grep -qF "$modified_link" ota_links.csv || echo "$ota_version_full,$modified_link" >> ota_links.csv
# Získať URL k About this update
    about_update_url=$(echo "$output" | grep -oP '"panelUrl"\s*:\s*"\K[^"]+')

# Získať VersionTypeId
    version_type_id=$(echo "$output" | grep -oP '"versionTypeId"\s*:\s*"\K[^"]+')

# 🟡 Extrahuj celý obsah poľa "header" z JSON výstupu
header_block=$(echo "$output" | sed -n '/"header"\s*:/,/]/p' | tr -d '\n' | sed -E 's/.*"header"[[:space:]]*:[[:space:]]*([^]+).*/\1/')
# 🔍 Skontroluj obsah poľa na výskyt hodnoty
if echo "$header_block" | grep -q 'forbid_ota_local_update=true'; then
    forbid_status="${RED}❌ Forbidden${RESET}"
elif echo "$header_block" | grep -q 'forbid_ota_local_update=false'; then
    forbid_status="${GREEN}✔️ Allowed${RESET}"
else
    forbid_status="${YELLOW}❓ Unknown${RESET}"
fi




clean_model=$(echo "$device_model" | sed 's/IN\|EEA\|RU\|TR\|T2//g')
model_name="${MODEL_NAMES[$clean_model]}"



# 📋 Výpis ako tabuľka 
echo -e
echo -e
echo -e
echo -e "${YELLOW}$ota_version_full${RESET}"
echo -e "${YELLOW}$real_version_name${RESET}"
echo -e "${YELLOW}$android_version${RESET}"
echo -e "${YELLOW}$os_version${RESET}"
echo -e "${YELLOW}$security_os${RESET}"
echo -e "${YELLOW}$version_type_id${RESET}"
echo -e "Local install:" "$forbid_status"
echo -e

    echo -e "  📥                About this update: 
${GREEN}$about_update_url${RESET}"
  

    download_link=$(echo "$output" | grep -o 'http[s]*://[^"]*' | head -n 1 | sed 's/["\r\n]*$//')
    modified_link=$(echo "$download_link" | sed 's/componentotamanual/componentotamanual/g')

        # Dynamická úprava linku podľa servera
#    host=$(echo "$download_link" | sed -E 's#https?://([^/]+).*#\1#')
#    domain_suffix=${host#*.}
#    server_id=$(echo "$server" | grep -o '[0-9]\+' || echo "3")

    case "$server_id" in
        3) server_code="eu" ;;
        2) server_code="in" ;;
        1) server_code="cn" ;;
        0) server_code="sg" ;;
        *) server_code="eu" ;;
    esac

 #   new_label="gauss-opexcostmanual"
    [[ -n "$server_code" ]] && new_label="${new_label}-${server_code}"
    modified_host="${new_label}.${domain_suffix}"
    modified_link="${download_link/$host/$modified_host}"


    if [[ -n "$modified_link" ]]; then
        echo -e "  📥                  Download link: 
${GREEN}$modified_link${RESET}"

else
    echo -e "❌ No download link found."
 fi   

    echo "$ota_version_f)ull" >> "ota_${device_model}.txt"
    echo "$modified_link)" >> "ota_${device_model}.txt"
    echo "" >> "ota_${device_model}.txt"

    [[ ! -f ota_links.csv ]] && echo "OTA verzia,Odkaz" > ota_links.csv
    grep -qF "$modified_link" ota_links.csv || echo "$ota_version_full,$modified_link" >> ota_links.csv
}

# 🔁 Vyhľadanie OTA pre všetky regióny
run_ota_all_regions() {
  local model="$1"
  local version="$2"

  for region in "${!REGIONS[@]}"; do
    variants=$(generate_model_variants "$model" "$region")
    for variant in $variants; do
      run_ota "$variant" "$version" "$region"
    done
  done
}

# 📌 Výber prefixu a modelu
clear

echo -e "${GREEN}+=====================================+${RESET}"
echo -e "${GREEN}|==${RESET}  ${GREEN}Share OTA links${RESET}  ${RED}by${RESET} ${BLUE}Stano36${RESET}    ${GREEN}==|${RESET}"
echo -e "${GREEN}+=====================================+${RESET}"

echo -e "${GREEN}|${RESET} ${YELLOW_BG}${BLACK}  realme   ${RESET} ${GREEN_BG}${BLACK}   oppo   ${RESET} ${RED_BG}${WHITE}  OnePlus   ${RESET} ${GREEN}|${RESET}"



# Výpis tabuľky
for key in "${!REGIONS[@]}"; do
    region_data=(${REGIONS[$key]})
    region_code=${region_data[0]}
    region_name=${region_data[1]}


done



echo -e "${GREEN}+=====================================+${RESET}"
echo -e "${GREEN}|==${RESET}" "OTA version :  ${BLUE}A${RESET} ,  ${BLUE}C${RESET} ,  ${BLUE}F${RESET} ,  ${BLUE}H${RESET}"      "${GREEN}==|${RESET}"
echo -e "${GREEN}+=====================================+${RESET}"
  # 📦 Výber prefixu
echo -e "📦 Model: ${YELLOW}1) RMX${RESET},  ${GREEN}2) CPH${RESET},  ${BLUE}3) Custom${RESET}"
read -p "💡 Select an option (1/2/3): " choice

case "$choice" in
  1) COLOR=$YELLOW; prefix="RMX" ;;
  2) COLOR=$GREEN; prefix="CPH" ;;
  3)
     read -p "🧩 Enter your custom prefix (e.g. XYZ): " prefix
     [[ -z "$prefix" ]] && { echo "❌ Prefix cannot be empty."; exit 1; }
     ;;
  *) echo "❌ Invalid choice."; exit 1 ;;
esac

# 🔍 Vyhľadávanie podľa názvu zariadenia
read -p "🔍 Search model by name:" search_name
if [[ -n "$search_name" ]]; then
  matches=$(grep -i "$search_name" models.txt)
  if [[ -z "$matches" ]]; then
    echo "❌ No matching models found for '$search_name'."
    exit 1
  fi

  echo -e "\n📋 Found models:"
  mapfile -t match_array < <(echo "$matches")

  for i in "${!match_array[@]}"; do
    IFS='|' read -r codes name <<< "${match_array[$i]}"
    echo -e "${YELLOW}$((i+1)).${RESET} 🟢 ${GREEN}${name}${RESET} → ${BLUE}$(echo "$codes" | xargs)${RESET}"
  done

  echo
  read -p "🔢 Select model number (1-${#match_array[@]}): " model_choice

  if ! [[ "$model_choice" =~ ^[0-9]+$ ]] || (( model_choice < 1 || model_choice > ${#match_array[@]} )); then
    echo "❌ Invalid choice."
    exit 1
  fi

  # 📦 Získaj vybraný model
  IFS='|' read -r codes name <<< "${match_array[$((model_choice-1))]}"
  model_name=$(echo "$name" | xargs)
  IFS=',' read -ra model_variants <<< "$(echo "$codes" | xargs)"

  echo -e "\n✅ Selected device: ${GREEN}${model_name}${RESET}"
  echo -e "📦 Variants: ${YELLOW}${model_variants[*]}${RESET}"
else
  read -p "🔢 Enter model number : " model_number
  device_model="${prefix}${model_number}"
  model_name="${MODEL_NAMES[$device_model]}"
  echo -e "✅ Selected model: ${GREEN}${model_name:-Unknown}${RESET}  (${YELLOW}$device_model${RESET})"
  model_variants=("$device_model")
fi

# 🧩 Zadanie OTA verzie
read -p "🧩 Enter OTA version: " version_input
version="${version_input^^}"

# 🚀 Spustenie vyhľadávania pre všetky varianty
for variant in "${model_variants[@]}"; do
  echo -e "\n🔍 Searching OTA for ${YELLOW}$variant${RESET} ..."
  run_ota_all_regions "$variant" "$version"
done

# 🔁 Cyklus pre ďalšie voľby
while true; do
    echo -e "\n🔄 1 - Change OTA version"
    echo -e "🔄 2 - Change device model"
    echo -e "❌ 3 - End script"
    echo

    read -p "💡 Select an option (1/2/3): " option

    case "$option" in
        1)
            echo
            read -p "🧩 Enter OTA version (A/C/F/H): " version
            version=$(echo "$version" | tr '[:lower:]' '[:upper:]')  # prevod na veľké písmená

            if [[ -z "$version" || ! "$version" =~ ^[ACFH]$ ]]; then
                echo -e "${RED}❌ Invalid OTA version.${RESET}"
                continue
            fi

            echo -e "\n🔍 Searching OTA for ${GREEN}$selected_model${RESET} (version ${YELLOW}$version${RESET}) ..."
            run_ota_all_regions "$selected_model" "$version"
            ;;
        2)
            echo -e "\n🔁 Restarting to select new device..."
            bash "$0"
            exit 0
            ;;
        3)
            echo -e "👋 Goodbye."
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid option.${RESET}"
            ;;
    esac
done
