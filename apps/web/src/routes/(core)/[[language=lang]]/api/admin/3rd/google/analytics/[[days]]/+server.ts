import { error } from '@sveltejs/kit';
import type { RequestHandler } from '../$types';
import { google } from 'googleapis';
import { privateKey } from './config';

const scopes = "https://www.googleapis.com/auth/analytics.readonly";

export const GET = (async ({ fetch, request, url, params }) => {
	// const body = await request.json();
	const jwt = new google.auth.JWT(
		privateKey.client_email,
		null,
		privateKey.private_key.replace(/\\n/g, "\n"),
		scopes
	);

	const view_id = "189586732";

	try {
		await jwt.authorize();

		const response = await google.analytics("v3").data.ga.get({
			auth: jwt,
			ids: "ga:" + view_id,
			"start-date": `${params.days}daysAgo`,
			"end-date": "today",
			metrics: "ga:pageviews",
			dimensions: "ga:date", //,ga:country
			"max-results": params.days, // maximum number of results to retrieve
			sort: "ga:date" // sort by date
		});

		// console.log(response);
		return new Response(JSON.stringify({ data: response }), { status: 200 });

	} catch (err) {
		console.log(err);
		return new Response(JSON.stringify({ data: {} }), { status: 200 });
	}

}) satisfies RequestHandler;
