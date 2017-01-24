/* global process */

var AutoPrefixer = require('autoprefixer');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var UnminifiedWebpackPlugin = require('unminified-webpack-plugin');
var Webpack = require('webpack');
var WebpackMerge = require('webpack-merge');


var npm_target = process.env.npm_lifecycle_event;
var environment;

if (npm_target === 'start') {
    environment = 'development';
} else {
    environment = 'production';
}

var common = {
    entry: {
        app: './app.js'
    },

    resolve: {
        modulesDirectories: ['node_modules'],
        extensions: ['', '.js', '.elm']
    },

    module: {
        loaders: [
          {
            test: /\.json$/,
            loader: 'json'
          }, {
            test: /\.(jpg|eot|svg|ttf|woff|woff2)(\?v=\d+\.\d+\.\d+)?/,
            loader: 'file-loader'
          }, {
            test: /\.(scss)$/,
            loaders: [
              'style-loader',
              'css-loader',
              'postcss-loader',
              'sass-loader'
            ]
          }
        ],

        noParse: /^(?!.*Stylesheets).*\.elm$/
    },

    plugins: [
        new HtmlWebpackPlugin({
            template: 'index.tpl.html'
        }),
        new Webpack.optimize.CommonsChunkPlugin({
            name: "init",
            minChunks: Infinity
        }),
        new Webpack.optimize.OccurenceOrderPlugin()
    ],

    postcss: [AutoPrefixer({
        browsers: ['last 2 versions']
    })],

    target: 'web'
};

var extractCssVendor = null;

if (environment === 'development') {
    console.log('running development');
    extractCssVendor = new ExtractTextPlugin('vendor.css');

    var devOnly = {
        output: {
            filename: '[name].js'
        },

        module: {
            loaders: [
                {
                    test: /src\/Stylesheets.elm$/,
                    loaders: [
                        'style-loader',
                        'css-loader',
                        'postcss-loader',
                        'elm-css-webpack-loader'
                    ]
                },

                {
                    test: /\.elm$/,
                    exclude: [
                        /elm-stuff/,
                        /node_modules/,
                        /src\/Stylesheets.elm$/
                    ],
                    loaders: [
                        'elm-hot-loader',
                        'elm-webpack-loader'
                    ]
                },

                {
                    test: /\.css$/,
                    loader: extractCssVendor.extract('style-loader', 'css-loader')
                }
            ]
        },

        plugins: [
            extractCssVendor
        ],

        devServer: {
            contentBase: '',
            devtool: 'eval',
            stats: 'errors-only',
            hot: true,
            inline: true,
            progress: true,
            historyApiFallback: true,
            port: 8000,
            host: 'localhost',
            proxy: {

            }
        }
    };

    module.exports = WebpackMerge(common, devOnly);
} else {
    console.log('building for production');
    var extractCssApp = new ExtractTextPlugin('app-[chunkhash].css', {
        allChunks: true
    });
    extractCssVendor = new ExtractTextPlugin('vendor-[chunkhash].css');

    var prodOnly = {
        output: {
            path: './dist',
            filename: '[name]-[chunkhash].min.js',
            chunkFilename: '[name]-[chunkhash].min.js'
        },

        module: {
            loaders: [
                {
                    test: /src\/Stylesheets.elm/,
                    loader: extractCssApp.extract(
                        'style-loader', [
                            'css-loader',
                            'postcss-loader',
                            'elm-css-webpack-loader'
                        ])
                },

                {
                    test: /\.elm$/,
                    exclude: [
                        /elm-stuff/,
                        /node_modules/,
                        /src\/Stylesheets.elm$/
                    ],
                    loader: 'elm-webpack-loader'
                },

                {
                    test: /\.css$/,
                    loader: extractCssVendor.extract('style-loader', 'css-loader')
                }
            ]
        },

        plugins: [
            new CopyWebpackPlugin([{
                from: 'src/index.html'
            }, {
                from: 'src/assets',
                to: 'assets'
            }]),
            extractCssApp,
            extractCssVendor,
            new UnminifiedWebpackPlugin(),
            new Webpack.optimize.UglifyJsPlugin({
                compress: {
                    warnings: false
                }
            })
        ]
    };

    module.exports = WebpackMerge(common, prodOnly);
}