import massive from 'massive';
import Promise from 'bluebird';

/**
 * This creates a promisified version of massive.
 * This means that we get
 * @param connectionString
 * @returns {*}
 */
export function buildMassive(connectionString) {
    if (!connectionString) throw Error('\'connectionString\' should be truthy');

    // This is the list of entities so we can promisify them
    // TODO: Find a way to make this automatically, this is so error prone and ugly
    let entities = [
        'notification',
        'project',
        'task',
        'task_comment',
        'user',
        'user_tasks_following',
        'user_workplaces',
        'workplace'
    ];

    // builds the massive instance
    let massiveInstance = massive.connectSync({connectionString: connectionString});

    // promisefies the main instance and all entities declared in the entities array
    Promise.promisifyAll(massiveInstance);
    entities.forEach(e => Promise.promisifyAll(massiveInstance[e]));
    return massiveInstance;
}