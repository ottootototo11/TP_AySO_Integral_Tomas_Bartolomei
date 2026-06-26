#!/bin/bash
set -e

LISTA="$(dirname "$0")/Lista_Usuarios.txt"
GRUPO_SEC="TOMASBARTOLOMEI"

if [[ ! -f "$LISTA" ]]; then
    echo "ERROR: No se encuentra $LISTA"
    exit 1
fi

getent group "$GRUPO_SEC" &>/dev/null || groupadd "$GRUPO_SEC"

while IFS=: read -r usuario grupo_pri || [[ -n "$usuario" ]]; do
    [[ "$usuario" =~ ^#.*$ || -z "$usuario" ]] && continue

    getent group "$grupo_pri" &>/dev/null || groupadd "$grupo_pri"

    if ! id "$usuario" &>/dev/null; then
        useradd -m -g "$grupo_pri" -G "$GRUPO_SEC" -s /bin/bash "$usuario"
        echo "$usuario:vagrant" | chpasswd
        echo "✔ Usuario $usuario creado en grupo $grupo_pri"
    else
        echo "⚠  Usuario $usuario ya existe, actualizando grupos..."
        usermod -aG "$GRUPO_SEC" "$usuario"
    fi
done < "$LISTA"