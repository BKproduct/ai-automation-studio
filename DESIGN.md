# AI Automation Studio — Design System

**Style:** Swiss Pulse (adapted) — engineering precision, editorial restraint, one decisive accent.
**Reference:** Müller-Brockmann grid + Helvetica tradition, modernised. NOT a copy of Acceler8 / pastel SaaS.
**Goal:** Read as "expensive precision tool", not "AI agency template".

---

## Colours

| Role        | Hex       | Use                                                          |
| ----------- | --------- | ------------------------------------------------------------ |
| Paper       | `#FAFAF7` | Page canvas. Warmer than #FFF — feels printed, not screen.   |
| Ink         | `#0A0A0A` | Headings, body, hairline borders. Near-black, not pure.      |
| Body        | `#1F1F1D` | Long-form body copy (slightly lighter than ink).             |
| Muted       | `#6B6B68` | Secondary text, labels, captions.                            |
| Rule        | `#E5E4DE` | 1px dividers, card borders. Warm grey, not blue.             |
| **Accent**  | `#FF3D2E` | THE accent. Used sparingly: one word, one underline, one dot, one bar. Never as a fill on large surfaces. |
| Accent-ink  | `#B82215` | Hover/pressed states for accent.                             |
| Ink-soft    | `#0A0A0A` @ 0.04 | Subtle grid lines, behind-element wash.                |

**Rule:** Accent is rationed. If a section has more than two red elements, remove one.

---

## Typography

| Role         | Family                    | Weight | Notes                                                    |
| ------------ | ------------------------- | ------ | -------------------------------------------------------- |
| Display      | **Geist Sans**            | 700    | Sharp grotesque. Distinctive vs Inter/Space Grotesk.     |
| Body         | **Geist Sans**            | 400/500 | Body copy. Comfortable at 16–17px.                       |
| Mono / data  | **Geist Mono**            | 500    | All numerals, stats, ratios, kicker labels. `tabular-nums`. |
| Italic accent| Geist Sans Italic         | 400    | Rare — for pull-quotes or single-word emphasis only.     |

**Sizes:**
- Display hero: clamp(48px, 7vw, 96px), line-height 0.95, letter-spacing -0.04em
- Section title: clamp(32px, 4vw, 52px), line-height 1.05, letter-spacing -0.02em
- Body: 16–17px, line-height 1.6
- Mono kicker: 11px UPPERCASE, letter-spacing 0.18em
- Stat number: 40–56px Geist Mono 500, tabular-nums

**Anti-rules:**
- NEVER Inter, Roboto, Space Grotesk, Manrope, Poppins.
- NEVER mix more than 2 type families.
- NEVER centre body copy across full width — left-align everything except dedicated centred sections.

---

## Layout & grid

- Container: max-width 1200px, gutter 32px (24px mobile).
- Underlying 12-column grid; visible 1px hairlines at column boundaries on hero only (4% black, decorative).
- Section padding: 120px desktop / 72px mobile. No exceptions — generous whitespace is the look.
- Card borders: 1px solid `--rule`. No drop-shadows. Depth comes from spacing, hairline, and motion — not blur.

---

## Motion principles

1. **Page-load orchestration > scattered micro-interactions.** One choreographed entrance on hero, then quiet.
2. **Easings vary across tweens.** Use at least 3 different eases per scene (e.g. `power3.out`, `expo.out`, `power1.inOut`). No `linear` on entrances.
3. **Word-by-word reveals**, not letter-by-letter. Letters look gimmicky.
4. **Stagger = 60–90ms** between siblings. Tighter feels rushed, looser feels lazy.
5. **Idle motion is subtle.** Float ≤ 6px amplitude, ≥ 4s period. If it draws the eye, kill it.
6. **One hero gesture.** The animated workflow mock (lines drawing + node pulse) is THE moment. Everything else supports.
7. **Counter rolls** on stats, 1.2s, `power3.out` — feels like a meter settling, not a slot machine.
8. **SVG stroke draws** (stroke-dashoffset → 0) over 0.6–1.0s, `expo.out`. Used for connector lines only.
9. **Smooth scroll** via Lenis — lerp 0.1, no rubber-band. Off on `prefers-reduced-motion`.
10. **Respect `prefers-reduced-motion`** — disable all transforms, keep opacity fades only.

**Tools:** GSAP 3 + ScrollTrigger (CDN) for choreography. Lenis for smooth scroll. CSS @keyframes for idle float. No Framer Motion (no React). No Lottie (no AE assets).

---

## Component patterns

- **Buttons:** 48px tall, 1px border (`--ink` outline / accent fill), 0 radius (sharp corners). Hover = invert ink↔paper, no transform.
- **Cards:** 1px `--rule`, paper bg, 32px padding, 0 radius (or max 2px). Hover = border colour shifts to ink, content nudges up 2px.
- **Stats:** Mono numerals, left-aligned, kicker label below in muted Geist Mono uppercase 10px.
- **Section labels:** Mono uppercase 11px, accent dot prefix (`<span class="accent-dot">·</span>` 6px square).
- **Workflow mock (hero right):** 3 monolinear cards stacked diagonally, connected by curved SVG paths that draw on load. Central AI node pulses 1× then quiets.

---

## What NOT to do (anti-patterns)

1. ❌ Pastel pinks, peaches, lavenders (Acceler8/Linear copy-paste).
2. ❌ Purple-to-pink gradients on white — instant AI slop.
3. ❌ Rounded everything (12px+ radii on every element).
4. ❌ Floating cards with drop-shadow + emoji icons (current site does this — remove).
5. ❌ Multiple accent colours. One red. That's it.
6. ❌ Cartoon character illustrations as primary visual. Use schematic / product UI mocks.
7. ❌ Centred hero copy with stats below. Left-aligned, asymmetric, workflow mock on right.
8. ❌ Inter, Space Grotesk, Manrope — all banned.
9. ❌ Smooth scroll without reduced-motion fallback.
10. ❌ More than one "wow" motion per section.

---

## Implementation references

- Type loaded via Google Fonts (`Geist`, `Geist Mono`).
- GSAP: `https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js`
- ScrollTrigger: `https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/ScrollTrigger.min.js`
- Lenis: `https://cdn.jsdelivr.net/npm/lenis@1.1.13/dist/lenis.min.js`
- Total JS over wire: ~95KB gzipped. Acceptable.
