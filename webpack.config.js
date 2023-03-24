const path = require('path');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const HtmlWebpackPlugin = require('html-webpack-plugin');
const fse = require('fs-extra');

class RunAfterCompile {
    apply(compiler) {
        compiler.hooks.done.tap('Copy Images', function() {
            fse.copySync('./src/assets/images', './dist/assets/images')
        })
    }
}

let cssConfig = {
    test: /\.(sa|sc|c)ss$/,
    use: [
        { loader: 'css-loader', options: { url: false } },
        'sass-loader'
    ]
}

let pages = fse.readdirSync('./src').filter(function (file) {
    return file.endsWith('.html')
    }).map(function (page) {
        return new HtmlWebpackPlugin({
        filename: page,
        template: `./src/${page}`,
        inject: 'body',
        minify: false
    })
})

let config = {
    plugins: pages,
    entry: './src/assets/scripts/app.js',
    module: {
        rules: [
            cssConfig
        ]
    }
}

module.exports = (env, argv) => {
    if (argv.mode === 'development') {
        cssConfig.use.unshift('style-loader')
        config.output = {
            filename: 'bundled.js',
            path: path.resolve(__dirname, 'src')
        }
        config.devServer = {
            static: {
                directory: path.join(__dirname, 'src')
            },
            port: 5000,
            hot: true
        }
        config.mode = 'development'
    }

    if (argv.mode === 'production') {
        config.module.rules.push({
            test: /\.m?js$/,
            exclude: /node_modules/,
            use: {
                loader: 'babel-loader',
                options: {
                  presets: ['@babel/preset-env']
                }
            }
        })
        cssConfig.use.unshift(MiniCssExtractPlugin.loader)
        config.output = {
            filename: '[name].[chunkhash].js',
            chunkFilename: '[name].[chunkhash].js',
            clean: true,
            path: path.resolve(__dirname, 'dist')
        }
        config.mode = 'production'
        config.optimization = {
            splitChunks: { chunks: 'all', minSize: 1000 },
            minimize: true,
            minimizer: [`...`, new CssMinimizerPlugin()]
        }
        config.plugins.push(
            new MiniCssExtractPlugin({ filename: 'styles.[chunkhash].css' }),
            new RunAfterCompile()
        )
    }

    return config;
};
