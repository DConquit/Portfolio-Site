import React from 'react';
import DesktopIcon from './DesktopIcon';

export default class Desktop extends React.Component {
    render() {
        return (
            <div id="desktop">
                <DesktopIcon iconTitle="About Me"
                             iconImgSml="./src/img/aboutMeSml.png"
                             iconImgLrg="./img/aboutMeLrg.png"/>
            </div>
        );
    }
}