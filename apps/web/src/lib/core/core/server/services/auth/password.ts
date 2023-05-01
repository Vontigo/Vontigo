
import { knexInstance } from '$lib/core/core/server/data/db/connection.js';
export function generateToken() {

}

// function generateToken(email, settingsAPI, transaction) {
//     const options = { context: { internal: true }, transacting: transaction };
//     let dbHash;
//     let token;

//     return settingsAPI.read(_.merge({ key: 'db_hash' }, options))
//         .then((response) => {
//             dbHash = response.settings[0].value;

//             return models.User.getByEmail(email, options);
//         })
//         .then((user) => {
//             if (!user) {
//                 throw new errors.NotFoundError({ message: tpl(messages.userNotFound) });
//             }

//             token = security.tokens.resetToken.generateHash({
//                 expires: Date.now() + constants.ONE_DAY_MS,
//                 email: email,
//                 dbHash: dbHash,
//                 password: user.get('password')
//             });

//             return {
//                 email: email,
//                 resetToken: token
//             };
//         });
// }
