import crypto from 'node:crypto';
import keypair from 'keypair';
import { v4 as uuidv4 } from 'uuid';


const doBlock = fn => fn();

const getMembersKey = doBlock(() => {
    let UNO_KEYPAIRINO;
    return function getKey(type) {
        if (!UNO_KEYPAIRINO) {
            UNO_KEYPAIRINO = keypair({ bits: 1024 });
        }
        return UNO_KEYPAIRINO[type];
    };
});

const getVontigoKey = doBlock(() => {
    let UNO_KEYPAIRINO;
    return function getKey(type) {
        if (!UNO_KEYPAIRINO) {
            UNO_KEYPAIRINO = keypair({ bits: 1024 });
        }
        return UNO_KEYPAIRINO[type];
    };
});
export const dynamicDefault = {
    db_hash: () => uuidv4(),
    public_hash: () => crypto.randomBytes(15).toString('hex'),
    admin_session_secret: () => crypto.randomBytes(32).toString('hex'),
    theme_session_secret: () => crypto.randomBytes(32).toString('hex'),
    members_public_key: () => getMembersKey('public'),
    members_private_key: () => getMembersKey('private'),
    members_email_auth_secret: () => crypto.randomBytes(64).toString('hex'),
    vontigo_public_key: () => getVontigoKey('public'),
    vontigo_private_key: () => getVontigoKey('private')
};