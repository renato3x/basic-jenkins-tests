import express from 'express';
import { client } from './redis';

const app = express();

app.get('/', async (_request, response) => {
  const visits = await client
    .get('visits')
    .then(value => (parseInt(value || '0') + 1)); 

  await client.set('visits', visits);

  return response.json({ visits });
});

export { app };
