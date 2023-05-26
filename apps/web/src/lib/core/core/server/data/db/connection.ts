import { DATABASE_TYPE } from '$env/static/private';
import { globalConfig } from '$lib/core/shared/config/env/config';
import knex, { Knex } from 'knex';
// import { database } from '$lib/core/shared/config/env/config'

export const knexInstance: Knex = await knex(globalConfig.database[DATABASE_TYPE]);
// export const knexInstance: Knex = await knex(globalConfig.database['production']);
