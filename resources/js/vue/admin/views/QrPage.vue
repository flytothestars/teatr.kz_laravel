<!-- <template>
    <div>
      <video ref="video" width="50%" height="50%" autoplay willReadFrequently="true"></video>
    </div>
  </template>
  
  <script>
  import Quagga from 'quagga';
  
  export default {
    mounted() {
      this.initCamera();
    },
    methods: {
      initCamera() {
        if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
          navigator.mediaDevices.getUserMedia({ video: true })
            .then((stream) => {
              this.$refs.video.srcObject = stream;
              this.startScan();
            })
            .catch((err) => {
              console.error('Could not access the camera: ', err);
            });
        } else {
          console.error('getUserMedia is not supported by this browser');
        }
      },
      startScan() {
        Quagga.init({
          inputStream: {
            name: "Live",
            type: "LiveStream",
            target: this.$refs.video
          },
          decoder: {
            readers: ["code_128_reader", "ean_reader", "ean_8_reader", "code_39_reader", "code_39_vin_reader", "codabar_reader", "upc_reader", "upc_e_reader", "i2of5_reader", "2of5_reader", "code_93_reader"],
          }
        }, (err) => {
          if (err) {
            console.error('Failed to initialize Quagga: ', err);
            return;
          }
          Quagga.start();
        });
        Quagga.onDetected(this.onDetect);
      },
      onDetect(result) {
        console.log('Detected code:', result.codeResult.code);
        // Делайте что-то с результатом сканирования, например, отправляйте на сервер
      }
    }
  };
  </script>
   -->




<!-- <template>
    <div>
        <div>
            <h1>QR Code Scanner</h1>
        </div>
    </div>
</template>
  
<script>
export default {
    data() {
      return {
      }
    },
    components: {
    },
};
</script> -->


<template>
  <div class="container">
    <h1 style="text-align: center;">QR сканер</h1>
    <div  style="text-align: center;">
      <button class="btn btn-primary mb-4" @click="startScanner">Начать сканирование</button>
    </div>
    <div class="qr-code-container" id="qr_code_scanner"></div>
    <div v-if="buttonCheck" class="ticket-details">
      <p>{{ title }}</p>
      <p>Дата и время: {{ datetime }}</p>
      <p>Ряд: {{ row }}, место: {{ seat }}</p>
      <p>Цена: {{ price }}</p>
      <button v-if="buttonSubmit" class="btn btn-primary" @click="successTicket">Подтвердить</button>
      <p class="status" :style="paragraphStyle">{{ msg }}</p>
    </div>
  </div>
</template>

<script>
import { Html5Qrcode } from 'html5-qrcode'
export default {
  data() {
    return {
      result: '',
      row: '',
      seat: '',
      price: '',
      datetime: '',
      title: '',
      buttonCheck: false,
      buttonSubmit: true,
      msg: '',
      qrreader: null,
    }
  },
  computed: {
    paragraphStyle() {
      return {
        color: this.buttonSubmit ? 'black' : 'white',
        backgroundColor: this.buttonSubmit ? 'yellow' : 'green',
      };
    }
  },
  methods: {
    successTicket() {
      console.log('checked')
      axios.post(`/api/order/${this.result}/check`).then(res => {
        console.log(res.data.data)
        if (res.data.success) {
          this.row = '',
            this.seat = '',
            this.price = '',
            this.datetime = '',
            this.title = '',
            this.buttonCheck = false,
            this.msg = res.data.msg
        }
        else {
          this.msg = res.data.msg
        }
      })
    },
    startScanner() {
      this.buttonCheck = false
      this.qrreader.start(
        { facingMode: { exact: "environment" } }, {
          fps: 10,
          qrbox: {
            width: 250,
            height: 250
          }
        },
        this.onScanSuccess,
      ).catch(console.error);
    },
    stopScanner() {
      this.qrreader.stop().catch(console.error);
    },
    createscanqrcodes() {
      this.qrreader = new Html5Qrcode("qr_code_scanner");
      // const qrConstraints = {
      //   facingMode: "environment"
      // };
      // const qrConfig = {
      //   fps: 10,
      //   qrbox: {
      //     width: 250,
      //     height: 250
      //   }
      // };
      // const qrOnSuccess = (decodedText, decodedResult) => {
      //   stopScanner(); // Stop the scanner
      //   console.log(`Message: ${decodedText}, Result: ${JSON.stringify(decodedResult)}`);
      //   $("#barcode_search").val(decodedText); // Set the value of the barcode field
      //   $("#update_form").trigger("submit"); // Submit form to backend
      // };

      // const startScanner = () => {
      //   qrReader.start(
      //     qrConstraints,
      //     qrConfig,
      //     qrOnSuccess,
      //   ).catch(console.error);
      // };

      // const stopScanner = () => {
      //   $("#reader").hide();
      //   $("#product_info").show();
      //   qrReader.stop().catch(console.error);
      // };
      // const html5QrCodes = new Html5Qrcode("qr_code_scanner");

      // html5QrCodes.start({ facingMode: { exact: "environment" } }, {
      //   fps: 10,
      //   qrbox: {
      //     width: 250,
      //     height: 250
      //   }
      // }, this.onScanSuccess)
    },

    onScanSuccess(resultde) {
      this.result = resultde;
      console.log(this.result)
      this.stopScanner()
      axios.post(`/api/order/${this.result}/ticket`).then(res => {
        console.log('success')
        console.log(res.data)
        this.price = res.data.data.price
        this.row = res.data.data.row
        this.seat = res.data.data.seat
        this.title = res.data.data.timetable.event.title.ru
        this.datetime = res.data.data.timetable.formatted_date
        this.msg = res.data.msg
        this.buttonSubmit = res.data.success
        this.buttonCheck = true
      })
    }

  },
  mounted() {
    this.createscanqrcodes();
  },
};
</script>

<style scoped>
.container {
  margin: 20px;
}

.qr-code-container {
  width: 100%;
  max-width: 300px;
  margin: 0 auto;
}
.status {
  text-align: center;
  margin-top: 20px;
  padding: 10px;
  size: 20px;
}
.ticket-details {
  margin-top: 20px;
  text-align: center;
}

.ticket-details p {
  size: 16px;
}

.ticket-details button {
  margin-top: 10px;
}
</style>
