import * as crypto from 'crypto';

export function generateHash(options) {
    options = options || {};

    const hash = crypto.createHash('sha256');
    const expires = options.expires;
    const email = options.email;
    const dbHash = options.dbHash;
    const password = options.password;
    let text = '';

    hash.update(String(expires));
    hash.update(email.toLocaleLowerCase());
    hash.update(password);
    hash.update(String(dbHash));

    text += [expires, email, hash.digest('base64')].join('|');
    return Buffer.from(text).toString('base64');
}

export function compare(options) {
    options = options || {};

    const tokenToCompare = options.token;
    const parts = exports.resetToken.extract({ token: tokenToCompare });
    const dbHash = options.dbHash;
    const password = options.password;
    let generatedToken;
    let diff = 0;
    let i;

    if (isNaN(parts.expires)) {
        return {
            correct: false,
            reason: 'invalid_expiry'
        };
    }

    // Check if token is expired to prevent replay attacks
    if (parts.expires < Date.now()) {
        return {
            correct: false,
            reason: 'expired'
        };
    }

    generatedToken = exports.resetToken.generateHash({
        email: parts.email,
        expires: parts.expires,
        dbHash: dbHash,
        password: password
    });

    if (tokenToCompare.length !== generatedToken.length) {
        diff = 1;
    }

    for (i = tokenToCompare.length - 1; i >= 0; i = i - 1) {
        diff |= tokenToCompare.charCodeAt(i) ^ generatedToken.charCodeAt(i);
    }

    const result = {
        correct: (diff === 0)
    };

    if (!result.correct) {
        result.reason = 'invalid';
    }

    return result;
}