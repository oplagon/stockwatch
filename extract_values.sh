#!/bin/bash

# JSON-Antwort in einer Variable speichern
json_response='{"status":{"code":0,"message":""},"data":{"prices":{"columns":["symbol","timestamp","price"],"values":[["SIE","2025-02-19T17:30:00+01:00",220.35],["ALV","2025-02-19T17:30:00+01:00",320],["SAP","2025-02-19T17:30:00+01:00",276.3],["BAYN","2025-02-19T17:29:00+01:00",21.3],["DTE","2025-02-19T17:30:00+01:00",34.34]]}}}'

# Verwenden von jq, um das Array "values" zu extrahieren und zu durchsuchen
values=$(echo "$json_response" | jq -c '.data.prices.values[]')

# Ausgabe der Werte
echo "Extrahierte Werte:"
for value in $values; do
  echo "$value"
done