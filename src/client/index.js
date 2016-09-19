import React, { Component } from 'react';
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

class Client extends Component {
    static getMountPoint() {
        return document.getElementById('app');
    }

    componentDidMount() {
        // Needed for onTouchTap
        // http://stackoverflow.com/a/34015469/988941
        injectTapEventPlugin();

        this.setState({
            store: configureStore()
        });
    }

    render() {
        let { store } = this.state;
        let history = syncHistoryWithStore(browserHistory, store);

        return (
            <Provider store={store}>
                <MuiThemeProvider muiTheme={muiTheme}>
                    <Router history={history} routes={routes}/>
                </MuiThemeProvider>
            </Provider>
        )
    }
}

ReactDOM.render(<Client/>, Client.getMountPoint());