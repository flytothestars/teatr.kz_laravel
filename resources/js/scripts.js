$(function() {

    $('#search-header').click(() => {
        $(body).toggleClass('search')
    })

    $('.search-block').click((e) => {
        if(e.target.classList.contains("search-block")) {
            $(body).toggleClass('search')
        }
    })

    $('.select2').select2({
        dropdownParent: $(".select2-wrapper")
    });

    // $('#city-select').change(async (e) => {
    //     const id = e.target.value
    //     await axios.post('/city/update', { id: id })
    //     location.reload()
    // })

    $('.mob-menu-toggler').click(function() {
        $('body').toggleClass('mobile-menu-opened');
    });

    $('.city-select').click(async function() {
        const id = $(this).data('city')
        await axios.post('/city/update', { id: id })
        location.reload()
    })

    if($('.venues-swiper').length > 0) {
        new Swiper('.venues-swiper', {
            loop: false,
            slidesPerView: 3,
            breakpoints: {
                0: {
                    slidesPerView: 1.5,
                    spaceBetween: 20
                },
                768: {
                    slidesPerView: 3,
                    spaceBetween: 30
                },
            },
            navigation: {
                nextEl: '.swiper-venues-next',
                prevEl: '.swiper-venues-prev',
            },
        })
    }

    if($('.feedbacks-swiper').length > 0) {
        new Swiper('.feedbacks-swiper', {
            loop: false,
            slidesPerView: 2,
            breakpoints: {
                0: {
                    slidesPerView: 1,
                    spaceBetween: 30
                },
                768: {
                    slidesPerView: 2,
                    spaceBetween: 30
                }
            },
            navigation: {
                nextEl: '.swiper-feedbacks-next',
                prevEl: '.swiper-feedbacks-prev',
            },
        })
    }


})


// (function($, window){
//     var arrowWidth = 30;
//
//
//
// })(jQuery, window);
