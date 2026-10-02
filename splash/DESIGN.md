---
version: alpha
name: hope.ai — Splash
description: >-
  Design system for the hope-ai splash site. Three-mode contract
  (light-default "dawn" / dark "the night before" / vibrant "golden hour")
  with an apricot-marigold-sky brand spine, Instrument Serif italic display
  over Figtree and JetBrains Mono, and a "first light" posture: a 100-day
  plan dressed as the morning you start one. Sky-band background, a rising
  sun of 100 day-ticks as the hero, index-card chrome borrowed from the
  plan's own notecard system, warm second-person voice. Tokens mirror the
  CSS custom properties in src/styles/theme.css — that file remains the
  runtime source of truth; this DESIGN.md is the human- and agent-readable
  contract.

colors:
  apricot: "#f28c5b"
  apricot-deep: "#c95a2c"
  apricot-soft: "#fbd2bb"
  marigold: "#f5b83d"
  marigold-deep: "#b97f0c"
  sky: "#5aa6d6"
  sky-deep: "#2b6f9e"
  rose: "#e8708a"
  cream: "#fffaf2"
  ink: "#2a1f1a"
  indigo-deep: "#0c0f24"
  plum-deep: "#1a0c1f"

typography:
  display: { family: "Instrument Serif", style: "italic for emphasis", weight: 400 }
  sans: { family: "Figtree", weights: [400, 500, 600, 700] }
  mono: { family: "JetBrains Mono", weights: [400, 500, 600] }

rounded:
  sm: 3px
  md: 6px     # index cards
  lg: 10px    # the copy-to-Claude panel
  pill: 999px # every button

modes:
  light:   { name: dawn, default: true, bg: cream, accent: apricot-deep, ticks-on: apricot-deep }
  dark:    { name: the night before, bg: indigo-deep, accent: apricot, ticks-on: marigold, stars: on }
  vibrant: { name: golden hour, bg: plum-deep, accent: "#ff9a5c", ticks-on: "#ffd23f" }

imagery:
  mark: public/brand/hope-ai-mark.svg            # half-risen sun over a horizon
  app_icon: public/brand/hope-ai-app-icon.svg     # rasterized to 128, 180, 512
  logotype: public/brand/hope-ai-logotype.svg     # "hope" italic serif + ".ai" mono
  og: public/ogimage__Hope-Ai--Banner.jpg         # 1200x630, rendered from HTML via headless Chrome
---

# hope.ai — Splash

## Overview

The page has one job: get a ChoiceCenter cohort member, usually on the
Claude desktop app and not technical, to hand Claude the repo link. Every
decision serves that: the copyable message sits in the hero, the install
steps are numbered and plain, and the GitHub repo is the only other call.

## Colors

A sunrise. Apricot leads (links, buttons, lit ticks), marigold is the sun,
rose is the low edge of it, sky is the cool counterweight used sparingly
(stamps, rest weeks). Day neutrals are warm cream and brown-black ink,
never grey-blue.

## Typography

Instrument Serif at display sizes, with the italic doing the emotional
work ("*with a plan.*"). Figtree for reading. JetBrains Mono for anything
counted: day labels, file paths, the message to paste.

## Layout

Asymmetric hero: copy and the copy-to-Claude panel left, the sunrise right
(above the copy on phones). Sections are numbered as days (`DAY 00`,
`DAY 01`, `DAY 07`, `DAY 23`), the folio primitive.

## Elevation & Depth

Soft warm shadows on cards; the hero panel carries the elevated shadow so
it reads as the thing to touch.

## Shapes

Index cards: 6px corners, a pink header rule at 44px, faint blue ruling
below, a slight alternating tilt that straightens on hover. Buttons are
pills. Stamps keep the family's double-rule rubber-stamp shape.

## Components

`Logo.astro` (mark + logotype, token-colored), the sunrise SVG (100 ticks,
long tick every 10th day, sequential light-up animation, disabled under
reduced motion), the copy panel, numbered steps, the 12-week strip with
rest weeks 8 and 12, chat bubbles.

## Do's and Don'ts

- Do keep the paste-into-Claude message as the hero's primary action.
- Do describe Claude app steps exactly as Anthropic's help center does, and link it.
- Don't claim coaching features the skill doesn't have yet.
- Don't imply affiliation with ChoiceCenter or Anthropic.
