@extends('layouts.app', ['min' => true])

@section('body-class', 'widget_without_pay')

@section('content')
    <div id="vue-withoutpay" class="widget-part mx-auto">
        <div class="row no-gutters h-100">
            <div class="col">
                <div class="right-content">
                    <template>
                        <info-event />
                    </template>
                    <template>
                        <new-top-sidebar/>
                    </template>
                    <div class="content-part">
                        <router-view/>
                    </div>
                    <div class="bottom-part d-md-block d-none">
                        <bottom-part/>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@section('footer')
    <script src="https://widget.cloudpayments.ru/bundles/cloudpayments"></script>
    <script>
        (function () {
            var str = window.location.hash;
            var pars = new URLSearchParams(str);
            var addclass = pars.get('additional_class');
            if(addclass) {
                var element = document.getElementById("body");
                element.classList.add(addclass);
            }
        })();
    </script>
@endsection
