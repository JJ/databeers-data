all: data

data:
	wget https://databeers-tickets.deno.dev/beers -O data/beers.json
	wget https://databeers-tickets.deno.dev/tickets -O data/tickets.json
