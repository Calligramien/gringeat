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
                // After 8 photos, the scanner turns the bar green to say that it has found something.
                document.querySelector('#panel-body').classList.add('code-detected');
                // After 8 pictures, he turns the bar green to say that he has found something.
                const code = order_by_occurrence(last_result)[0];
                // I reset my table for the next scans.
                last_result = [];

                // Identified product code log
                console.log(code);

                // I check the page with the product code to OpenFoodFact API.
                fetch('https://world.openfoodfacts.org/api/v0/product/' + code + '.json')
                  // If I have a result (and spoiler alert, you will always have one).
                  .then(res => {
                    // I have a result, but I can't process it.
                    // So I transform it into JSON (like an array).
                    res.json().then(t1 => { 
                      // If my json returns a status of 1 => it means that the product REALLY EXISTS at OpenFoodFact API.
                      if(t1.status == 1) {
                        // We stop the scanner to say "I turn off the camera".
                        Quagga.stop();
                        // We redirect to the product sheet.
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
