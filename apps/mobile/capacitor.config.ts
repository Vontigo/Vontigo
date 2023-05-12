import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
	appId: 'org.vontigo.mobile',
	appName: 'vontigo-mobile',
	webDir: 'build',
	server: {
		androidScheme: 'https'
	}
};

export default config;
