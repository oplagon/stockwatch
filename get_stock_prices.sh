#!/bin/bash

# URL der API
url="https://api.stockdio.com/data/financial/prices/v1/getlatestprices?app-key=A26E6AECAF394857B017DBB74B100C7C&stockExchange=XETRA&symbols=SIE;ALV;SAP;BAYN;DTE"

# GET Request und Speichern der Antwort in response.txt
curl -o stock_prices.json $url

# Überprüfung des Erfolgs des Requests
if [ $? -eq 0 ]; then
  echo "Die Antwort wurde erfolgreich in stock_prices.json gespeichert."
else
  echo "Fehler beim Abrufen der Daten von der API."
fi