
interface SiteData {
    title: string;
    description: string;
    logo: string;
    cover_image: string;
    icon: string;
    accent_color: string;
    locale: string;
    timezone: string;
    codeinjection_head: string;
    codeinjection_foot: string;
    facebook: string;
    twitter: string;
    navigation: Array<{ label: string; url: string }>;
    secondary_navigation: Array<{ label: string; url: string }>;
    meta_title: string | null;
    meta_description: string | null;
    og_image: string | null;
    og_title: string | null;
    og_description: string | null;
    twitter_image: string | null;
    twitter_title: string | null;
    twitter_description: string | null;
}

interface SiteGroup {
    [group: string]: SiteData;
}