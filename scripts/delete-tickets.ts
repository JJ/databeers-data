const kv = await Deno.openKv(
  "https://api.deno.com/databases/a9411d4b-22fd-4278-be62-e7ac390d31c2/connect"
);

const tickets = await kv.list<string>({ prefix: ["tickets"] });
for await (const ticket of tickets) {
  await kv.delete(ticket.key);
}

const beers = await kv.list<string>({ prefix: ["beers"] });
const loggedBeers = [];
for await (const beer of beers) {
  await kv.delete(beer.key);
}
