# Web

This subproject is a SvelteKit server that provides various routes for different functionalities. 
It is divided into the following routes:

* **Admin**: The admin route ("/vontigo") contains the frontend interface to interact with the CMS (Content Management System). This section allows authorized users to manage and manipulate the website's content.
* **Auth**: The auth route contains callbacks and hooks for authentication. It handles the authentication process and ensures secure access to the different sections of the web application.
* **Core**: The core route serves as the API for the web server. It provides the necessary endpoints for data retrieval, manipulation, and other core functionalities the web application requires.
* **Front**: The front route represents the frontend site of the web application. It is the part that users interact with and is responsible for rendering the content from the CMS.
* **Setup**: The setup route is designed specifically for the initial setup of the web application. It contains necessary configurations, database setup, and other tasks required to prepare the application for its first use.



## Running
	
```bash
pnpm i
pnpm run dev --open
```

