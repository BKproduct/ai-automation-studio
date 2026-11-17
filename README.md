# AI Automation Studio — site

Static source of the AI Automation Studio landing page: an AI automation studio in London that builds agents and workflow automation for professional-services firms.

**Live site:** [ai-automation.studio](https://ai-automation.studio)

## What is here

| Path | Contents |
|---|---|
| `index.html` | First version of the landing page |
| `v2/` | Redesign: Swiss-grid layout, one accent colour, mobile-first |
| `v2/DESIGN.md` | Design system: colours, type scale, spacing, motion rules |
| `v2/lab/chat.html` | Prototype of the animated agent-chat block |
| `call/` | Short link to book a discovery call |

## Design principles

- One decisive accent colour, used sparingly.
- A 12-column grid and 1px hairline borders; no drop shadows.
- Geist Mono with tabular numerals for every figure.
- Generous whitespace: 120px section padding on desktop, 72px on mobile.

## Run locally

Plain HTML, no build step:

```bash
python3 -m http.server 8000
# open http://localhost:8000/v2/
```

## Contact

Book a call at [ai-automation.studio/call](https://ai-automation.studio/call).
