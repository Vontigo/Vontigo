
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
    members_support_address: string | null;
    members_enabled: boolean | false;
    members_invite_only: boolean | true;
    paid_members_enabled: boolean | false;
    firstpromoter_account: string | null;
    portal_button_style: string | null;
    portal_button_signup_text: string | null;
    portal_button_icon: string | null;
    portal_signup_terms_html: string | null;
    portal_signup_checkbox_required: string | null;
    portal_plans: string | null;
    portal_name: string | null;
    portal_button: string | null;
    comments_enabled: string | null;
}

interface SiteGroup {
    [group: string]: SiteData;
    theme: any;
}