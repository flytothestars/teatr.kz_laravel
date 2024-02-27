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
    <h1>Qr scaner</h1>
    <div style="width:500px" id="qr_code_scanner"></div>
    <div v-if="buttonCheck">
      <p>{{ title }}</p>
      <p>Дата и время: {{ datetime }}</p>
      <p>Ряд: {{ row }}, место {{ seat }}</p>
      <p>Цена: {{ price }}</p>
      <button @click="successTicket">Подтвержден</button>
    </div>
    <p>{{msg}}</p>

    <div style="width:300px">
      <!-- <v-zxing @decode="onDecode" /> -->
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
      msg: ''
    }
  },

  methods: {
    successTicket()
    {
      console.log('checked')
      axios.post(`/api/order/${this.result}/check`).then(res => {
        console.log(res.data.data)
        if(res.data.success){
          this.row = '',
          this.seat = '',
          this.price = '',
          this.datetime = '',
          this.title = '',
          this.buttonCheck = false,
          this.msg = res.data.data
        }
        else{
          this.msg = res.data.data
        }
      })
    },
    onDecode(result) {
      console.log(result)
      this.result = result
    },
    createscanqrcodes() {
      const html5QrCodes = new Html5Qrcode("qr_code_scanner");

      html5QrCodes.start({ facingMode: { exact: "environment" } }, {
        fps: 10,
        qrbox: {
          width: 250,
          height: 250
        }
      }, this.onScanSuccess)
    },

    onScanSuccess(resultde) {
      this.result = resultde;
      console.log(this.result)
      axios.post(`/api/order/${this.result}/ticket`).then(res => {
        console.log('success')
        this.price = res.data.data.price
        this.row = res.data.data.row
        this.seat = res.data.data.seat
        this.title = res.data.data.timetable.event.title.ru
        this.datetime = res.data.data.timetable.formatted_date
        this.buttonCheck = true
        this.msg
      })
    }

  },
  mounted() {
    this.createscanqrcodes();
  },
};
</script>