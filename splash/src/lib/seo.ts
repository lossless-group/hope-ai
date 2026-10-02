/**
 * Static SEO copy for the hope-ai splash. Centralized so MetaTags + index
 * hero read from one source of truth.
 */

export const REPO_URL = 'https://github.com/lossless-group/hope-ai';
export const SKILL_ZIP = 'personal-strategic-plan.zip';

export const STATIC_SEO = {
  brand: 'hope.ai',
  titleSuffix: ' — hope.ai',
  siteName: 'hope.ai',

  root: {
    title: 'hope.ai — a 100-day plan, with Claude in your corner',
    description:
      'An open toolkit for the ChoiceCenter Personal Strategic Plan. Give Claude one link and it helps you write goals you can keep, score each week on what you did, and get back on track the next morning.',
  },

  changelog: {
    title: 'Changelog',
    description: 'What changed in hope-ai, and when.',
  },

  contextV: {
    title: 'Behind the Toolkit',
    description:
      'The skill, specs, and plans behind hope-ai, written in the open.',
  },
} as const;

/**
 * Default OG image lives in /public/.
 */
export const DEFAULT_OG = {
  url: 'ogimage__Hope-Ai--Banner.jpg',
  width: 1200,
  height: 630,
  type: 'image/jpeg',
  alt: 'hope.ai — a 100-day plan, with Claude in your corner',
} as const;
