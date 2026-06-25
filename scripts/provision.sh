#!/bin/bash
set -e

echo "=== Configurando /etc/hosts ==="
grep -q "ubuntu-testing"    /etc/hosts || echo "192.168.56.10 ubuntu-testing"    >> /etc/hosts
grep -q "fedora-produccion" /etc/hosts || echo "192.168.56.11 fedora-produccion" >> /etc/hosts

echo "=== Sudo sin clave para vagrant ==="
echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant-nopasswd
chmod 440 /etc/sudoers.d/vagrant-nopasswd

echo "=== Instalando paquetes ==="
if command -v apt-get &>/dev/null; then
    apt-get update -qq
    apt-get install -y lvm2 docker.io docker-compose htop tmux ansible curl
    systemctl enable --now docker
elif command -v dnf &>/dev/null; then
    dnf install -y lvm2 docker docker-compose htop tmux ansible curl
    systemctl enable --now docker
fi

echo "=== Configurando LVM ==="
pvcreate /dev/sdb /dev/sdc /dev/sdd 2>/dev/null || true

vgcreate vg_datos /dev/sdb /dev/sdc 2>/dev/null || true
vgcreate vg_temp  /dev/sdd          2>/dev/null || true

lvcreate -L 10M  -n lv_docker    vg_datos 2>/dev/null || true
lvcreate -L 2.5G -n lv_workareas vg_datos 2>/dev/null || true
lvcreate -L 2.5G -n lv_swap      vg_temp  2>/dev/null || true

mkfs.ext4 -F /dev/vg_datos/lv_docker    2>/dev/null || true
mkfs.ext4 -F /dev/vg_datos/lv_workareas 2>/dev/null || true
mkswap       /dev/vg_temp/lv_swap        2>/dev/null || true

mkdir -p /var/lib/docker /work
mount /dev/vg_datos/lv_docker    /var/lib/docker
mount /dev/vg_datos/lv_workareas /work
swapon /dev/vg_temp/lv_swap 2>/dev/null || true

grep -q "lv_docker"    /etc/fstab || echo "/dev/vg_datos/lv_docker    /var/lib/docker ext4 defaults 0 2" >> /etc/fstab
grep -q "lv_workareas" /etc/fstab || echo "/dev/vg_datos/lv_workareas /work           ext4 defaults 0 2" >> /etc/fstab
grep -q "lv_swap"      /etc/fstab || echo "/dev/vg_temp/lv_swap       none            swap sw       0 0" >> /etc/fstab

systemctl restart docker 2>/dev/null || true

echo "=== Provision completo ==="