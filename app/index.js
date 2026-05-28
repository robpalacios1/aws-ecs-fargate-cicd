const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 80;

// Statics files from public folder
app.use(express.static(path.join(__dirname, 'public')));

//  Path to obtain dynamics metadata from container in realtime
app.get('/api/info', (req, res) => {
  res.json({
    status: "ONLINE",
    environment: "Development (dev)",
    platform: "AWS ECS Fargate",
    region: "us-east-1",
    engine: `Node.js ${process.version}`,
    uptime: process.uptime()
  });
});

app.listen(PORT, () => {
  console.log(`Application successfully running on port ${PORT}`);
});