export let storeCodes: string[];

function updateStoreCodes() {
  let codeBundle: string[] = [];
  for (let i = 0; i < 200; i++) {
    codeBundle.push(i.toString());
  }
  storeCodes = codeBundle;
}

updateStoreCodes();
