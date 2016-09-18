import React, {Component} from 'react';
import {Card, CardActions, CardHeader, CardMedia, CardTitle, CardText} from 'material-ui/Card';
import RaisedButton from 'material-ui/RaisedButton';

class Login extends Component {

    render() {

        let actionStyle = {
            padding: 16
        };

        return <div style={{width: 400, margin: '50px auto'}}>
            <Card>
                <CardTitle title="Sign in" subtitle="to Radiscope"/>
                <CardActions style={actionStyle}>
                    <RaisedButton label="Sign in with Google" fullWidth={true} primary={true} href="/auth/google"/>
                </CardActions>
            </Card>
        </div>
    }
}

export default Login;