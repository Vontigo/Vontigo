
import { globalConfig } from '$lib/core/shared/config/env/config';
import knex, { Knex } from 'knex';
// import { database } from '$lib/core/shared/config/env/config'


// export const knexInstance: Knex = await knex(globalConfig.database[process.env.NODE_ENV]);
export const knexInstance: Knex = await knex(globalConfig.database['production']);
