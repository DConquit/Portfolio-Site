import React from 'react';
import Draggable from 'react-draggable';

const DesktopIcon = props => (
    <Draggable
        handle='.handle'>
        <div className='desktopIcon'>
            <p className='handle'>Drag from here</p>
            <p onClick={props.openApplication(props.appDetails)}>Click me to open</p>
            <h3>{props.appDetails.title}</h3>
        </div>
    </Draggable>
);

export default DesktopIcon;