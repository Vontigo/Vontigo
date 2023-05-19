import { writable } from 'svelte/store';
import { CONST_AUTOSAVE_COUNTDOWN_MS } from '../const';
import { ENUM_APP_TYPE } from '../enum';

export const origin = writable('');
export const language = writable('en-us'); //default on English
export const siteUrl = writable('');

export const STORE_ADMIN_SITE_URL = writable('');
export const STORE_ADMIN_APP_TYPE = writable(ENUM_APP_TYPE.website);

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
export const wordsCount = writable(0);

// Auth
export const isSignedIn = writable(true);
