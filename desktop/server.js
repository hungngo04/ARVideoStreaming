const express = require('express');
const http = require('http');
const socketIO = require('socket.io');
const { v4: uuidV4 } = require('uuid');

const app = express();
const server = http.Server(app);
const io = socketIO(server);

app.set('view engine', 'ejs');
app.use(express.static('public'));

app.get('/', (req, res) => {
    res.redirect(`/${uuidV4()}`);
});

app.get('/:meeting', (req, res) => {
    res.render('room', { meetingId: req.params.meeting });
});

io.on('connection', (socket) => {
    socket.on('join-room', (roomId, userId) => {
        console.log(roomId, userId);
        socket.join(roomId);
        socket.to(roomId).emit('user-connected', userId);
    });
});

server.listen(8080, () => console.log('Server is running on port 8080'));
