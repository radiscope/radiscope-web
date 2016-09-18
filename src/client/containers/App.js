import React, { Component } from 'react';
import DevTools from '../components/DevTools';
import AppBar from 'material-ui/AppBar';

class App extends Component {
    render() {
        let { children } = this.props;

        return (
            <div>
                <AppBar title="Radiscope" />
                <div>
                    {children}
                </div>
                <DevTools />
            </div>
        );
    }
}

export default App;