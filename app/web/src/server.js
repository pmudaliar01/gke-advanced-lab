const express = require('express');
const app = express();
app.get('/', (req, res) => {
  res.json({ message: 'Hello from WEB' });
});
app.get('/healthz', (req, res) => res.send('ok'));
app.get('/livez', (req, res) => res.send('alive'));
const port = process.env.PORT || 8080;
app.listen(port, () => console.log(`WEB listening on ${port}`));
