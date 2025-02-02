import 'dotenv/config';
import { app } from './app';
import { client } from './redis';

async function main() {
  await client.connect()
    .then(() => {
      console.log('connected with redis');
    });


  app.listen(3000, () => {
    console.log('Server open in http://localhost:3000/')
  });
}

main();
