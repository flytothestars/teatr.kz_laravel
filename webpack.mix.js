const mix = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

mix.js('resources/js/widget.js', 'public/js')
    .js('resources/js/widget_without_pay.js', 'public/js')
    .js('resources/js/new_widget.js', 'public/js')
    .js('resources/js/admin.js', 'public/js')
    .js('resources/js/site.js', 'public/js')
    .js('resources/js/iframe.js', 'public/js')
    .sass('resources/sass/app.scss', 'public/css')
    .sass('resources/sass/admin.scss', 'public/css')
    .sass('resources/sass/widget/iframe.scss', 'public/css')
    .version()
    .override(config => {
        config.module.rules.find(rule =>
            rule.test.test('.svg')
        ).exclude = /\.svg$/;

        config.module.rules.push({
            test: /\.svg$/,
            use: [{ loader: 'vue-svg-loader'}]
        })
    })
    .sourceMaps();
