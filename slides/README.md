# Course slides

Slidev port of the course deck, on the Dataminded theme
(from [playground-agentic-slides](https://github.com/datamindedbe/playground-agentic-slides)).

```bash
npm install
npm run dev      # live preview
npm run build    # static site -> dist/
npm run export   # PDF
```

> If you add or rename a file under `parts/`, **restart the dev server** — Slidev
> resolves `src:` includes at startup and will not pick up a new part file while running.
> (In the Slidev terminal, `r` restarts.)

## Layout

```
terraform-course.md   entry: headmatter, cover slide, and `src:` includes
parts/                one file per section of the deck
public/images/        figures extracted from the original Google Slides deck
style.css             deck-wide figure sizing (.fig, .fig-sm, .fig-xs)
theme/                vendored copy of the Dataminded Slidev theme
```

Slide-level `<style>` blocks are scoped to their own slide in Slidev, so shared
rules live in `style.css` and images use the `.fig*` classes.

## Images

Extracted from the original deck by exporting it as PPTX and unzipping `ppt/media/`.
Screenshots of code were **not** kept — those slides use native Slidev code blocks
so the code stays selectable, themable and diffable.
