export default function initMap(token, type, flyendCallback) {
    console.log(token);
    mapboxgl.accessToken = token;
    let options = {
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v12',
        projection: 'globe', // Display the map as a globe, since satellite-v9 defaults to Mercator
        zoom: 1.5,
        center: [130, 40]
    };
    if (type === 'streets') {
        options = {
            container: 'map',
            style: 'mapbox://styles/mapbox/streets-v12',
            zoom: 12,
            center: [132.7445942, 35.3665752]
        };
    }
    const map = new mapboxgl.Map(options);

    // const izumo = {
    //     center: [132.7445942, 35.3665752],
    //     zoom: 12.5,
    //     bearing: 90,
    //     pitch: 80
    // };

    // const topView = {
    //     center: [132.7445942, 35.3665752],
    //     zoom: 12.5,
    //     bearing: 0,
    //     pitch: 0
    // };

    // // let isAtStart = true;
 
    // document.getElementById('fly').addEventListener('click', () => {
    // // depending on whether we're currently at point a or b,
    // // aim for point a or b
    // // const target = isAtStart ? end : start;
    // // isAtStart = !isAtStart;

    //     map.flyTo({
    //         ...izumo, // Fly to the selected target
    //         duration: 5000, // Animate over 12 seconds
    //         essential: true // This animation is considered essential with
    //         //respect to prefers-reduced-motion
    //     });

    //     event.target.style.display = 'none';
    // });

    map.on('style.load', () => {
        map.setFog({}); // Set the default atmosphere style
    });

    // The following values can be changed to control rotation speed:

    // At low zooms, complete a revolution every two minutes.
    const secondsPerRevolution = 120;
    // Above zoom level 5, do not rotate.
    const maxSpinZoom = 5;
    // Rotate at intermediate speeds between zoom levels 3 and 5.
    const slowSpinZoom = 3;

    let userInteracting = false;
    let spinEnabled = true;

    function spinGlobe() {
        const zoom = map.getZoom();
        if (spinEnabled && !userInteracting && zoom < maxSpinZoom) {
            let distancePerSecond = 360 / secondsPerRevolution;
            if (zoom > slowSpinZoom) {
                // Slow spinning at higher zooms
                const zoomDif =
                    (maxSpinZoom - zoom) / (maxSpinZoom - slowSpinZoom);
                distancePerSecond *= zoomDif;
            }
            const center = map.getCenter();
            center.lng -= distancePerSecond;
            // Smoothly animate the map over one second.
            // When this animation is complete, it calls a 'moveend' event.
            map.easeTo({ center, duration: 1000, easing: (n) => n });
        }
    }

    // Pause spinning on interaction
    map.on('mousedown', () => {
        userInteracting = true;
    });

    // Restart spinning the globe when interaction is complete
    map.on('mouseup', () => {
        userInteracting = false;
        spinGlobe();
    });

    // These events account for cases where the mouse has moved
    // off the map, so 'mouseup' will not be fired.
    map.on('dragend', () => {
        userInteracting = false;
        spinGlobe();
    });
    map.on('pitchend', () => {
        userInteracting = false;
        spinGlobe();
    });
    map.on('rotateend', () => {
        userInteracting = false;
        spinGlobe();
    });

    // When animation is complete, start spinning if there is no ongoing interaction
    map.on('moveend', () => {
        spinGlobe();
    });

    map.on('pitchend', () => {
        flyendCallback();
    });

    spinGlobe();
    return map;
}