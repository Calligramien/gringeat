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
            return counts[curKey] < counts[nextKey];
        });
    }
      
    function load_quagga(){
        if ($('#barcode-scanner').length > 0 && navigator.mediaDevices && typeof navigator.mediaDevices.getUserMedia === 'function') {
      
          var last_result = [];
          if (Quagga.initialized == undefined) {
            Quagga.onDetected(function(result) {
                document.querySelector('#barcode-scanner').style.border = "3px solid green";

              var last_code = result.codeResult.code;
              last_result.push(last_code);
      
              if (last_result.length > 20) {
                const code = order_by_occurrence(last_result)[0];
                last_result = [];
                Quagga.stop();
                /* fetch()
                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open( "GET", `/product/${code}`, true ); // false for synchronous request
                xmlHttp.send( null ); */
                console.log(code)
                window.location.href = `/product/${code}`;
              }
            });
          }
      
          Quagga.init({
            inputStream : {
              name : "Live",
              type : "LiveStream",
              numOfWorkers: 1,
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
