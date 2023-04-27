import { writable } from 'svelte/store';

export const origin = writable('');
export const language = writable('');
export const siteUrl = writable('');
export const adminSiteUrl = writable('');

export const isEditorOpen = writable(false);
// Setting | site
export const site = writable({});
export const member = writable({});

export const themeConfig = writable({});
export const custom = writable({});

export const templateType = writable('');

export const access = writable(false);