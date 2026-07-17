# Cloudflare DNS plan — jzoll.dev

## Records (all proxied — orange cloud on)

| Type | Name  | Content            | Proxy |
|------|-------|--------------------|-------|
| A    | @     | `<EC2_PUBLIC_IP>`  | ✅ Proxied |
| A    | www   | `<EC2_PUBLIC_IP>`  | ✅ Proxied |
| A    | auth  | `<EC2_PUBLIC_IP>`  | ✅ Proxied |
| A    | time  | `<EC2_PUBLIC_IP>`  | ✅ Proxied |
| A    | leet  | `<EC2_PUBLIC_IP>`  | ✅ Proxied |
| A    | mail  | `<EC2_PUBLIC_IP>`  | ✅ Proxied — placeholder name for Pigeon Project subdomain, rename once decided |
| A    | nudge | `<EC2_PUBLIC_IP>`  | ✅ Proxied |

All records point at the **same** EC2 IP — nginx on that box does the actual
subdomain routing via `server_name`, one server block per app (see
`infra/nginx/`). Cloudflare doesn't know or care that five apps live behind
one IP; it just proxies whatever `Host` header comes in.

Every record is proxied (not "DNS only"), which is what puts Cloudflare in
the request path for CDN caching, DDoS protection, and edge SSL. If a record
is ever set to "DNS only," traffic bypasses Cloudflare entirely for that
subdomain and hits EC2 directly.

## SSL/TLS mode: Full (strict)

Cloudflare dashboard → SSL/TLS → Overview → **Full (strict)**.

- **Flexible** — Cloudflare↔EC2 hop is unencrypted. Avoid; this is the mode
  that causes redirect loops with app frameworks that also try to force HTTPS.
- **Full** — encrypted hop, but Cloudflare doesn't validate the origin cert
  (a self-signed cert would pass). Better than Flexible, not as good as strict.
- **Full (strict)** — encrypted hop, origin cert must be valid. Use a
  Cloudflare Origin CA cert (SSL/TLS → Origin Server → Create Certificate) —
  free, long-lived, and only trusted by Cloudflare, which is fine since
  nothing but Cloudflare should be talking to EC2 directly on 443 anyway.

## Other settings worth setting once, up front

- **Always Use HTTPS** (SSL/TLS → Edge Certificates) — redirects any stray
  HTTP request at the edge, before it even reaches EC2.
- **Auto Minify** — optional, marginal for a project this size; skip unless
  there's a reason.
- **Firewall / WAF** — start with Cloudflare's default managed ruleset on.
  Revisit if the auth app needs tighter rate limiting on login endpoints
  (belongs in the auth app's diligence pass, not here).
- **Page Rules / Cache Rules** — none needed yet for the static site (default
  caching is fine). Apps with dynamic API responses (auth, time tracker) will
  need "Cache Level: Bypass" rules for their `/api/*` paths once those exist —
  otherwise Cloudflare may cache a JSON response meant to be per-request.

## Origin cert install (EC2 side)

```
sudo mkdir -p /etc/nginx/ssl/jzoll.dev
sudo nano /etc/nginx/ssl/jzoll.dev/origin.pem   # paste cert from CF dashboard
sudo nano /etc/nginx/ssl/jzoll.dev/origin.key   # paste private key from CF dashboard
sudo chmod 600 /etc/nginx/ssl/jzoll.dev/origin.key
```
Paths match what `infra/nginx/jzoll.dev.conf` expects.
