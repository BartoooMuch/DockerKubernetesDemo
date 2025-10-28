const express = require('express');
const os = require('os');
const app = express();
const port = 8080;

// Pod bilgisi
const hostname = os.hostname();
const podName = hostname;
const startTime = new Date().toISOString();

// Ana sayfa
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

// API endpoint - pod bilgisi ver
app.get('/api/pod-info', (req, res) => {
    res.json({
        podName: podName,
        hostname: hostname,
        uptime: process.uptime(),
        timestamp: new Date().toISOString(),
        clientIp: req.ip,
        userAgent: req.get('user-agent')
    });
});

// Health check
app.get('/health', (req, res) => {
    res.json({ status: 'healthy', pod: podName });
});

app.listen(port, '0.0.0.0', () => {
    console.log(`Demo app running on ${hostname}:${port}`);
});
