# Site — Architecture

**One-line purpose:** Static resume/portfolio site at the jzoll.dev root domain; also the deploy target and nginx pattern the other five apps follow.

**Status:** core content in place; design system adopted

### How it works
Plain HTML/CSS/JS, no build step, no server process. Cloudflare proxies the
request, nginx on the EC2 box serves the file straight off disk from
`apps/site/`, matching on `server_name jzoll.dev www.jzoll.dev`. There's no
PM2 process for this app — it's the one app in the portfolio that doesn't
need one.

Styling comes from the "Organic" design system (`css/style.css`) — a
token-based plain-CSS system (color ramps, spacing scale, component classes
like `.card`, `.tag`, `.btn`) with no JS dependency. A print-only resume is
embedded in the page (`#print-resume`) and shown via a `@media print` rule
that hides everything else; the "Print resume" button just calls
`window.print()`.

### A note on the design-tool export
An earlier upload (`jzoll-portfolio_dc.html` + `support.js` + `_ds_bundle.js`
+ `_ds_manifest.json`) was a *preview* export from a design tool, not
deployable code — it depends on a proprietary runtime (`dc-runtime`) that
parses custom `<x-dc>`/`sc-for`/`sc-if` template syntax against React at
runtime. It was not wired into the site; only the underlying content (resume
copy, project list) and the plain-CSS design system (`styles.css`) were kept.

### Key files
| File | Responsibility |
|---|---|
| `apps/site/index.html` | Page structure, real resume content, embedded print resume |
| `apps/site/css/style.css` | Organic design system — tokens + component classes |
| `apps/site/css/DESIGN-SYSTEM.md` | Reference guide for the design system's classes/tokens |
| `apps/site/js/main.js` | Footer year + print-resume button wiring — no framework |
| `infra/nginx/jzoll.dev.conf` | Root-domain nginx server blocks (HTTP→HTTPS redirect, static serving, real-IP restore) |
| `infra/nginx/snippets/cloudflare-real-ip.conf` | Cloudflare IP ranges so nginx logs real visitor IPs, not Cloudflare's edge IPs |
| `infra/cloudflare/dns-plan.md` | DNS record plan and SSL mode for the whole domain |

### Architecture diagram
None needed yet — no data model, no request branching beyond static file
serving. Will add a request-flow diagram once the shared-auth reverse-proxy
pattern is in place and this doc can point to it as the reference case.

### Written by AI vs. by me
Scaffolding (HTML structure, CSS, nginx config, Cloudflare DNS plan):
AI-assisted, unedited placeholder content. Real bio/project copy and any
design direction: not yet written — this is intentionally left generic
until there's real content to design around.

### Check your understanding
> **Key to understanding this app:** nginx serves this app directly from
> disk (`root` + `try_files`), unlike every other app in the portfolio,
> which will proxy to a PM2-managed Node process instead. If someone asked
> "why doesn't the site need a PM2 entry," the answer is: nothing here needs
> a runtime — no auth checks, no API calls, no server logic to execute.

> **Key to understanding this app:** the HTTP→HTTPS redirect exists in two
> places — Cloudflare's edge ("Always Use HTTPS") and this nginx config's
> `return 301`. They're redundant on purpose: Cloudflare's redirect handles
> the common case, nginx's is the backstop if a request ever reaches origin
> over plain HTTP (e.g., SSL mode misconfigured, or Cloudflare proxy briefly
> off). Removing either one doesn't break anything today, but removes a
> safety margin.

> **Key to understanding this app:** the print resume works because of a
> visibility trick, not a separate stylesheet — `@media print` sets
> `visibility:hidden` on everything, then `visible` again only on
> `#print-resume` and its children, and gives that element `position:absolute`
> so it doesn't leave a blank-space gap where the hidden content used to be.
> If `position:absolute` were removed, printing would show a mostly-blank
> page with the resume pushed far down by the hidden elements' reserved space.

> **Check yourself:** Could you explain why every DNS record is proxied
> (orange cloud) rather than "DNS only," and what would visibly change if
> one record were switched? (Answer to verify against: that record would
> bypass Cloudflare's CDN/DDoS layer and expose the EC2 IP directly for that
> subdomain — check `infra/cloudflare/dns-plan.md` if unsure.)
