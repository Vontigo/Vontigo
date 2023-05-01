// import { Adapter } from "authjs/adapters";
// import knex, { Knex } from 'knex';

// export function KnexAdapter(knex: Knex): Adapter {
//     return {
//         async createUser(data) {
//             return knex("users").insert(data);
//         },
//         async getUser(id) {
//             return knex("users").where({ id }).first();
//         },
//         async getUserByEmail(email) {
//             return knex("users").where({ email }).first();
//         },
//         async getUserByAccount(provider_providerAccountId) {
//             const account = await knex("accounts").where({ provider_providerAccountId }).select("userId").first();
//             if (!account) return null;
//             return knex("users").where({ id: account.userId }).first();
//         },
//         async updateUser(data) {
//             return knex("users").where({ id: data.id }).update(data);
//         },
//         async deleteUser(id) {
//             return knex("users").where({ id }).delete();
//         },
//         async linkAccount(data) {
//             return knex("accounts").insert(data);
//         },
//         async unlinkAccount(provider_providerAccountId) {
//             return knex("accounts").where({ provider_providerAccountId }).delete();
//         },
//         async getSessionAndUser(sessionToken) {
//             const userAndSession = await knex("sessions")
//                 .join("users", "sessions.userId", "users.id")
//                 .where({ sessionToken })
//                 .select("sessions.*", "users.*")
//                 .first();
//             if (!userAndSession) return null;
//             const { passwordHash, ...user } = userAndSession;
//             const { userId, ...session } = userAndSession;
//             return { user, session };
//         },
//         async createSession(data) {
//             return knex("sessions").insert(data);
//         },
//         async updateSession(data) {
//             return knex("sessions").where({ sessionToken: data.sessionToken }).update(data);
//         },
//         async deleteSession(sessionToken) {
//             return knex("sessions").where({ sessionToken }).delete();
//         },
//         async createVerificationToken(data) {
//             return knex("verificationTokens").insert(data);
//         },
//         async useVerificationToken(identifier_token) {
//             try {
//                 const token = await knex("verificationTokens").where({ identifier_token }).first();
//                 if (!token) return null;
//                 await knex("verificationTokens").where({ identifier_token }).delete();
//                 return token;
//             } catch (error) {
//                 // If token already used/deleted, just return null
//                 // https://www.prisma.io/docs/reference/api-reference/error-reference#p2025
//                 if (error instanceof Error && error.message.includes("P2025")) return null;
//                 throw error;
//             }
//         },
//     };
// }
