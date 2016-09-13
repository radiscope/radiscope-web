import React from 'react';
import App from '../containers/App';
import Home from '../containers/Home.js';

import { Route, Redirect } from 'react-router';

export default (
    <Route component={App}>
        <Route path="/" component={Home}/>
        <Redirect from="*" to="/" />
    </Route>
);
