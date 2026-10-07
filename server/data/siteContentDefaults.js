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
  pages: {
    home: {
      label: 'Home',
      title: 'Engineering the Future of Mobility',
      subtitle:
        'Integrated engineering design, composites, prototyping, and manufacturing for bus body and railway parts.',
      body: '',
      bannerImage: '',
    },
    about: {
      label: 'About Us',
      title: 'Integrated Engineering Solutions',
      subtitle: 'Research, specification, prototyping, and fully assembled parts for bus body and railway manufacturing.',
      body: '',
      bannerImage: '',
    },
    services: {
      label: 'Capabilities',
      title: 'Our Services',
      subtitle: 'End-to-end engineering from design through series production.',
      body: '',
      bannerImage: '',
    },
    projects: {
      label: 'Portfolio',
      title: 'Our Projects',
      subtitle: 'Proven engineering across bus body lightweighting, railway interiors, and industrial applications.',
      body: '',
      bannerImage: '',
    },
    industries: {
      label: 'Industries Served',
      title: 'Sectors We Serve',
      subtitle: 'Integrated solutions tailored to transportation and industrial regulatory environments.',
      body: '',
      bannerImage: '',
    },
    'case-studies': {
      label: 'Portfolio',
      title: 'Case Studies',
      subtitle: 'Real-world results demonstrating our integrated engineering capabilities.',
      body: '',
      bannerImage: '',
    },
    certifications: {
      label: 'Compliance',
      title: 'Certifications & Standards',
      subtitle: 'Quality, safety, and regulatory approvals for automotive and railway manufacturing.',
      body: '',
      bannerImage: '',
    },
    facilities: {
      label: 'Manufacturing',
      title: 'Our Facilities',
      subtitle: 'State-of-the-art equipment in Chikhali and Chakan, Pune — scalable from prototype to production.',
      body: '',
      bannerImage: '',
    },
    careers: {
      label: 'Careers',
      title: 'Build With Us',
      subtitle: 'Join a team delivering integrated engineering for mobility and infrastructure.',
      body: '',
      bannerImage: '',
    },
    blog: {
      label: 'Insights',
      title: 'Engineering Blog',
      subtitle: 'In-depth articles for engineers, procurement professionals, and decision-makers.',
      body: '',
      bannerImage: '',
    },
    contact: {
      label: 'Contact',
      title: 'Get In Touch',
      subtitle: 'Project consultations, technical inquiries, and partnership opportunities.',
      body: '',
      bannerImage: '',
    },
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
    } else if (val !== undefined && val !== null) {
      out[key] = val;
    }
  }
  return out;
}
