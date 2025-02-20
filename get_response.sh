#!/bin/bash

# URL der API, zu der die Anfrage gesendet werden soll
url="https://api.stockdio.com/data/financial/prices/v1/getlatestprices?app-key=A26E6AECAF394857B017DBB74B100C7C&stockExchange=XETRA&symbols=SIE;ALV;SAP;BAYN;DTE"

# Senden der GET-Anfrage mit curl und Speichern der Antwort in einer Variablen
response=$(curl -s -X GET "$url")

# Anzeigen der Antwort
echo "Antwort von der API:"
echo "$response"
echo -e "\n\n"


# Verwenden von jq, um das Array "values" zu extrahieren und zu durchsuchen
values=$(echo "$response" | jq -c '.data.prices.values')

echo "Values:"
echo "$values"
echo -e "\n\n"

# Deklarieren des verschachtelten assoziativen Arrays
declare -A associative_array

# Verwenden von jq, um das JSON zu parsen und in das verschachtelte assoziative Array zu konvertieren
while IFS= read -r line; do
  key=$(echo "$line" | jq -r '.[0]')
  value1=$(echo "$line" | jq -r '.[1]')
  value2=$(echo "$line" | jq -r '.[2]')
  associative_array["$key,0"]="$value1"
  associative_array["$key,1"]="$value2"
done < <(echo "$values" | jq -c '.[]')

# Ausgabe des verschachtelten assoziativen Arrays
for key in "${!associative_array[@]}"; do
  main_key="${key%,*}"
  sub_key="${key#*,}"
  echo "${main_key}[${sub_key}]: ${associative_array[$key]}"
done

# Ausgabe der Werte
#echo "Extrahierte Werte:"
#for value in $values; do
#  echo "$value"
#done