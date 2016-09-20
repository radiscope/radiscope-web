import setupSession from './setupSession';
import {assertCanSaveFindAndDelete} from './dbTestHelper';


describe('basicEntitiAccess', function () {

    let db = null;
    setupSession(before, after, beforeEach, afterEach, $db => {
        db = $db;
    });

    it('can save, find and delete users', done => {
        let user = {
            name: 'andrerpena',
            display_name: 'André Pena',
            email: 'andrerpena@gmail.com'
        };
        assertCanSaveFindAndDelete(db, 'user', user, done);
    });

    it('can save, find and delete tasks', done => {
        // we need a user for the task
        db.user.saveAsync({
            name: 'andrerpena',
            display_name: 'André Pena',
            email: 'andrerpena@gmail.com'
        })
            .then((user) => {
                let task = {
                    user_id: user.id,
                    text: 'Do something coooool!'
                };
                assertCanSaveFindAndDelete(db, 'task', task, done);
            });
    });
});