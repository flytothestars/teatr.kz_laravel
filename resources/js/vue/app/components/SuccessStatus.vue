<template>
    <div  class="success-status">
        <div class="success-icon">
            <img style="height: 50px; width: 50px;" class="mb-5" src="../../../../img/checked.png" alt="">
        </div>
        <div class="success-message">
            <h1>Спасибо!</h1>
            <p>Ваша оплата прошла успешно - билеты будут отправлены Вам на указанный email.</p>
        </div>
    </div>
</template>

<script>
import { mapState } from "vuex";
import moment from "moment";

export default {
    name: "SuccessStatus",
    computed: {
        ...mapState([
            "cart",
            "timetable",
            "order",
            "event",
            "user",
            "checkouttime",
            "userphone",
            "useremail",
            "venue",
        ]),
    },
    created() {
        this.$store.commit("setStep", 4);
    },
    methods: {
        
    },
    data() {
        return {
        };
    },
};
</script>

<style scoped>
.success-status {
    margin-top: 150px;
    align-items: center;
    justify-content: center; 
}
.success-message {
    h1 {
        font-size: 24px;
        margin-bottom: 10px;
    }

    p {
        font-size: 18px;
    }
}
</style>
