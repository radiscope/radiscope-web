import React, { Component } from 'react';
import DevTools from '../components/DevTools';
import { AppBar, Drawer, Card } from 'material-ui';
import { Grid } from 'react-flexbox-grid';

const isMobile = () => {
    if (navigator.userAgent) {
        return (/Android|webOS|iPhone|iPad|iPod|BlackBerry|Mobile/i.test(navigator.userAgent));
    }

    return false;
};

class App extends Component {

    state = {
        drawerOpen: (isMobile())? false : true,
        width: document.body.clientWidth,
        height: document.body.clientHeight
    };

    handleMenuTouch = (event) => {
        let isDrawerOpen = this.state.drawerOpen;

        if (isDrawerOpen) {
            this.setState({ drawerOpen: false });
        } else {
            this.setState({ drawerOpen: true });
        }
    };

    handleResize = (event) => {
        this.setState({
            width: document.body.clientWidth,
            height: document.body.clientHeight
        });
    };

    handleMargin = () => {
        let isDrawerOpen = this.state.drawerOpen;

        if (isDrawerOpen && !isMobile()) {
            return {
                marginLeft: "280px",
                marginTop: "20px",
                marginRight: "20px",
                marginBottom: "20px"
            }
        } else {
            return {
                margin: "20px"
            }
        }
    };

    componentDidMount() {
        window.addEventListener('resize', this.handleResize);
    }

    componentWillUnmount() {
        window.removeEventListener('resize', this.handleResize);
    }

    render() {
        let { children } = this.props;
        let { drawerOpen, width, height } = this.state;

        return (
            <div>
                <AppBar
                    title='Radiscope'
                    onLeftIconButtonTouchTap={this.handleMenuTouch}
                />
                <Drawer
                    open={drawerOpen}
                    containerClassName='drawer-container'
                />
                <Grid style={this.handleMargin()}>
                    <Card containerStyle={{ height: `${(height - 76)}px`, width: drawerOpen? `${(width - 300)}px` : `${(width - 20)}px` }}>
                        {children}
                    </Card>
                </Grid>
                <DevTools />
            </div>
        );
    }
}

export default App;