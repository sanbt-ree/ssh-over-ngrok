require("dotenv").config();
const ngrok = require("ngrok");

(async function () {
  let url;

  setTimeout(() => {
    console.log("url", url);
    if (!url) {
      process.exit();
    }
  }, 10000);

  url = await ngrok.connect({
    proto: "tcp",
    addr: 22, // ssh port
    authtoken: process.env.NGROK_AUTH_TOKEN,
    region: process.env.NGROK_REGION,
  });
  console.log(Date(), url);
})();
