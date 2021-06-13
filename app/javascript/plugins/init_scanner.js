import Quagga from 'quagga';

const initScanner = () => {

    function order_by_occurrence(arr) {
        var counts = {};
        arr.forEach(function(value){
            if(!counts[value]) {
                counts[value] = 0;
            }
            counts[value]++;
        });
        return Object.keys(counts).sort(function(curKey,nextKey) {
            return counts[curKey] > counts[nextKey];
        });
    }
      
    function load_quagga(){
        if ($('#barcode-scanner').length > 0 && navigator.mediaDevices && typeof navigator.mediaDevices.getUserMedia === 'function') {
      
          var last_result = [];
          if (Quagga.initialized == undefined) {
            Quagga.onDetected(function(result) {
              var last_code = result.codeResult.code;
              last_result.push(last_code);
              if (last_result.length > 8) {
                // au bout de 8 photos, il met la barre en vert pour dire "ok mec, j'ai trouvé un truc"
                document.querySelector('#panel-body').classList.add('code-detected');
                // sur les 8 photos, je récupère l'occurrence qui a été le plus souvent détecté
                const code = order_by_occurrence(last_result)[0];
                // je réinitialise mon tableau pour les prochains scans
                last_result = [];

                // log du code produit identifié
                console.log(code);

                // je fais un check de la page avec le code produit vers OpenFoodFact
                fetch('https://world.openfoodfacts.org/api/v0/product/' + code + '.json')
                  // si j'ai un résultat (et spoiler alert, tu en auras toujours un)
                  .then(res => {
                    // j'ai un résultat, mais je ne peux pas le traiter 
                    // je le transforme donc en JSON (comme un tableau)
                    res.json().then(t1 => { 
                      // Si mon json me renvoie un statut 1 => c'est que le produit EXISTE REELLEMENT chez Open Food
                      if(t1.status == 1) {
                        // on arrête le scanner pour dire "je coupe la caméra"
                        Quagga.stop();
                        // on redirige vers la fiche produit
                        window.location.href = `/products/${t1.code}`; 
                      }
                    });
                    // console.log(res.json().then(t1 => { console.log(t1); }));
                  })
                  .catch((out) => {
                    console.log('Output: ', out);
                  })
              }
            });
          }
      
          Quagga.init({
            inputStream : {
              name : "Live",
              type : "LiveStream",
              numOfWorkers: 4,
              target: document.querySelector('#barcode-scanner')
            },
            decoder: {
                readers : ['ean_reader']
            }
          },function(err) {
              if (err) { console.log(err); return }
              Quagga.initialized = true;
              Quagga.start();
          });
      
        }
    };  
    
    load_quagga();
}

export { initScanner };
