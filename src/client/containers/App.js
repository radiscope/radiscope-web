import React, { Component } from 'react';
import DevTools from '../components/DevTools';
import { AppBar, Card } from 'material-ui';
import NavigationDrawer from '../components/NavigationDrawer';
import { Grid } from 'react-flexbox-grid';

const isMobile = () => {
    if (navigator.userAgent) {
        return (/Android|webOS|iPhone|iPad|iPod|BlackBerry|Mobile/i.test(navigator.userAgent));
    }

    return false;
};

class App extends Component {

    state = {
        drawerResize: false,
        drawerOpen: (isMobile())? false : true,
        drawerWidth: null,
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

    handleDrawerResize = () => {
        let isDrawerResize = this.state.drawerResize;

        if (isDrawerResize) {
            this.setState({
                drawerWidth: null,
                drawerResize: false
            });
        } else {
            this.setState({
                drawerWidth: 75,
                drawerResize: true
            })
        }
    };

    handleMargin = () => {
        let isDrawerOpen = this.state.drawerOpen;
        let drawerWidth = this.state.drawerWidth;

        if (isDrawerOpen && drawerWidth && !isMobile()) {
            let width = drawerWidth + 25;

            return {
	            marginLeft: `${width}px`,
	            marginTop: "20px",
	            marginRight: "20px",
	            marginBottom: "20px"
            }
        } else if (isDrawerOpen && !isMobile()) {
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
        let { drawerOpen, drawerWidth, width, height, drawerResize } = this.state;

        let containerStyle = {
            height: `${(height - 96)}px`,
            width: drawerOpen? `${(width - 320)}px` : `${(width - 40)}px`,
            transition: `${width} 300ms ease-in-out, ${height} 300ms ease-in-out`
        };

        return (
            <div>
                <AppBar
                    title='Radiscope'
                    onLeftIconButtonTouchTap={this.handleMenuTouch}
                />
	            <NavigationDrawer
		            drawerResize={drawerResize}
		            drawerOpen={drawerOpen}
		            drawerWidth={drawerWidth}
		            handleResize={this.handleDrawerResize}
	            />
	            <Grid style={this.handleMargin()}>
		            <Card containerStyle={containerStyle}>
			            {children}
			        </Card>
	            </Grid>
	            <DevTools />
            </div>
        );
    }
}

export default App;