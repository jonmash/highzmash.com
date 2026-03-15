# highzmash.com

Personal blog of Jon Mash — engineering leadership opinions, PCB design war stories, side projects.

Built with [Hugo](https://gohugo.io/) + [PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme, deployed to [Cloudflare Pages](https://pages.cloudflare.com/) via GitHub Actions.

---

## Quick Start (Local Development)

### Prerequisites

- [Hugo Extended](https://gohugo.io/installation/) v0.112.4+
- [Git](https://git-scm.com/)

### First-Time Setup

```bash
# 1. Clone the repo with submodules (PaperMod is a git submodule)
git clone --recurse-submodules https://github.com/jonmash/highzmash.com.git
cd highzmash.com

# If you already cloned without --recurse-submodules:
git submodule update --init --recursive
```

### Run Locally

```bash
hugo server -D --baseURL http://localhost:1313/
```

Visit `http://localhost:1313` — live reload is enabled.

The `-D` flag includes draft posts. Remove it to preview only published content.

**Tip:** If CSS or template changes aren't showing up, use:
```bash
hugo server -D --disableFastRender --baseURL http://localhost:1313/
```

Or clear the cache manually:
```bash
rm -rf public/ resources/
hugo server -D --baseURL http://localhost:1313/
```

**Note:** The `--baseURL` flag is important for local development so assets (images, CSS) load from localhost instead of the production URL.

---

## Writing a New Post

```bash
hugo new posts/your-post-slug.md
```

This creates `content/posts/your-post-slug.md` with front matter pre-filled.

### Front Matter Template

```yaml
---
title: "Your Post Title"
date: 2026-03-14
draft: true                    # Set to false when ready to publish
tags: ["leadership", "pcb"]
categories: ["Engineering Leadership"]
description: "One-sentence summary for SEO and social cards."
showToc: true
---
```

### Publishing a Post

1. Set `draft: false` in front matter
2. Commit and push to `main`
3. GitHub Actions builds and deploys automatically (~2 minutes)

---

## Deployment

**Automatic:** Every push to `main` triggers the GitHub Actions workflow at `.github/workflows/deploy.yml`.

The workflow:
1. Checks out the repo (including the PaperMod submodule)
2. Installs Hugo Extended (latest)
3. Runs `hugo --gc --minify`
4. Deploys `public/` to Cloudflare Pages via Wrangler

### Required GitHub Secrets

Set these in your repo → Settings → Secrets and Variables → Actions:

| Secret | Where to Find It |
|--------|-----------------|
| `CLOUDFLARE_API_TOKEN` | Cloudflare Dashboard → My Profile → API Tokens → Create Token (use "Edit Cloudflare Pages" template) |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare Dashboard → Right sidebar on any page |

### Cloudflare Pages Setup (One-Time)

1. Go to [Cloudflare Pages](https://pages.cloudflare.com/)
2. Create new project → "Connect to Git" → select this repo
3. Set build command: `hugo --gc --minify`
4. Set build output directory: `public`
5. Add environment variable: `HUGO_VERSION` = `0.145.0` (or latest)
6. Under **Custom Domains**, add `highzmash.com`

After this, GitHub Actions will handle all future deployments via Wrangler.

---

## Theme Customization

Custom styles live in `assets/css/extended/custom.css` — this file is loaded by PaperMod automatically and overrides default styles.

The PCB-inspired theme features:
- **Light mode:** Clean, minimal design with subtle green highlights
- **Dark mode:** PCB aesthetic with grid pattern, trace green accents, and glow effects
- **Background:** Light gray (#f8faf8) or dark (#0a0e0a) with PCB grid pattern
- **Accent:** Trace green (#00cc6a / #00ff88)
- **Typography:** Inter (body) + JetBrains Mono (code, UI elements)
- **Code blocks:** Dracula syntax theme with green left-border trace accent

To update the PaperMod theme:
```bash
git submodule update --remote --merge themes/PaperMod
git commit -am "Update PaperMod theme"
```

---

## Site Structure

```
highzmash.com/
├── .github/workflows/deploy.yml    # CI/CD pipeline
├── assets/css/extended/custom.css  # PCB theme overrides
├── content/
│   ├── about.md                    # About page
│   ├── search.md                   # Search page
│   └── posts/                      # Blog posts (Markdown)
├── static/images/                  # Favicon, OG image, avatar
├── themes/PaperMod/               # Theme (git submodule)
└── hugo.yaml                       # Site configuration
```

---

## Adding Images

Put static images in `static/images/`. Reference them in posts as `/images/filename.png`.

For post cover images, add to front matter:
```yaml
cover:
  image: "/images/posts/my-post-image.jpg"
  alt: "Description for accessibility"
```
# highzmash.com
