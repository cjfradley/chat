const elixir 	= require( "coldbox-elixir" );
const webpack 	= require( "webpack" );

elixir.config.mergeConfig({
    plugins: [
        // globally scoped items which need to be available in all templates
        new webpack.ProvidePlugin({
            "Vue"          : ["vue/dist/vue.esm.js", "default"],
            "window.Vue"   : ["vue/dist/vue.esm.js", "default"]
        })
    ]
});
/*
 |--------------------------------------------------------------------------
 | Elixir Asset Management
 |--------------------------------------------------------------------------
 |
 | Elixir provides a clean, fluent API for defining some basic Gulp tasks
 | for your ColdBox application. By default, we are compiling the Sass
 | file for our application, as well as publishing vendor resources.
 |
 */

module.exports = elixir( function( mix ) {

	// Mix App styles
	mix.sass( "app.scss" );
    
    // mix vue js
    mix.vue( "app.js" );
    
    // start browser sync
    mix.browserSync({
        proxy: 'http://127.0.0.1:54905/'
    });
} );
