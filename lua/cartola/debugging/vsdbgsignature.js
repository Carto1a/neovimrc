const path = process.argv.slice(2)[0];

const vsda_location = `${path}/resources/app/node_modules.asar.unpacked/vsda/build/Release/vsda.node`;
const a = require(vsda_location);
const signer = new a.signer();

process.argv.slice(3).forEach((value, index) => {
  if (index >= 2) {
    const r = signer.sign(value);
    console.log(r);
  }
});
