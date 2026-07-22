# Jessica Zoll — Portfolio & Monorepo

A public monorepo documenting the build of five interconnected applications, from infrastructure to frontend. This is my portfolio and resume site, plus the scaffolding for production apps.

**Live:** [jzoll.dev](https://jzoll.dev)

## Quick Start

### Running Locally

From `apps/site/`:

```bash
cd apps/site
python3 -m http.server 8000
```

Then open `http://localhost:8000` in your browser.

(Or use `npx http-server` if you prefer Node.js.)

## Project Structure

```
apps/site/              # Static portfolio & resume site
├── index.html          # Main page with hero, projects, resume
├── css/style.css       # Design system & component styles
└── js/main.js          # Resume modal & print handlers

docs/architecture/      # Architecture & design docs

infra/                  # Infrastructure as code & config
├── cloudflare/         # DNS records, SSL/TLS settings
├── nginx/              # Reverse proxy config for jzoll.dev
└── pm2/                # PM2 ecosystem files (for Node.js apps)
```

## Features

### Portfolio Site (`apps/site`)

- **Responsive design** — clean, minimal layout showcasing projects and background
- **View Resume** — modal dialog with full resume, easily closable (button, backdrop click, Escape key)
- **Print Resume** — optimized for single-page PDF export with professional typography (Times New Roman, 0.6in margins, centered headers)
- **Infrastructure showcase** — documents AWS EC2, Nginx, Cloudflare, PM2 setup

### Resume Features

- **Two viewing modes**: on-screen modal + print-optimized single-page PDF
- **Screen mode**: design-system colors, serif font, scrollable
- **Print mode**: Times New Roman, pure black on white, 10.5pt, centered header with italicized subtitle, professional section formatting
- **Navigation**: close button, backdrop click, Escape key support

## Tech Stack

**Frontend:**
- Plain HTML, CSS, JavaScript (no build step needed for the site)
- Semantic HTML5 (`<dialog>` for resume modal)
- CSS media queries for print styling
- Design system: custom CSS variables (color, spacing, typography, shadows)

**Infrastructure:**
- AWS EC2 (Ubuntu)
- Nginx (reverse proxy, subdomain routing, SSL termination)
- Cloudflare (DNS, DDoS protection, CDN caching)
- PM2 (process management for Node.js/other apps — not currently needed for static site)

**Deployment:**
- Static files served via Nginx on EC2
- Cloudflare sits in front, proxies all subdomains to same origin IP
- One Nginx config block per app (future: auth, time tracker, leet tracker, etc.)

## The Monorepo

This repo will eventually contain five apps, all behind the same jzoll.dev domain via Nginx subdomain routing:

1. **Shared Auth** (planned) — JWT-based auth service
2. **Time Tracker** (in progress) — React 19 + TypeORM session tracking
3. **Leet Tracker** (in progress) — Blazor Server + ASP.NET Core LeetCode tracker
4. **Pigeon Project** (planned) — Snail-mail tracking app
5. **Nudge** (planned) — AI accountability app

## Printing

### Print to PDF

1. Click **"Print resume"** button
2. In print preview:
   - Disable **"Headers and footers"** to remove page numbers/URLs
   - Choose **"Save as PDF"** or print to physical paper
3. Resume fits on one page

### Print CSS Details

- `@page` rule sets 0.6in margins and letter size
- `@media print` overrides fonts to Times New Roman (serif, professional)
- `display: none` hides everything except `#print-resume`, collapsing the page layout to avoid blank second pages
- Centered header with italicized subtitle and contact line
- Uppercase section headings with black borders
- Tight line-height (1.3) and margins to keep content compact

## Browser Compatibility

- Modern browsers (Chrome, Firefox, Safari, Edge) with ES6 support
- Print tested in Chrome, Firefox, Safari
- Designed mobile-first, responsive to all screen sizes

## Design System

See `apps/site/css/DESIGN-SYSTEM.md` for:
- Color ramps (neutral, accent, accent-2)
- Spacing scale (var(--space-1) through var(--space-8))
- Typography (Caprasimo for headings, Figtree for body)
- Component classes (.btn, .card, .tag, .dialog, etc.)

## Development

No build step. Edit HTML/CSS/JS directly and refresh the browser.

### To Add New Content

1. Edit `apps/site/index.html`
2. Keep resume data in two places: `#print-resume` (for printing) and `#resume-modal` (for on-screen modal)
3. Test in browser at `http://localhost:8000`
4. Test print preview (Cmd+P)

### Print Styling Tips

- Use `.resume-subtitle` class for italic text in print mode
- Use `.resume-contact` class for centered contact info
- Adjust `@page { margin: ... }` to change printed page margins
- Adjust `#print-resume` `font-size` and `line-height` to fit one page
- Always test in print preview before pushing

## License

Personal portfolio. All rights reserved.

## Contact

- **Email:** jzoll.dev@gmail.com
- **GitHub:** [Jzoll](https://github.com/Jzoll)
- **LinkedIn:** [jessica-zoll](https://www.linkedin.com/in/jessica-zoll-705a6627a/)
