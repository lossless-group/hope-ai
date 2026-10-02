// @ts-check
import { defineConfig } from 'astro/config';
import pagefind from 'astro-pagefind';
import sitemap from '@astrojs/sitemap';

// Splash for hope-ai.
// Hosted on GitHub Pages from lossless-group/hope-ai.
// Live URL: https://lossless-group.github.io/hope-ai/
//
// If a custom domain is added later, set `site` to that domain and `base` to '/'.
export default defineConfig({
  site: 'https://lossless-group.github.io',
  base: '/hope-ai/',
  trailingSlash: 'ignore',

  integrations: [
    pagefind(),
    sitemap({
      filter: (page) =>
        !page.includes('/llms.txt') &&
        !page.includes('/llms-full.txt') &&
        !page.endsWith('/404/') &&
        !page.endsWith('/404'),
    }),
  ],

  build: {
    format: 'directory',
  },
});
