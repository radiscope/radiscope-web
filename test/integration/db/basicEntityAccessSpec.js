import setupSession from './setupSession';
import {assertSaveFindAndDelete} from './dbTestHelper';


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
        assertSaveFindAndDelete(db, 'user', user, done);
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
                assertSaveFindAndDelete(db, 'task', task, done);
            });
    });
});