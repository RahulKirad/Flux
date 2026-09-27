/** Default site content — merged with DB overrides (setting_key: site_content_json) */
export const SITE_CONTENT_DEFAULTS = {
  hero: {
    badge: 'Precision Engineering',
    titleLine1: 'Engineering the',
    titleHighlight: 'Future of',
    titleAccent: 'Mobility',
    description:
      'Integrated engineering design, composites, prototyping, and tools & die for bus body and railway parts manufacturing — from concept to series production.',
    ctaPrimary: 'Request Quote',
    ctaPrimaryHref: '/contact',
    ctaSecondary: 'Our Services',
    ctaSecondaryHref: '/services',
    videoUrl: '',
    posterUrl: '',
  },
  home: {
    aboutLabel: 'About Flux Corp',
    aboutTitle: 'Integrated Engineering & Manufacturing',
    aboutBody: '',
  },
  contact: {
    headline: 'Get in Touch',
    subheadline: 'Request a consultation or quote for your next project.',
  },
  assets: {
    'hero.video': '',
    'hero.poster': '',
    'home.about.image': '',
    'page.about.banner': '',
    'industry.automotive.image': '',
    'industry.commercial-vehicles.image': '',
    'industry.electric-vehicles.image': '',
    'industry.railways.image': '',
    'industry.industrial-equipment.image': '',
  },
};

export function deepMergeContent(base, override) {
  if (!override || typeof override !== 'object') return base;
  const out = { ...base };
  for (const key of Object.keys(override)) {
    const val = override[key];
    if (val && typeof val === 'object' && !Array.isArray(val)) {
      out[key] = deepMergeContent(base[key] || {}, val);
    } else if (val !== undefined && val !== null && val !== '') {
      out[key] = val;
    }
  }
  return out;
}
