import chai from 'chai';
const assert = chai.assert;
import setupSession from './setupSession';

describe('basicEntitiAccess', function () {

    let db = null;
    setupSession(before, after, beforeEach, afterEach, $db => {
        db = $db;
    });

    it('dummy', done => {
        assert(true);
        done();
    });
});