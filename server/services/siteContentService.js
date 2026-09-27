import settingsRepository from '../repositories/settingsRepository.js';
import { SITE_CONTENT_DEFAULTS, deepMergeContent } from '../data/siteContentDefaults.js';

const SITE_CONTENT_KEY = 'site_content_json';

class SiteContentService {
  async getStored() {
    const raw = await settingsRepository.getByKey(SITE_CONTENT_KEY);
    if (!raw) return {};
    try {
      return JSON.parse(raw);
    } catch {
      return {};
    }
  }

  async getMerged() {
    const stored = await this.getStored();
    const merged = deepMergeContent(SITE_CONTENT_DEFAULTS, stored);
    if (merged.hero?.videoUrl) {
      merged.assets = merged.assets || {};
      if (!merged.assets['hero.video']) merged.assets['hero.video'] = merged.hero.videoUrl;
    }
    return merged;
  }

  async save(partial) {
    const current = await this.getStored();
    const next = deepMergeContent(deepMergeContent(SITE_CONTENT_DEFAULTS, current), partial);
    if (partial.hero?.videoUrl) {
      next.assets = { ...next.assets, 'hero.video': partial.hero.videoUrl };
    }
    await settingsRepository.upsert(SITE_CONTENT_KEY, JSON.stringify(next), 'site_content');
    return next;
  }
}

export default new SiteContentService();
