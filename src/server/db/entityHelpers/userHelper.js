import { safeRead } from '../../../common/helpers/objectHelpers';

/**
 * Creates a user object from an OAuth Google profile
 * @param db Massive instance
 * @param profile
 * @returns Promise
 */
export function createFromGoogleProfile(db, profile) {
    if (!db) throw Error('\'db\' should be truthy');
    if (!profile) throw Error('\'profile\' should be truthy');

    let user = {
        display_name: profile.displayName,
        photo: safeRead((p) => p.photos[0].value, profile, null),
        email: safeRead((p) => p.emails[0].value, profile, null),
        oauth_profiles: {
            google: {
                id: profile.id,
                raw: profile
            }
        }
    };
    return db.user.saveAsync(user);
}

/**
 * Updates a user object based on the given google profile
 * @param db Massive instance
 * @param existingUser
 * @param profile
 */
export function updateFromGoogleProfile(db, existingUser, profile) {
    if (!db) throw Error('\'db\' should be truthy');
    if (!existingUser) throw Error('\'existingUser\' should be truthy');
    if (!profile) throw Error('\'profile\' should be truthy');

    if (!existingUser.display_name) {
        existingUser.display_name = profile.displayName;
    }
    if (!existingUser.photo) {
        existingUser.photo = safeRead((p) => p.photos[0].value, profile, null);
    }
    if(!existingUser.oauth_profiles) {
        existingUser.oauth_profiles = {};
    }
    existingUser.oauth_profiles.google = {
        id: profile.id,
        raw: profile
    };
    return db.user.saveAsync(existingUser);
}

/**
 * Finds the user based on the given google profile or creates a new user and returns that user
 * @param db
 * @param profile
 * @returns {Promise}
 */
export function findOrCreateFromGoogleProfile(db, profile) {
    if (!db) throw Error('\'db\' should be truthy');
    if (!profile) throw Error('\'profile\' should be truthy');

    let email = safeRead((p) => p.emails[0].value, profile, null);

    if (!email)
        throw Error('Google profile is not valid');

    return new Promise((fulfill, reject) => {
        db.user.findOneAsync({email: email})
            .then((user) => {
                if (user) {
                    let existingUserGoogleId = safeRead(u => u.oauth_profiles.google.id, user, null);
                    if (existingUserGoogleId) {
                        fulfill(user);
                    }
                    else {
                        this.updateFromGoogleProfile(db, user, profile)
                            .then(user => fulfill(user))
                            .catch(ex => reject(ex));
                    }
                }
                else {
                    this.createFromGoogleProfile(db, profile)
                        .then(user => fulfill(user))
                        .catch(ex => reject(ex));
                }
            })
            .catch(ex => reject(ex));
    });
}