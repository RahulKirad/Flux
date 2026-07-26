---
name: Kinetic Precision
colors:
  surface: '#f8f9fa'
  surface-dim: '#d9dadb'
  surface-bright: '#f8f9fa'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f4f5'
  surface-container: '#EDEEEF'
  surface-container-high: '#e7e8e9'
  surface-container-highest: '#e1e3e4'
  on-surface: '#191c1d'
  on-surface-variant: '#46464b'
  inverse-surface: '#2e3132'
  inverse-on-surface: '#f0f1f2'
  outline: '#77767c'
  outline-variant: '#C5C6CA'
  surface-tint: '#5d5e65'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#1a1b21'
  on-primary-container: '#E1E3E4'
  inverse-primary: '#c7c5ce'
  secondary: '#575f66'
  on-secondary: '#ffffff'
  secondary-container: '#dbe3ec'
  on-secondary-container: '#5d656c'
  tertiary: '#000001'
  on-tertiary: '#ffffff'
  tertiary-container: '#191c1f'
  on-tertiary-container: '#828488'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e3e1ea'
  primary-fixed-dim: '#c7c5ce'
  on-primary-fixed: '#1a1b21'
  on-primary-fixed-variant: '#46464d'
  secondary-fixed: '#dbe3ec'
  secondary-fixed-dim: '#bfc7cf'
  on-secondary-fixed: '#151c22'
  on-secondary-fixed-variant: '#40484e'
  tertiary-fixed: '#e1e2e7'
  tertiary-fixed-dim: '#c5c6cb'
  on-tertiary-fixed: '#191c1f'
  on-tertiary-fixed-variant: '#44474b'
  background: '#f8f9fa'
  on-background: '#191c1d'
  surface-variant: '#e1e3e4'
typography:
  headline-xl:
    fontFamily: Hanken Grotesk
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Hanken Grotesk
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Hanken Grotesk
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Hanken Grotesk
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Hanken Grotesk
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-sm:
    fontFamily: Hanken Grotesk
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  headline-lg-mobile:
    fontFamily: Hanken Grotesk
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
spacing:
  base: 8px
  gutter: 24px
  margin-desktop: 48px
  margin-mobile: 16px
  container-max: 1280px
  section-padding: 96px
---

## Brand & Style
The brand identity is rooted in **Industrial Minimalism** and **Technical Sophistication**. It targets high-stakes engineering, aerospace, and data infrastructure sectors. The aesthetic should evoke feelings of absolute reliability, mathematical precision, and forward-thinking structural integrity.

The design style utilizes a high-contrast, "Utility-First" approach:
- **Monochromatic Authority:** A strict black-and-white foundation to emphasize blueprints and technical imagery.
- **Structural Lines:** Use of thin, consistent borders (hairlines) to define sections rather than shadows.
- **Micro-Interactions:** Focus on "Kinetic" elements, such as expanding underlines and subtle opacity shifts, to simulate mechanical motion.

## Colors
The palette is intentionally restrained to maintain a professional, blueprint-like atmosphere.
- **Primary (#1A1B21):** A deep, near-black charcoal used for core branding, heavy text, and high-impact containers.
- **Secondary (#575F66):** A technical slate grey for supporting text and iconography.
- **Neutral/Background (#FFFFFF):** Absolute white serves as the primary workspace to maximize legibility and "airiness."
- **Surface Low (#F8F9FA):** A very subtle grey for differentiating content sections without breaking the flat aesthetic.

## Typography
The system uses **Hanken Grotesk** exclusively to maintain a clean, contemporary, and engineered feel.
- **Headlines:** Use tighter letter-spacing and heavier weights (600-700) to create a "locked-in" architectural look.
- **Labels:** Always uppercase with generous letter-spacing (0.05em) to mimic technical drafting notations.
- **Body:** Open and legible with standard weights for high readability in technical descriptions.

## Layout & Spacing
The system follows a **Fixed-Width Centered Grid** for desktop and a **Fluid Single Column** for mobile.
- **Grid:** 12-column structure for desktop with 24px gutters.
- **Margins:** Large 48px side margins on desktop to create a focused "letterbox" feel; 16px on mobile.
- **Vertical Rhythm:** Sections are separated by significant whitespace (96px) to reinforce the minimalist brand values.
- **Bento Grid:** Use for secondary information clusters, utilizing varied column spans (e.g., 2/3 vs 1/3) to create visual interest while maintaining alignment.

## Elevation & Depth
This system rejects shadows in favor of **Structural Outlines and Tonal Layers**.
- **Outlines:** Use `outline-variant` (#C5C6CA) for secondary borders and `primary` (#1A1B21) for active or emphasis states.
- **Flat Depth:** Depth is communicated by shifting from White to `surface-container-low` (#F8F9FA) or `surface-container` (#EDEEEF).
- **Z-Index:** Navigation remains sticky with a simple bottom-border separation, ensuring the content "flows" underneath the structural header.

## Shapes
The shape language is strictly **Geometric and Sharp**. 
- **Corners:** Default to 0px (Sharp) for inputs, buttons, and section containers to maintain the industrial engineering aesthetic.
- **Exceptions:** Only use circular shapes for functional icons or specific status indicators.
- **Borders:** Thin 1px lines are the primary decorative element, reinforcing the "technical drawing" feel.

## Components
- **Buttons:** 
  - *Primary:* Solid #1A1B21 background, white text, sharp corners, uppercase tracking.
  - *Secondary:* 1px border, transparent background, sharp corners.
  - *Hover:* Slight opacity reduction (90%) or background fill for ghost buttons.
- **Input Fields:** 
  - Sharp corners, 1px #C5C6CA border. 
  - On focus, the border transitions to #1A1B21. 
  - Labels are always positioned above the input in `label-sm` style.
- **Cards/Bento Items:** 
  - Defined by 1px borders. 
  - Content should have generous padding (32px).
  - Images within cards should use `group-hover` scale effects (1.05x) to provide feedback without adding shadows.
- **Navigation:** 
  - Simple text links with `kinetic-border` interaction (an underline that expands from 0% to 100% width on hover).
- **Icons:** 
  - Use Material Symbols (Outlined) with a light weight (300) to match the thin line-work of the UI borders.