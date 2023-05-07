import { writable } from 'svelte/store';
import { CONST_AUTOSAVE_COUNTDOWN_MS } from '../const';

export const origin = writable('');
export const language = writable('');
export const siteUrl = writable('');
export const adminSiteUrl = writable('');

export const isEditorOpen = writable(false);
// Setting | site
export const site = writable({});
export const member = writable({});

export const theme = writable({});
// export const custom = writable({});

export const templateType = writable('');

export const access = writable(false);

// Data
export const autoSaveCountDown = writable(0);
export const recordPostsDataModal = writable({});
export const recordTagsDataModal = writable({});
export const recordUsersDataModal = writable({});

// Auth
export const isSignedIn = writable(true);
