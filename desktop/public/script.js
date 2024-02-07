const socket = io('/');
const webcamVideo = document.getElementById('webcam-video');
const myPeer = new Peer(undefined, {
    host: '/',
    port: '8001'
})

const myVideo = document.createElement('video');
myVideo.muted = true;

navigator.mediaDevices.getUserMedia({
    video: true,
    audio: true
}).then(stream => {
    addVideoStream(myVideo, stream);
})

myPeer.on('open', id => {
    socket.emit('join-room', MEETING_ID, id);
})

socket.on('user-connected', userId => {
    console.log("User connected: " + userId);
})

function addVideoStream(video, stream) {
    video.srcObject = stream;
    video.addEventListener('loadedmetadata', () => { 
        video.play();
    });
    webcamVideo.append(video);
}