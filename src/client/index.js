import React from 'react';
import {Router} from 'react-router'
import routes from './routes/Routes';
import configureStore from './redux/store/Store';
import {Provider} from 'react-redux';
import {syncHistoryWithStore} from 'react-router-redux';
import {browserHistory} from 'react-router'
import ReactDOM from 'react-dom';
import injectTapEventPlugin from 'react-tap-event-plugin';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import muiTheme from './theme/muiTheme';

import './styles/app.css';

const store = configureStore();
const history = syncHistoryWithStore(browserHistory, store);

// Needed for onTouchTap
// http://stackoverflow.com/a/34015469/988941
injectTapEventPlugin();

ReactDOM.render(
    <Provider store={store}>
        <MuiThemeProvider muiTheme={muiTheme}>
            <Router history={history} routes={routes}/>
        </MuiThemeProvider>
    </Provider>,
    document.getElementById('app')
);