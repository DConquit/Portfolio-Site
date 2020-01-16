import React from 'react';
import DesktopIcon from './DesktopIcon';

export default class Desktop extends React.Component {
    state = {
        applications: [{
            appNo: 0,
            title: "About Me",
            iconSml: "./src/img/aboutMeSml.png",
            iconLrg: "./src/img/aboutMeLrg.png",
            winIconSml: "./src/img/aboutMeWinSml.png",
            winIconLrg: "./src/img/aboutMeWinLrg.png",
            appOpen: false,
            winOpen: false,
            winMaximized: false
        }, {
            appNo: 1,
            title: "Resume",
            iconSml: "./src/img/resumeSml.png",
            iconLrg: "./src/img/resumeLrg.png",
            winIconSml: "./src/img/resumeWinSml.png",
            winIconLrg: "./src/img/resumeWinLrg.png",
            appOpen: false,
            winOpen: false,
            winMaximized: false
        }, {
            appNo: 2,
            title: "Projects",
            iconSml: "./src/img/projectsSml.png",
            iconLrg: "./src/img/projectsLrg.png",
            winIconSml: "./src/img/projectsWinSml.png",
            winIconLrg: "./src/img/projectsWinLrg.png",
            appOpen: false,
            winOpen: false,
            winMaximized: false
        }, {
            appNo: 3,
            title: "Contact Me",
            iconSml: "./src/img/contactMeSml.png",
            iconLrg: "./src/img/contactMeLrg.png",
            winIconSml: "./src/img/contactMeWinSml.png",
            winIconLrg: "./src/img/contactMeWinLrg.png",
            appOpen: false,
            winOpen: false,
            winMaximized: false
        }, {
            appNo: 4,
            title: "Settings",
            iconSml: "./src/img/settingsSml.png",
            iconLrg: "./src/img/settingsLrg.png",
            winIconSml: "./src/img/settingsWinSml.png",
            winIconLrg: "./src/img/settingsWinLrg.png",
            appOpen: false,
            winOpen: false,
            winMaximized: false
        }]
    }

    openApplication = (appDetails) => {
        this.setState(() => {
            console.log(this.state.applications[appDetails.appNo].appOpen);
            this.state.applications[appDetails.appNo].appOpen = true;
            console.log(this.state.applications[appDetails.appNo].appOpen);
            this.state.applications[appDetails.appNo].winOpen = true;
        })
        return;
    };

    render() {
        return (
            <div id="desktop">
                {/* <DesktopIcon iconTitle="About Me"
                             iconImgSml="./src/img/aboutMeSml.png"
                             iconImgLrg="./img/aboutMeLrg.png"/> */}


                {this.state.applications.map((application, index) => (
                    <DesktopIcon appDetails={application} 
                                 key={index}
                                 openApplication={this.openApplication}/>
                ))}
            </div>
        );
    }
}