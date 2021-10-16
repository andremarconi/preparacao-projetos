const path = require('path');

module.exports = {
  mode: 'development',
  entry: './app/assets/scripts/app.js',
  output: {
    filename: 'bundled.js',
    path: path.resolve(__dirname, 'app'),
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'app'),
    },
    port: 5000,
    hot: true,
    host: '0.0.0.0',
  },
  module: {
    rules: [
      {
        test: /\.(sa|sc|c)ss$/,
        use: [
          'style-loader',
          { loader: 'css-loader', options: { url: false } },
          'sass-loader',
        ],
      },
    ],
  },
};
