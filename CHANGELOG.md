# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## [1.0.0] — 2026-07-22

### Added

- **Resume Modal** — "View resume" button opens a scrollable dialog with full resume content; closes via close button, backdrop click, or Escape key
- **Print Optimization** — `@media print` rules ensure resume prints on a single page with professional typography
  - Times New Roman serif font throughout
  - Centered header (name 20pt bold, subtitle 11pt italic, contact line 10pt)
  - Black uppercase section headings with black borders
  - Tight line-height (1.3) and margins for page efficiency
  - 0.6in margins via `@page` rule
  - Pure black text on white background, no shadows or rounded corners
- **Print Preview Controls** — documentation for disabling browser headers/footers in print dialog
- **Resume Classes** — added `.resume-subtitle` and `.resume-contact` for cleaner print styling
- **Modal CSS** — `<dialog>` element with backdrop blur, scroll handling, and accessible close button
- **Two Resume Views** — same content in `#print-resume` (print) and `#resume-modal` (on-screen)
- **Infrastructure Documentation** — Cloudflare DNS plan, Nginx config, PM2 setup notes

### Changed

- Updated resume subtitle to include "Lifelong Builder"
- Reordered contact info: github → email → university
- Improved print media query from `visibility: hidden` to `display: none` to prevent blank second page

### Technical Details

- Print media query uses `body > *:not(#print-resume) { display: none }` to collapse layout
- h1, h2, p elements in print mode override font-family, size, line-height, and margins
- `.resume-subtitle` and `.resume-contact` classes provide centered, italic styling in print
- `@page` sets letter size and 0.6in margins for standard US letter printing
- Modal backdrop uses `color-mix()` and `backdrop-filter: blur()` for modern CSS effects
- No JavaScript frameworks — vanilla DOM manipulation for modal open/close

## [0.1.0] — 2026-07-01

### Initial

- Static portfolio site with hero, monorepo overview, and infrastructure documentation
- Basic CSS with design system tokens
- Navigation bar with links to LinkedIn, GitHub, email
- Projects showcase grid (five apps: Shared Auth, Time Tracker, Leet Tracker, Pigeon, Nudge)
- Infrastructure section documenting AWS EC2, Nginx, Cloudflare, PM2

---

## Future Roadmap

- [ ] Shared Auth service (Node.js JWT)
- [ ] Time Tracker SPA (React 19 + TypeORM)
- [ ] Leet Tracker (Blazor Server + ASP.NET Core)
- [ ] Pigeon Project (snail-mail tracking)
- [ ] Nudge (AI accountability app)
- [ ] Subdomain routing (auth.jzoll.dev, time.jzoll.dev, etc.)
- [ ] Database schemas & migrations docs
- [ ] CI/CD pipeline documentation (GitHub Actions)
- [ ] Blog or tech writeups
