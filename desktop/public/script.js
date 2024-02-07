const socket = io('/');
const myPeer = new Peer(undefined, {
    host: '/',
    port: '8001'
})

myPeer.on('open', id => {
    socket.emit('join-room', MEETING_ID, id);
})

socket.on('user-connected', userId => {
    console.log("User connected: " + userId);
})