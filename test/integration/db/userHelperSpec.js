import {assert} from 'chai';
import setupSession from './setupSession';
import googleProfileSample from "./resources/googleProfileSample.js";
import {createFromGoogleProfile}  from '../../../src/server/db/entityHelpers/userHelper';


describe('userHelper', function () {

    let db = null;
    setupSession(before, after, beforeEach, afterEach, $db => {
        db = $db;
    });

    it('createFromGoogleProfile', done => {
        createFromGoogleProfile(db, googleProfileSample)
            .then(u => {
                assert.isOk(u);
                // let's go to the database to see if the user has actually been added
                return db.user.findOneAsync(u.id);
            })
            .then(u => {
                assert.isOk(u);
                assert.isOk(u.oauth_profiles);
                assert.strictEqual(u.oauth_profiles.google.id, '109199054588840596357');
                return db.user.destroyAsync({id: u.id});
            })
            .then(() => done())
            .catch(done);
    });


});