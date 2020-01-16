import React from 'react';
import WindowHeader from './WindowHeader'


export default class Window extends React.Component {
    constructor(props) {
        super(props);

    }
    render() {
        <div className="window">
            <WindowHeader />
            <WindowContents />
        </div>
    }

}