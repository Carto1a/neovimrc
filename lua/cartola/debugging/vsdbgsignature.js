const vscode_path = process.argv[2];
const token = process.argv[3];

if (!vscode_path || !token) {
    console.error("vscode path empty or token empty");
    process.exit(1);
}

const vsda_location = `${vscode_path}/resources/app/node_modules.asar.unpacked/vsda/build/Release/vsda.node`;
const a = require(vsda_location);
const signer = new a.signer();
const signature = signer.sign(token);
console.log(signature)
