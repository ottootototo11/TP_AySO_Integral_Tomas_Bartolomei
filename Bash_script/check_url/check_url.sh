#!/bin/bash

LISTA="$(dirname "$0")/Lista_URL.txt"
LOG="$(dirname "$0")/resultado_urls.log"

if [[ ! -f "$LISTA" ]]; then
    echo "ERROR: No se encuentra $LISTA"
    exit 1
fi

> "$LOG"
echo "=====================================" | tee -a "$LOG"
echo " Chequeo de URLs - $(date)"           | tee -a "$LOG"
echo "=====================================" | tee -a "$LOG"

while IFS= read -r url || [[ -n "$url" ]]; do
    [[ "$url" =~ ^#.*$ || -z "$url" ]] && continue

    HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" --max-time 5 "$url")

    if [[ "$HTTP_CODE" == "200" ]]; then
        echo "✔ OK    [$HTTP_CODE] $url" | tee -a "$LOG"
    else
        echo "✘ FALLO [$HTTP_CODE] $url" | tee -a "$LOG"
    fi
done < "$LISTA"

echo "" | tee -a "$LOG"
echo "Resultado guardado en: $LOG"