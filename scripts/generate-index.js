import { readFileSync, writeFileSync } from "fs";

const ticketsData = readFileSync("data/tickets.json", "utf8");
const tickets = JSON.parse(ticketsData);
const ticketCount = tickets.length;

const uniqueTicketIds = new Set();
tickets.forEach((ticket) => {
  const data = ticket.value.split("/");
  uniqueTicketIds.add(data[6]);
});
const uniqueTicketIdCount = uniqueTicketIds.size;

const beersData = readFileSync("data/beers.json", "utf8");
const beers = JSON.parse(beersData);
const beerCount = beers.length;

// Count the number of unique beer IDs
const uniqueBeerIds = new Set();
beers.forEach((beer) => {
  uniqueBeerIds.add(beer.value[2]);
});
const uniqueBeerIdCount = uniqueBeerIds.size;

// Create HTML page
const html = `
    <!DOCTYPE html>
    <html>
        <head>
        <title>Databeers GRX 2023</title>

                </head>
                <style>
                @import url('https://fonts.googleapis.com/css2?family=Josefin+Sans&display=swap');
                    body {
                        font-family: 'Fancy Typeface', cursive;
                    }

                    h1 {
                        font-size: 48px;
                    }

                    p {
                        font-size: 24px;
                    }
                </style>
                <body>
                <h1>DashBeer</h1>
                <p>${ticketCount} 🎫</p>
                <p>${uniqueTicketIdCount} 🎟️ 🧑</p>
                <p>${beerCount} 🍺</p>
                <p>${uniqueBeerIdCount} 🍻 🧑</p>
                </body>
            </html>
            `;

// Write HTML page to disk
writeFileSync("index.html", html);
