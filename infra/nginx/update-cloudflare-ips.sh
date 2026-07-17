#!/usr/bin/env bash
# Regenerates infra/nginx/snippets/cloudflare-real-ip.conf from Cloudflare's
# published IP list. Run manually after setup, then optionally on a weekly
# cron once this is on the EC2 box.
set -euo pipefail

OUT="$(dirname "$0")/snippets/cloudflare-real-ip.conf"

{
  echo "# Auto-generated $(date -u +%Y-%m-%dT%H:%M:%SZ) from cloudflare.com/ips"
  echo
  echo "# IPv4"
  curl -fsS https://www.cloudflare.com/ips-v4 | while read -r ip; do
    echo "set_real_ip_from $ip;"
  done
  echo
  echo "# IPv6"
  curl -fsS https://www.cloudflare.com/ips-v6 | while read -r ip; do
    echo "set_real_ip_from $ip;"
  done
  echo
  echo "real_ip_header CF-Connecting-IP;"
} > "$OUT"

nginx -t && systemctl reload nginx
echo "Updated $OUT"
